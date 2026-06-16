package strategy;
import java.math.BigDecimal;

public class PagamentoCartaoStrategy implements PagamentoStrategy {
    @Override
    public boolean processar(BigDecimal valor, String nomeCliente) {
        System.out.println("[Pagamento Cartao] R$" + valor + " - Cliente: " + nomeCliente);
        return true;
    }
    @Override public String getNomePagamento() { return "Cartao"; }
    @Override public String getDescricao() { return "Cartao de credito/debito na entrega"; }
}
