<%@page import="model.Usuario"%>
<%
    Usuario admin = (Usuario) session.getAttribute("admin");
    if (admin == null) { response.sendRedirect(request.getContextPath()+"/login.jsp"); return; }
    String uri = request.getRequestURI();
%>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,700;1,700&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"/>
<aside class="admin-sidebar">
    <div class="admin-logo">
        <span>&#127829;</span>
        <div><div>Bella Pizza</div><small>Admin</small></div>
    </div>
    <nav class="admin-nav">
        <div class="admin-nav-label">Principal</div>
        <a href="<%=request.getContextPath()%>/admin/dashboard" class="admin-nav-item <%=uri.contains("dashboard")?"active":""%>">
            <span class="admin-nav-icon">&#128202;</span> Dashboard
        </a>
        <div class="admin-nav-label">Cardapio</div>
        <a href="<%=request.getContextPath()%>/admin/pizza?acao=listar" class="admin-nav-item <%=uri.contains("pizza")?"active":""%>">
            <span class="admin-nav-icon">&#127829;</span> Pizzas
        </a>
        <a href="<%=request.getContextPath()%>/admin/pizza?acao=nova" class="admin-nav-item">
            <span class="admin-nav-icon">&#43;</span> Nova Pizza
        </a>
        <div class="admin-nav-label">Pedidos</div>
        <a href="<%=request.getContextPath()%>/admin/pedido" class="admin-nav-item <%=uri.contains("pedido")?"active":""%>">
            <span class="admin-nav-icon">&#128203;</span> Pedidos
        </a>
        <div class="admin-nav-label">Sistema</div>
        <a href="<%=request.getContextPath()%>/cardapio" class="admin-nav-item" target="_blank">
            <span class="admin-nav-icon">&#128279;</span> Ver Cardapio
        </a>
    </nav>
    <div class="admin-footer">
        <div style="font-size:12px;color:rgba(255,255,255,.5);margin-bottom:8px;">&#128100; <%= admin.getNome() %></div>
        <a href="<%=request.getContextPath()%>/logout" class="btn btn-outline btn-sm" style="width:100%;justify-content:center;color:rgba(255,255,255,.5);border-color:rgba(255,255,255,.15);">Sair</a>
    </div>
</aside>
