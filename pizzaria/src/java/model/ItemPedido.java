package model;
import java.math.BigDecimal;

public class ItemPedido {
    private int id;
    private int pedidoId;
    private int pizzaId;
    private String nomePizza;
    private int quantidade;
    private BigDecimal precoUnitario;
    private BigDecimal precoFinal;
    private BigDecimal subtotal;
    private String adicionais;
    private String observacao;

    public int getId(){return id;} public void setId(int id){this.id=id;}
    public int getPedidoId(){return pedidoId;} public void setPedidoId(int p){this.pedidoId=p;}
    public int getPizzaId(){return pizzaId;} public void setPizzaId(int p){this.pizzaId=p;}
    public String getNomePizza(){return nomePizza;} public void setNomePizza(String n){this.nomePizza=n;}
    public int getQuantidade(){return quantidade;} public void setQuantidade(int q){this.quantidade=q;}
    public BigDecimal getPrecoUnitario(){return precoUnitario;} public void setPrecoUnitario(BigDecimal p){this.precoUnitario=p;}
    public BigDecimal getPrecoFinal(){return precoFinal;} public void setPrecoFinal(BigDecimal p){this.precoFinal=p;}
    public BigDecimal getSubtotal(){return subtotal;} public void setSubtotal(BigDecimal s){this.subtotal=s;}
    public String getAdicionais(){return adicionais;} public void setAdicionais(String a){this.adicionais=a;}
    public String getObservacao(){return observacao;} public void setObservacao(String o){this.observacao=o;}
}
