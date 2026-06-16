<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pedido,model.ItemPedido"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Pedido | Admin</title></head>
<body>
<%@ include file="sidebar.jsp" %>
<% Pedido p=(Pedido)request.getAttribute("pedido"); %>
<div class="admin-main">
    <div class="admin-topbar">
        <div class="admin-page-title">Pedido #<%= p!=null?p.getId():"" %></div>
        <a href="<%=request.getContextPath()%>/admin/pedido" class="btn btn-outline btn-sm">Voltar</a>
    </div>
    <div class="admin-content fade-in">
    <% if(p!=null){ %>
        <div style="display:grid;grid-template-columns:1fr 300px;gap:20px;">
            <div>
                <div class="card">
                    <div class="card-header"><div class="card-title">&#128100; Dados do Cliente</div></div>
                    <div style="font-size:13px;line-height:2.2;color:#7a5c3a;">
                        <div><strong>Nome:</strong> <%= p.getNomeCliente() %></div>
                        <div><strong>Telefone:</strong> <%= p.getTelefoneCliente() %></div>
                        <div><strong>Endereco:</strong> <%= p.getEnderecoEntrega() %></div>
                        <div><strong>Pagamento:</strong> <%= p.getFormaPagamento() %></div>
                        <% if(p.getObservacao()!=null&&!p.getObservacao().isEmpty()){ %><div><strong>Obs:</strong> <%= p.getObservacao() %></div><% } %>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header"><div class="card-title">&#127829; Itens do Pedido</div></div>
                    <% if(p.getItens()!=null){for(ItemPedido i:p.getItens()){ %>
                    <div style="border:1px solid #f0dcc0;border-radius:12px;padding:14px;margin-bottom:10px;background:#fdf6ec;">
                        <div style="font-weight:700;color:#2c1500;">&#127829; <%= i.getNomePizza() %> (x<%= i.getQuantidade() %>)</div>
                        <div style="font-size:12px;color:#b08060;margin:4px 0;line-height:1.5;"><%= i.getAdicionais() %></div>
                        <div style="display:flex;justify-content:space-between;margin-top:8px;">
                            <span style="font-size:12px;color:#7a5c3a;">R$ <%= String.format("%.2f",i.getPrecoFinal()).replace(".",",") %> x <%= i.getQuantidade() %></span>
                            <strong style="color:#c0392b;">R$ <%= String.format("%.2f",i.getSubtotal()).replace(".",",") %></strong>
                        </div>
                    </div>
                    <% } } %>
                </div>
            </div>
            <div>
                <div class="card">
                    <div class="card-header"><div class="card-title">Status</div></div>
                    <div style="margin-bottom:14px;"><span class="badge status-<%= p.getStatus().toLowerCase() %>" style="font-size:13px;padding:6px 14px;"><%= p.getStatus() %></span></div>
                    <div style="display:flex;flex-direction:column;gap:8px;">
                        <a href="<%=request.getContextPath()%>/admin/pedido?acao=status&id=<%= p.getId() %>&status=EM_PREPARO" class="btn btn-vermelho btn-sm" style="justify-content:center;">&#128293; Em Preparo</a>
                        <a href="<%=request.getContextPath()%>/admin/pedido?acao=status&id=<%= p.getId() %>&status=SAIU_ENTREGA" class="btn btn-laranja btn-sm" style="justify-content:center;">&#128663; Saiu para Entrega</a>
                        <a href="<%=request.getContextPath()%>/admin/pedido?acao=status&id=<%= p.getId() %>&status=ENTREGUE" class="btn btn-verde btn-sm" style="justify-content:center;">&#9989; Entregue</a>
                        <a href="<%=request.getContextPath()%>/admin/pedido?acao=status&id=<%= p.getId() %>&status=CANCELADO" class="btn btn-outline btn-sm" style="justify-content:center;">&#10060; Cancelar</a>
                    </div>
                    <hr class="divider"/>
                    <div style="font-size:13px;line-height:2;color:#7a5c3a;">
                        <div class="flex justify-between"><span>Bruto:</span><span>R$ <%= p.getTotalBruto()!=null?String.format("%.2f",p.getTotalBruto()).replace(".",","):"—" %></span></div>
                        <% if(p.getDesconto()!=null&&p.getDesconto().compareTo(java.math.BigDecimal.ZERO)>0){ %>
                        <div class="flex justify-between" style="color:#27ae60;"><span>Desconto:</span><span>- R$ <%= String.format("%.2f",p.getDesconto()).replace(".",",") %></span></div>
                        <% } %>
                        <div class="flex justify-between" style="font-weight:700;font-size:16px;color:#c0392b;"><span>Total:</span><span>R$ <%= p.getTotalFinal()!=null?String.format("%.2f",p.getTotalFinal()).replace(".",","):"—" %></span></div>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
    </div>
</div>
</body>
</html>
