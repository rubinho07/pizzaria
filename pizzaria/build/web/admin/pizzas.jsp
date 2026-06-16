<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pizza,java.util.List"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Pizzas | Admin</title></head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="admin-main">
    <div class="admin-topbar">
        <div class="admin-page-title">&#127829; Cardapio</div>
        <a href="<%=request.getContextPath()%>/admin/pizza?acao=nova" class="btn btn-vermelho btn-sm">+ Nova Pizza</a>
    </div>
    <div class="admin-content fade-in">
        <div class="card">
            <div class="table-wrap">
                <table>
                    <thead><tr><th>Nome</th><th>Categoria</th><th>Tamanho</th><th>Preco</th><th>Preparo</th><th>Status</th><th>Acoes</th></tr></thead>
                    <tbody>
                    <% List<Pizza> pizzas=(List<Pizza>)request.getAttribute("pizzas"); if(pizzas!=null&&!pizzas.isEmpty()){for(Pizza p:pizzas){ %>
                    <tr>
                        <td><strong>&#127829; <%= p.getNome() %></strong><br><span style="font-size:11px;color:#b08060;"><%= p.getIngredientes()!=null?p.getIngredientes().substring(0,Math.min(40,p.getIngredientes().length()))+"...":"" %></span></td>
                        <td><span class="badge badge-laranja"><%= p.getCategoria() %></span></td>
                        <td><%= p.getTamanho() %></td>
                        <td><strong style="color:#c0392b;">R$ <%= String.format("%.2f",p.getPreco()).replace(".",",") %></strong></td>
                        <td><%= p.getTempoPreparo() %> min</td>
                        <td><span class="badge <%= p.isDisponivel()?"badge-verde":"badge-cinza" %>"><%= p.isDisponivel()?"Ativo":"Inativo" %></span></td>
                        <td>
                            <div class="actions-cell">
                                <a href="<%=request.getContextPath()%>/admin/pizza?acao=editar&id=<%= p.getId() %>" class="btn btn-laranja btn-xs">Editar</a>
                                <a href="<%=request.getContextPath()%>/admin/pizza?acao=excluir&id=<%= p.getId() %>" class="btn btn-outline btn-xs" onclick="return confirm('Excluir pizza?')">Excluir</a>
                            </div>
                        </td>
                    </tr>
                    <% }}else{ %><tr><td colspan="7"><div class="empty"><span class="ico">&#127829;</span><h3>Nenhuma pizza cadastrada</h3><p>Adicione pizzas ao cardapio.</p></div></td></tr><% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
