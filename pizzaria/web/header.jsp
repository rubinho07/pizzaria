<%@page import="model.ItemPedido,java.util.List"%>
<%
    List<ItemPedido> carrinho = (List<ItemPedido>) session.getAttribute("carrinho");
    int qtdCarrinho = carrinho != null ? carrinho.size() : 0;
%>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,700;1,700&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"/>
<header class="header">
    <a href="<%=request.getContextPath()%>/cardapio" class="header-logo">&#127829; Bella Pizza</a>
    <nav class="header-nav">
        <a href="<%=request.getContextPath()%>/cardapio">&#127829; Cardapio</a>
        <a href="<%=request.getContextPath()%>/pedido.jsp" class="carrinho-btn">
            &#128717; Carrinho <span class="carrinho-count"><%= qtdCarrinho %></span>
        </a>
    </nav>
</header>
