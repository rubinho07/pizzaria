package model;
import java.math.BigDecimal;

public class Adicional {
    private int id;
    private String nome;
    private String descricao;
    private BigDecimal preco;
    private String tipo;
    private boolean disponivel;

    public int getId(){return id;} public void setId(int id){this.id=id;}
    public String getNome(){return nome;} public void setNome(String n){this.nome=n;}
    public String getDescricao(){return descricao;} public void setDescricao(String d){this.descricao=d;}
    public BigDecimal getPreco(){return preco;} public void setPreco(BigDecimal p){this.preco=p;}
    public String getTipo(){return tipo;} public void setTipo(String t){this.tipo=t;}
    public boolean isDisponivel(){return disponivel;} public void setDisponivel(boolean d){this.disponivel=d;}
}
