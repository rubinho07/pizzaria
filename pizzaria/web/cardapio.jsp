<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pizza,java.util.List"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Cardapio | Bella Pizza</title></head>
<body>
<%@ include file="header.jsp" %>
<%
    List<Pizza> pizzas = (List<Pizza>) request.getAttribute("pizzas");
    String adicionado = request.getParameter("adicionado");
%>
<div style="background:linear-gradient(135deg,#1a0a00,#2c1500,#6b3a1f);padding:50px 32px;text-align:center;">
    <h1 style="font-family:'Playfair Display',serif;font-size:44px;color:white;margin-bottom:10px;">Nosso <span style="color:#f39c12;font-style:italic;">Cardapio</span></h1>
    <p style="color:rgba(255,255,255,.7);font-size:16px;">Pizzas artesanais com ingredientes selecionados. Personalize do seu jeito!</p>
</div>

<div class="section">
    <% if("true".equals(adicionado)){ %>
    <div class="alert alert-ok fade-in">&#10003; Pizza adicionada ao carrinho! <a href="<%=request.getContextPath()%>/pedido.jsp" style="color:inherit;font-weight:800;">Ver carrinho &rarr;</a></div>
    <% } %>

    <div class="section-title">&#127829; Nossas Pizzas</div>
    <div class="section-sub">Clique em "Personalizar" para montar a sua pizza do jeito que quiser</div>

    <div class="pizzas-grid">
    <% if(pizzas != null) { for(Pizza p : pizzas) { %>
        <div class="pizza-card fade-in">
            <div class="pizza-emoji">
                &#127829;
                <div class="pizza-badges">
                    <% if(p.isVegana()){ %><span class="badge badge-verde" style="font-size:10px;">&#127807; Vegana</span><% } %>
                    <% if(p.isSemGluten()){ %><span class="badge badge-amarelo" style="font-size:10px;">&#9889; Sem Gluten</span><% } %>
                </div>
            </div>
            <div class="pizza-body">
                <div class="pizza-categoria"><%= p.getCategoria() %> &bull; <%= p.getTamanho() %></div>
                <div class="pizza-nome"><%= p.getNome() %></div>
                <div class="pizza-desc"><%= p.getDescricao() != null ? p.getDescricao() : "" %></div>
                <div class="pizza-ingredientes">&#127807; <%= p.getIngredientes() != null ? p.getIngredientes() : "" %></div>
                <div style="font-size:11px;color:#b08060;">&#128336; <%= p.getTempoPreparo() %> min &bull; &#128293; <%= p.getCalorias() %> kcal</div>
            </div>
            <div class="pizza-footer">
                <div class="pizza-preco">R$ <%= String.format("%.2f", p.getPreco()).replace(".",",") %><br><small>a partir de</small></div>
                <a href="<%=request.getContextPath()%>/cardapio?acao=personalizar&id=<%= p.getId() %>" class="btn btn-vermelho btn-sm">&#9998; Personalizar</a>
            </div>
        </div>
    <% } } else { %>
        <div class="empty"><span class="ico">&#127829;</span><h3>Cardapio em breve!</h3></div>
    <% } %>
    </div>
</div>
</body>
</html>
