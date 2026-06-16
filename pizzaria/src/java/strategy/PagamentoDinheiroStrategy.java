package strategy;
import java.math.BigDecimal;

public class PagamentoDinheiroStrategy implements PagamentoStrategy {
    @Override
    public boolean processar(BigDecimal valor, String nomeCliente) {
        System.out.println("[Pagamento Dinheiro] R$" + valor + " - Cliente: " + nomeCliente);
        return true;
    }
    @Override public String getNomePagamento() { return "Dinheiro"; }
    @Override public String getDescricao() { return "Pagamento em dinheiro na entrega"; }
}
