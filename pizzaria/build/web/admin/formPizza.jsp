<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pizza"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Pizza | Admin</title></head>
<body>
<%@ include file="sidebar.jsp" %>
<% Pizza p=(Pizza)request.getAttribute("pizza"); boolean ed=p!=null&&p.getId()>0; %>
<div class="admin-main">
    <div class="admin-topbar">
        <div class="admin-page-title"><%= ed?"Editar":"Nova" %> Pizza</div>
    </div>
    <div class="admin-content fade-in">
        <div class="card" style="max-width:720px;">
            <form action="<%=request.getContextPath()%>/admin/pizza" method="post">
                <input type="hidden" name="acao" value="<%= ed?"alterar":"inserir" %>"/>
                <% if(ed){ %><input type="hidden" name="id" value="<%= p.getId() %>"/><% } %>
                <div class="form-grid">
                    <div class="form-group"><label>Nome da Pizza *</label><input type="text" name="nome" placeholder="Ex: Margherita Especial" required value="<%= ed&&p.getNome()!=null?p.getNome():"" %>"/></div>
                    <div class="form-group"><label>Categoria</label>
                        <select name="categoria">
                            <% String[] cats={"Tradicional","Especial","Premium","Doce"}; for(String c:cats){ %><option value="<%= c %>" <%= ed&&c.equals(p.getCategoria())?"selected":"" %>><%= c %></option><% } %>
                        </select>
                    </div>
                    <div class="form-group"><label>Tamanho</label>
                        <select name="tamanho">
                            <% String[] tams={"P","M","G","GG"}; for(String t:tams){ %><option value="<%= t %>" <%= ed&&t.equals(p.getTamanho())?"selected":"" %>><%= t %></option><% } %>
                        </select>
                    </div>
                    <div class="form-group"><label>Preco (R$) *</label><input type="number" name="preco" step="0.01" min="0" placeholder="39.90" required value="<%= ed?p.getPreco():"" %>"/></div>
                    <div class="form-group"><label>Tempo de Preparo (min)</label><input type="number" name="tempoPreparo" placeholder="30" value="<%= ed?p.getTempoPreparo():30 %>"/></div>
                    <div class="form-group"><label>Calorias (kcal)</label><input type="number" name="calorias" placeholder="800" value="<%= ed?p.getCalorias():0 %>"/></div>
                    <div class="form-group"><label>Disponivel</label>
                        <select name="disponivel"><option value="true" <%= !ed||p.isDisponivel()?"selected":"" %>>Sim</option><option value="false" <%= ed&&!p.isDisponivel()?"selected":"" %>>Nao</option></select>
                    </div>
                    <div class="form-group"><label>Vegana</label>
                        <select name="vegana"><option value="false" <%= !ed||!p.isVegana()?"selected":"" %>>Nao</option><option value="true" <%= ed&&p.isVegana()?"selected":"" %>>Sim</option></select>
                    </div>
                    <div class="form-group"><label>Sem Gluten</label>
                        <select name="semGluten"><option value="false" <%= !ed||!p.isSemGluten()?"selected":"" %>>Nao</option><option value="true" <%= ed&&p.isSemGluten()?"selected":"" %>>Sim</option></select>
                    </div>
                    <div class="form-group full"><label>Ingredientes (separados por virgula)</label><input type="text" name="ingredientes" placeholder="Molho de tomate, Mozzarella, Manjericao" value="<%= ed&&p.getIngredientes()!=null?p.getIngredientes():"" %>"/></div>
                    <div class="form-group full"><label>Descricao</label><textarea name="descricao" placeholder="Descricao da pizza..."><%= ed&&p.getDescricao()!=null?p.getDescricao():"" %></textarea></div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-vermelho"><%= ed?"Atualizar":"Cadastrar" %> Pizza</button>
                    <a href="<%=request.getContextPath()%>/admin/pizza?acao=listar" class="btn btn-outline">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
