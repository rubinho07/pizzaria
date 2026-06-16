<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ItemPedido,java.util.List,java.math.BigDecimal"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Finalizar Pedido | Bella Pizza</title></head>
<body>
<%@ include file="header.jsp" %>
<%
    List<ItemPedido> carrinhoItems = (List<ItemPedido>) session.getAttribute("carrinho");
    BigDecimal totalCalc = BigDecimal.ZERO;
    if (carrinhoItems != null) {
        for (ItemPedido it : carrinhoItems) {
            if (it.getSubtotal() != null) totalCalc = totalCalc.add(it.getSubtotal());
        }
    }
    double totalDouble = totalCalc.doubleValue();
%>
<div class="pedido-wrap fade-in">
    <h1 style="font-family:'Playfair Display',serif;font-size:28px;color:#2c1500;margin-bottom:24px;text-align:center;">&#128717; Seu Pedido</h1>

    <% if(carrinhoItems == null || carrinhoItems.isEmpty()) { %>
    <div class="empty">
        <span class="ico">&#127829;</span>
        <h3>Carrinho vazio!</h3>
        <p>Adicione pizzas ao carrinho para fazer seu pedido.</p>
        <a href="<%=request.getContextPath()%>/cardapio" class="btn btn-vermelho">Ver Cardapio</a>
    </div>
    <% } else { %>

    <% for(ItemPedido item : carrinhoItems) { %>
    <div class="carrinho-item">
        <div class="carrinho-item-nome">&#127829; <%= item.getNomePizza() %> (x<%= item.getQuantidade() %>)</div>
        <div class="carrinho-item-desc"><%= item.getAdicionais() %></div>
        <% if(item.getObservacao()!=null&&!item.getObservacao().isEmpty()){ %>
        <div style="font-size:11px;color:#b08060;font-style:italic;">Obs: <%= item.getObservacao() %></div>
        <% } %>
        <div class="carrinho-item-footer">
            <div class="carrinho-item-preco">R$ <%= String.format("%.2f",item.getSubtotal()).replace(".",",") %></div>
        </div>
    </div>
    <% } %>

    <div class="total-box">
        <div class="total-linha"><span>Subtotal</span><span>R$ <%= String.format("%.2f",totalCalc).replace(".",",") %></span></div>
        <div class="total-linha" id="descontoPix" style="display:none;"><span>Desconto PIX (10%)</span><span style="color:#27ae60;">- R$ <span id="valorDesconto">0,00</span></span></div>
        <div class="total-final"><span>Total</span><span id="totalFinal">R$ <%= String.format("%.2f",totalCalc).replace(".",",") %></span></div>
    </div>

    <div class="card">
        <div class="card-title" style="margin-bottom:14px;">&#128179; Forma de Pagamento</div>
        <div class="pagamento-opcoes">
            <label class="pagamento-opcao" onclick="selecionarPagamento('DINHEIRO')">
                <input type="radio" name="fpHidden" value="DINHEIRO" checked/>
                <span class="pagamento-ico">&#128181;</span>
                <div class="pagamento-nome">Dinheiro</div>
                <div class="pagamento-desc">Na entrega</div>
            </label>
            <label class="pagamento-opcao" onclick="selecionarPagamento('PIX')">
                <input type="radio" name="fpHidden" value="PIX"/>
                <span class="pagamento-ico">&#9889;</span>
                <div class="pagamento-nome">PIX</div>
                <div class="pagamento-desc">10% desconto!</div>
            </label>
            <label class="pagamento-opcao" onclick="selecionarPagamento('CARTAO')">
                <input type="radio" name="fpHidden" value="CARTAO"/>
                <span class="pagamento-ico">&#128179;</span>
                <div class="pagamento-nome">Cartao</div>
                <div class="pagamento-desc">Na entrega</div>
            </label>
        </div>
    </div>

    <div class="card">
        <div class="card-title" style="margin-bottom:14px;">&#128100; Seus Dados</div>
        <form action="<%=request.getContextPath()%>/cardapio" method="post">
            <input type="hidden" name="acao" value="finalizar"/>
            <input type="hidden" name="formaPagamento" id="formaPagamento" value="DINHEIRO"/>
            <div class="form-grid">
                <div class="form-group"><label>Nome completo *</label><input type="text" name="nomeCliente" placeholder="Seu nome" required/></div>
                <div class="form-group"><label>Telefone *</label><input type="text" name="telefone" placeholder="(11) 99999-9999" required/></div>
                <div class="form-group full"><label>Endereco de entrega *</label><input type="text" name="endereco" placeholder="Rua, numero, bairro" required/></div>
                <div class="form-group full"><label>Observacao geral</label><textarea name="observacao" placeholder="Alguma instrucao especial?"></textarea></div>
            </div>
            <div style="display:flex;gap:12px;margin-top:18px;">
                <button type="submit" class="btn btn-vermelho btn-lg" style="flex:1;justify-content:center;">&#9989; Fazer Pedido</button>
                <a href="<%=request.getContextPath()%>/cardapio" class="btn btn-outline">Continuar Comprando</a>
            </div>
        </form>
    </div>
    <% } %>
</div>

<script>
const totalBruto = <%= totalDouble %>;
function selecionarPagamento(tipo) {
    document.getElementById('formaPagamento').value = tipo;
    const descDiv = document.getElementById('descontoPix');
    const totalEl = document.getElementById('totalFinal');
    const descEl  = document.getElementById('valorDesconto');
    if (tipo === 'PIX') {
        const desc  = totalBruto * 0.10;
        const total = totalBruto - desc;
        descDiv.style.display = 'flex';
        descEl.textContent  = desc.toFixed(2).replace('.',',');
        totalEl.textContent = 'R$ ' + total.toFixed(2).replace('.',',');
    } else {
        descDiv.style.display = 'none';
        totalEl.textContent = 'R$ ' + totalBruto.toFixed(2).replace('.',',');
    }
}
</script>
</body>
</html>
