<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pizza,model.Adicional,java.util.List"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="UTF-8"><title>Personalizar | Bella Pizza</title></head>
<body>
<%@ include file="header.jsp" %>
<%
    Pizza pizza = (Pizza) request.getAttribute("pizza");
    List<Adicional> adicionais = (List<Adicional>) request.getAttribute("adicionais");
%>
<div class="personalizar-wrap fade-in">
    <div class="personalizar-header">
        <div style="font-size:64px;">&#127829;</div>
        <h1 style="font-family:'Playfair Display',serif;font-size:28px;color:#2c1500;"><%= pizza.getNome() %></h1>
        <p style="color:#b08060;"><%= pizza.getDescricao() %></p>
        <p style="color:#7a5c3a;font-size:13px;margin-top:6px;font-style:italic;">&#127807; <%= pizza.getIngredientes() %></p>
    </div>

    <form action="<%=request.getContextPath()%>/cardapio" method="post">
        <input type="hidden" name="acao" value="adicionar"/>
        <input type="hidden" name="pizzaId" value="<%= pizza.getId() %>"/>

        <!-- PRECO PREVIEW -->
        <div class="preco-preview">
            <div>
                <div class="preco-preview-label">Preco atual</div>
                <div style="font-size:12px;color:rgba(255,255,255,.5);">Atualiza conforme voce personaliza</div>
            </div>
            <div>
                <div class="preco-preview-label">Total</div>
                <div class="preco-preview-valor" id="precoTotal">R$ <%= String.format("%.2f", pizza.getPreco()).replace(".",",") %></div>
            </div>
        </div>

        <!-- QUANTIDADE -->
        <div class="opcoes-section">
            <div class="opcoes-title"><span class="ico">&#128230;</span> Quantidade</div>
            <div style="display:flex;align-items:center;gap:12px;">
                <button type="button" onclick="mudarQtd(-1)" class="btn btn-outline btn-sm">&#8722;</button>
                <input type="number" name="quantidade" id="quantidade" value="1" min="1" max="10" style="width:60px;text-align:center;"/>
                <button type="button" onclick="mudarQtd(1)" class="btn btn-outline btn-sm">&#43;</button>
            </div>
        </div>

        <!-- UPGRADE TAMANHO -->
        <div class="opcoes-section">
            <div class="opcoes-title"><span class="ico">&#128640;</span> Upgrade de Tamanho</div>
            <div class="opcoes-grid">
                <label class="opcao-item">
                    <input type="radio" name="upgradeGG" value="false" checked onchange="calcularPreco()"/>
                    <div><div class="opcao-nome">Tamanho original (<%= pizza.getTamanho() %>)</div><div class="opcao-gratis">Incluido</div></div>
                </label>
                <label class="opcao-item">
                    <input type="radio" name="upgradeGG" value="true" onchange="calcularPreco()"/>
                    <div><div class="opcao-nome">Upgrade para GG</div><div class="opcao-preco">+ R$ 8,00</div></div>
                </label>
            </div>
        </div>

        <!-- BORDA RECHEADA -->
        <div class="opcoes-section">
            <div class="opcoes-title"><span class="ico">&#127838;</span> Borda Recheada (+R$5,00)</div>
            <div class="opcoes-grid">
                <label class="opcao-item">
                    <input type="radio" name="bordaRecheada" value="false" checked onchange="toggleBorda(false)"/>
                    <div><div class="opcao-nome">Sem borda recheada</div><div class="opcao-gratis">Incluido</div></div>
                </label>
                <label class="opcao-item">
                    <input type="radio" name="bordaRecheada" value="true" onchange="toggleBorda(true)"/>
                    <div><div class="opcao-nome">Com borda recheada</div><div class="opcao-preco">+ R$ 5,00</div></div>
                </label>
            </div>
            <div id="tipoBordaDiv" style="display:none;margin-top:12px;">
                <div class="opcoes-grid">
                    <% String[] bordas = {"Catupiry","Cheddar","Chocolate"}; for(String b:bordas){ %>
                    <label class="opcao-item">
                        <input type="radio" name="tipoBorda" value="<%= b %>"/>
                        <div><div class="opcao-nome"><%= b %></div></div>
                    </label>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- ADICIONAIS -->
        <% if(adicionais != null && !adicionais.isEmpty()) { %>
        <div class="opcoes-section">
            <div class="opcoes-title"><span class="ico">&#10133;</span> Adicionais</div>
            <div class="opcoes-grid">
                <% for(Adicional a : adicionais) { if(!"REMOCAO".equals(a.getTipo())) { %>
                <label class="opcao-item">
                    <input type="checkbox" name="adicionais" value="<%= a.getId() %>" data-preco="<%= a.getPreco() %>" onchange="calcularPreco()"/>
                    <div><div class="opcao-nome"><%= a.getNome() %></div><div class="opcao-preco">+ R$ <%= String.format("%.2f",a.getPreco()).replace(".",",") %></div></div>
                </label>
                <% } } %>
            </div>
        </div>
        <% } %>

        <!-- REMOVER INGREDIENTES -->
        <div class="opcoes-section">
            <div class="opcoes-title"><span class="ico">&#10060;</span> Remover Ingredientes (sem custo)</div>
            <div style="display:flex;flex-wrap:wrap;gap:8px;">
                <% String[] ings = pizza.getIngredientes() != null ? pizza.getIngredientes().split(",") : new String[0]; %>
                <% for(String ing : ings) { String i = ing.trim(); if(!i.isEmpty()){ %>
                <label style="display:flex;align-items:center;gap:6px;padding:7px 12px;background:var(--creme);border:1.5px solid var(--borda);border-radius:20px;cursor:pointer;font-size:13px;font-weight:600;">
                    <input type="checkbox" name="remover" value="<%= i %>" style="accent-color:#c0392b;"/>
                    Sem <%= i %>
                </label>
                <% } } %>
            </div>
        </div>

        <!-- OBSERVACAO -->
        <div class="opcoes-section">
            <div class="opcoes-title"><span class="ico">&#128203;</span> Observacao</div>
            <textarea name="observacao" placeholder="Ex: bem passada, sem sal, etc..." style="width:100%;"></textarea>
        </div>

        <div style="display:flex;gap:12px;margin-top:4px;">
            <button type="submit" class="btn btn-vermelho btn-lg" style="flex:1;justify-content:center;">&#127829; Adicionar ao Carrinho</button>
            <a href="<%=request.getContextPath()%>/cardapio" class="btn btn-outline">Voltar</a>
        </div>
    </form>
</div>

<script>
const precoBase = <%= pizza.getPreco() %>;
function calcularPreco() {
    let total = precoBase;
    if(document.querySelector('input[name="upgradeGG"]:checked')?.value === 'true') total += 8;
    if(document.querySelector('input[name="bordaRecheada"]:checked')?.value === 'true') total += 5;
    document.querySelectorAll('input[name="adicionais"]:checked').forEach(cb => { total += parseFloat(cb.dataset.preco || 0); });
    document.getElementById('precoTotal').textContent = 'R$ ' + total.toFixed(2).replace('.',',');
}
function toggleBorda(show) {
    document.getElementById('tipoBordaDiv').style.display = show ? '' : 'none';
    calcularPreco();
}
function mudarQtd(delta) {
    const el = document.getElementById('quantidade');
    el.value = Math.max(1, Math.min(10, parseInt(el.value)+delta));
}
document.querySelectorAll('input[name="upgradeGG"]').forEach(r => r.addEventListener('change', calcularPreco));
</script>
</body>
</html>
