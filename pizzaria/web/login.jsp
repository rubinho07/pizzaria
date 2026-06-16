<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Admin | Bella Pizza</title>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,700;1,700&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="css/style.css"></head>
<body>
<div class="login-admin">
    <div class="login-box fade-in">
        <div class="login-logo">&#127829; Admin</div>
        <% if(request.getAttribute("erro")!=null){ %><div class="alert alert-erro"><%= request.getAttribute("erro") %></div><% } %>
        <form action="login" method="post">
            <div class="form-group" style="margin-bottom:14px;"><label>Email</label><input type="email" name="email" placeholder="admin@pizza.com" required/></div>
            <div class="form-group" style="margin-bottom:20px;"><label>Senha</label><input type="password" name="senha" placeholder="••••••" required/></div>
            <button type="submit" class="btn btn-vermelho" style="width:100%;justify-content:center;padding:12px;">Entrar</button>
        </form>
        <div style="text-align:center;margin-top:16px;"><a href="cardapio" style="color:rgba(255,255,255,.4);font-size:12px;">Ver cardapio publico</a></div>
    </div>
</div>
</body>
</html>
