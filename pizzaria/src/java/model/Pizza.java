package model;
import java.math.BigDecimal;

public class Pizza {
    private int id;
    private String nome;
    private String descricao;
    private String tamanho;
    private String categoria;
    private BigDecimal preco;
    private boolean disponivel;
    private String ingredientes;
    private String imagemUrl;
    private int tempoPreparo;
    private int calorias;
    private boolean vegana;
    private boolean semGluten;

    public int getId(){return id;} public void setId(int id){this.id=id;}
    public String getNome(){return nome;} public void setNome(String n){this.nome=n;}
    public String getDescricao(){return descricao;} public void setDescricao(String d){this.descricao=d;}
    public String getTamanho(){return tamanho;} public void setTamanho(String t){this.tamanho=t;}
    public String getCategoria(){return categoria;} public void setCategoria(String c){this.categoria=c;}
    public BigDecimal getPreco(){return preco;} public void setPreco(BigDecimal p){this.preco=p;}
    public boolean isDisponivel(){return disponivel;} public void setDisponivel(boolean d){this.disponivel=d;}
    public String getIngredientes(){return ingredientes;} public void setIngredientes(String i){this.ingredientes=i;}
    public String getImagemUrl(){return imagemUrl;} public void setImagemUrl(String i){this.imagemUrl=i;}
    public int getTempoPreparo(){return tempoPreparo;} public void setTempoPreparo(int t){this.tempoPreparo=t;}
    public int getCalorias(){return calorias;} public void setCalorias(int c){this.calorias=c;}
    public boolean isVegana(){return vegana;} public void setVegana(boolean v){this.vegana=v;}
    public boolean isSemGluten(){return semGluten;} public void setSemGluten(boolean s){this.semGluten=s;}
}
