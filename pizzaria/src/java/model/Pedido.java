package model;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Pedido {
    private int id;
    private String nomeCliente;
    private String telefoneCliente;
    private String enderecoEntrega;
    private String formaPagamento;
    private String status;
    private BigDecimal totalBruto;
    private BigDecimal totalFinal;
    private BigDecimal desconto;
    private String observacao;
    private String dataPedido;
    private List<ItemPedido> itens = new ArrayList<>();

    public int getId(){return id;} public void setId(int id){this.id=id;}
    public String getNomeCliente(){return nomeCliente;} public void setNomeCliente(String n){this.nomeCliente=n;}
    public String getTelefoneCliente(){return telefoneCliente;} public void setTelefoneCliente(String t){this.telefoneCliente=t;}
    public String getEnderecoEntrega(){return enderecoEntrega;} public void setEnderecoEntrega(String e){this.enderecoEntrega=e;}
    public String getFormaPagamento(){return formaPagamento;} public void setFormaPagamento(String f){this.formaPagamento=f;}
    public String getStatus(){return status;} public void setStatus(String s){this.status=s;}
    public BigDecimal getTotalBruto(){return totalBruto;} public void setTotalBruto(BigDecimal t){this.totalBruto=t;}
    public BigDecimal getTotalFinal(){return totalFinal;} public void setTotalFinal(BigDecimal t){this.totalFinal=t;}
    public BigDecimal getDesconto(){return desconto;} public void setDesconto(BigDecimal d){this.desconto=d;}
    public String getObservacao(){return observacao;} public void setObservacao(String o){this.observacao=o;}
    public String getDataPedido(){return dataPedido;} public void setDataPedido(String d){this.dataPedido=d;}
    public List<ItemPedido> getItens(){return itens;} public void setItens(List<ItemPedido> i){this.itens=i;}
}
