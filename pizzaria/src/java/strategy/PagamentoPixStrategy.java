package strategy;
import java.math.BigDecimal;

public class PagamentoPixStrategy implements PagamentoStrategy {
    @Override
    public boolean processar(BigDecimal valor, String nomeCliente) {
        System.out.println("[Pagamento PIX] R$" + valor + " - Cliente: " + nomeCliente);
        return true;
    }
    @Override public String getNomePagamento() { return "PIX"; }
    @Override public String getDescricao() { return "Pagamento via PIX - chave: pizzaria@pix.com"; }
}
