package controller;
import dao.PizzaDAO;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/pizza")
public class PizzaServlet extends HttpServlet {

    private boolean isAdmin(HttpServletRequest req) {
        return req.getSession().getAttribute("admin") != null;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) { resp.sendRedirect(req.getContextPath()+"/login.jsp"); return; }
        String acao = req.getParameter("acao");
        if (acao == null) acao = "listar";
        PizzaDAO dao = new PizzaDAO();
        switch (acao) {
            case "listar":
                req.setAttribute("pizzas", dao.listarTodos());
                req.getRequestDispatcher("/admin/pizzas.jsp").forward(req, resp); break;
            case "nova":
                req.setAttribute("pizza", new Pizza());
                req.getRequestDispatcher("/admin/formPizza.jsp").forward(req, resp); break;
            case "editar":
                req.setAttribute("pizza", dao.buscarPorId(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("/admin/formPizza.jsp").forward(req, resp); break;
            case "excluir":
                dao.excluir(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect("pizza?acao=listar"); break;
            default: resp.sendRedirect("pizza?acao=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) { resp.sendRedirect(req.getContextPath()+"/login.jsp"); return; }
        PizzaDAO dao = new PizzaDAO();
        String acao = req.getParameter("acao");
        Pizza p = new Pizza();
        p.setNome(req.getParameter("nome")); p.setDescricao(req.getParameter("descricao"));
        p.setTamanho(req.getParameter("tamanho")); p.setCategoria(req.getParameter("categoria"));
        p.setPreco(new BigDecimal(req.getParameter("preco")));
        p.setDisponivel("true".equals(req.getParameter("disponivel")));
        p.setIngredientes(req.getParameter("ingredientes")); p.setImagemUrl(req.getParameter("imagemUrl"));
        String tp = req.getParameter("tempoPreparo"); p.setTempoPreparo(tp!=null&&!tp.isEmpty()?Integer.parseInt(tp):30);
        String cal = req.getParameter("calorias"); p.setCalorias(cal!=null&&!cal.isEmpty()?Integer.parseInt(cal):0);
        p.setVegana("true".equals(req.getParameter("vegana")));
        p.setSemGluten("true".equals(req.getParameter("semGluten")));
        if ("alterar".equals(acao)) { p.setId(Integer.parseInt(req.getParameter("id"))); dao.alterar(p); }
        else dao.inserir(p);
        resp.sendRedirect("pizza?acao=listar");
    }
}
