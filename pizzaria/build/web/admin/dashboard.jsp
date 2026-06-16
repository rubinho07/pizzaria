<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pedido,java.util.List"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Dashboard | Admin</title></head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="admin-main">
    <div class="admin-topbar">
        <div class="admin-page-title">Dashboard</div>
    </div>
    <div class="admin-content fade-in">
        <div class="stat-grid">
            <div class="stat-card"><span class="stat-ico">&#127829;</span><div><div class="stat-label">Pizzas no Cardapio</div><div class="stat-val"><%= request.getAttribute("totalPizzas") %></div></div></div>
            <div class="stat-card"><span class="stat-ico">&#128203;</span><div><div class="stat-label">Pedidos Totais</div><div class="stat-val"><%= request.getAttribute("totalPedidos") %></div></div></div>
        </div>
        <div class="card">
            <div class="card-header">
                <div class="card-title">&#128203; Ultimos Pedidos</div>
                <a href="<%=request.getContextPath()%>/admin/pedido" class="btn btn-outline btn-sm">Ver Todos</a>
            </div>
            <div class="table-wrap">
                <table>
                    <thead><tr><th>#</th><th>Cliente</th><th>Total</th><th>Status</th><th>Data</th></tr></thead>
                    <tbody>
                    <% List<Pedido> ultimos=(List<Pedido>)request.getAttribute("ultimosPedidos"); if(ultimos!=null){for(Pedido p:ultimos){ %>
                    <tr>
                        <td>#<%= p.getId() %></td>
                        <td><strong><%= p.getNomeCliente() %></strong></td>
                        <td>R$ <%= p.getTotalFinal()!=null?String.format("%.2f",p.getTotalFinal()).replace(".",","):"—" %></td>
                        <td><span class="badge status-<%= p.getStatus()!=null?p.getStatus().toLowerCase():"" %>"><%= p.getStatus() %></span></td>
                        <td class="text-muted"><%= p.getDataPedido()!=null?p.getDataPedido().substring(0,16):"—" %></td>
                    </tr>
                    <% }}else{ %><tr><td colspan="5"><div class="empty"><span class="ico">&#128203;</span><h3>Nenhum pedido ainda</h3></div></td></tr><% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
