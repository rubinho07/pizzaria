<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Pedido Confirmado | Bella Pizza</title></head>
<body>
<%@ include file="header.jsp" %>
<div style="padding:40px 20px;">
<div class="confirmacao-box fade-in">
    <div class="confirmacao-ico">&#127881;</div>
    <div class="confirmacao-titulo">Pedido Confirmado!</div>
    <p style="color:#7a5c3a;margin-bottom:16px;">Seu pedido #<%= request.getAttribute("pedidoId") %> foi recebido!</p>
    <div style="background:#fdf6ec;border-radius:12px;padding:16px;margin-bottom:20px;text-align:left;font-size:13px;">
        <strong>Total:</strong> R$ <%= String.format("%.2f",request.getAttribute("totalFinal")).replace(".",",") %><br>
        <strong>Pagamento:</strong> <%= request.getAttribute("formaPagamento") %><br>
        <strong>Tempo estimado:</strong> 30-45 minutos &#128336;
    </div>
    <a href="<%=request.getContextPath()%>/cardapio" class="btn btn-vermelho" style="justify-content:center;width:100%;">&#127829; Fazer Novo Pedido</a>
</div>
</div>
</body>
</html>
