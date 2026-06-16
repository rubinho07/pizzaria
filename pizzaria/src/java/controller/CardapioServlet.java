package controller;
import dao.*;
import decorator.*;
import model.*;
import strategy.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cardapio")
public class CardapioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String acao = req.getParameter("acao");
        if (acao == null) acao = "ver";

        switch (acao) {
            case "ver":
                req.setAttribute("pizzas", new PizzaDAO().listarDisponiveis());
                req.getRequestDispatcher("/cardapio.jsp").forward(req, resp);
                break;
            case "personalizar":
                int pizzaId = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("pizza", new PizzaDAO().buscarPorId(pizzaId));
                req.setAttribute("adicionais", new AdicionalDAO().listarTodos());
                req.getRequestDispatcher("/personalizar.jsp").forward(req, resp);
                break;
            case "pedido":
                req.getRequestDispatcher("/pedido.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect("cardapio");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String acao = req.getParameter("acao");

        if ("finalizar".equals(acao)) {
            finalizarPedido(req, resp);
        } else if ("adicionar".equals(acao)) {
            adicionarAoCarrinho(req, resp);
        }
    }

    /**
     * PROCESSO DE NEGOCIO: monta a pizza usando Decorators
     * e adiciona ao carrinho da sessao
     */
    private void adicionarAoCarrinho(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int pizzaId = Integer.parseInt(req.getParameter("pizzaId"));
        int quantidade = Integer.parseInt(req.getParameter("quantidade"));
        String observacao = req.getParameter("observacao");
        String[] adicionaisIds = req.getParameterValues("adicionais");
        String[] remocoes = req.getParameterValues("remover");
        boolean bordaRecheada = "true".equals(req.getParameter("bordaRecheada"));
        String tipoBorda = req.getParameter("tipoBorda");
        boolean upgradeGG = "true".equals(req.getParameter("upgradeGG"));

        Pizza pizza = new PizzaDAO().buscarPorId(pizzaId);

        // === APLICANDO DECORATORS ===
        PizzaPersonalizavel pizzaPersonalizada = new PizzaBase(pizza);

        // Decorator: Upgrade de tamanho
        if (upgradeGG) {
            pizzaPersonalizada = new TamanhoGrandeDecorator(pizzaPersonalizada);
        }

        // Decorator: Borda recheada
        if (bordaRecheada && tipoBorda != null && !tipoBorda.isEmpty()) {
            pizzaPersonalizada = new BordaRecheadaDecorator(pizzaPersonalizada, tipoBorda);
        }

        // Decorator: Adicionais extras
        if (adicionaisIds != null) {
            AdicionalDAO adicionalDAO = new AdicionalDAO();
            for (String idStr : adicionaisIds) {
                Adicional a = adicionalDAO.buscarPorId(Integer.parseInt(idStr));
                if (a != null && !"REMOCAO".equals(a.getTipo())) {
                    pizzaPersonalizada = new IngredienteExtraDecorator(
                        pizzaPersonalizada, a.getNome(), a.getPreco()
                    );
                }
            }
        }

        // Decorator: Remocoes (sem custo)
        if (remocoes != null) {
            for (String r : remocoes) {
                if (!r.trim().isEmpty()) {
                    pizzaPersonalizada = new RemoverIngredienteDecorator(pizzaPersonalizada, r);
                }
            }
        }

        // Monta o ItemPedido com resultado do Decorator
        ItemPedido item = new ItemPedido();
        item.setPizzaId(pizzaId);
        item.setNomePizza(pizzaPersonalizada.getNome());
        item.setQuantidade(quantidade);
        item.setPrecoUnitario(pizza.getPreco());
        item.setPrecoFinal(pizzaPersonalizada.getPreco());
        item.setSubtotal(pizzaPersonalizada.getPreco().multiply(BigDecimal.valueOf(quantidade)));
        item.setAdicionais(pizzaPersonalizada.getDescricao());
        item.setObservacao(observacao);

        // Adiciona ao carrinho na sessao
        List<ItemPedido> carrinho = (List<ItemPedido>) req.getSession().getAttribute("carrinho");
        if (carrinho == null) carrinho = new ArrayList<>();
        carrinho.add(item);
        req.getSession().setAttribute("carrinho", carrinho);

        resp.sendRedirect("cardapio?acao=ver&adicionado=true");
    }

    /**
     * PROCESSO DE NEGOCIO: finaliza o pedido usando Strategy de pagamento
     */
    private void finalizarPedido(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<ItemPedido> carrinho = (List<ItemPedido>) req.getSession().getAttribute("carrinho");
        if (carrinho == null || carrinho.isEmpty()) {
            resp.sendRedirect("cardapio");
            return;
        }

        String formaPagamento = req.getParameter("formaPagamento");

        // Calcula totais
        BigDecimal totalBruto = carrinho.stream()
            .map(ItemPedido::getSubtotal)
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Aplica desconto de 10% para PIX
        BigDecimal desconto = BigDecimal.ZERO;
        BigDecimal totalFinal = totalBruto;
        if ("PIX".equals(formaPagamento)) {
            DescontoDecorator dc = new DescontoDecorator(
                new PizzaBase(new Pizza()), new BigDecimal("10"), "Desconto PIX"
            );
            desconto = totalBruto.multiply(new BigDecimal("0.10"));
            totalFinal = totalBruto.subtract(desconto);
        }

        // Strategy de pagamento
        PagamentoStrategy strategy;
        switch (formaPagamento != null ? formaPagamento : "DINHEIRO") {
            case "PIX": strategy = new PagamentoPixStrategy(); break;
            case "CARTAO": strategy = new PagamentoCartaoStrategy(); break;
            default: strategy = new PagamentoDinheiroStrategy(); break;
        }

        String nomeCliente = req.getParameter("nomeCliente");
        strategy.processar(totalFinal, nomeCliente);

        // Salva pedido no banco
        Pedido pedido = new Pedido();
        pedido.setNomeCliente(nomeCliente);
        pedido.setTelefoneCliente(req.getParameter("telefone"));
        pedido.setEnderecoEntrega(req.getParameter("endereco"));
        pedido.setFormaPagamento(strategy.getNomePagamento());
        pedido.setStatus("AGUARDANDO");
        pedido.setTotalBruto(totalBruto);
        pedido.setTotalFinal(totalFinal);
        pedido.setDesconto(desconto);
        pedido.setObservacao(req.getParameter("observacao"));

        PedidoDAO dao = new PedidoDAO();
        int pedidoId = dao.inserir(pedido);

        for (ItemPedido item : carrinho) {
            item.setPedidoId(pedidoId);
            dao.inserirItem(item);
        }

        req.getSession().removeAttribute("carrinho");
        req.setAttribute("pedidoId", pedidoId);
        req.setAttribute("totalFinal", totalFinal);
        req.setAttribute("formaPagamento", strategy.getDescricao());
        req.getRequestDispatcher("/confirmacao.jsp").forward(req, resp);
    }
}
