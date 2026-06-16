package strategy;
import java.math.BigDecimal;

/**
 * PADRAO STRATEGY - Interface para formas de pagamento
 */
public interface PagamentoStrategy {
    boolean processar(BigDecimal valor, String nomeCliente);
    String getNomePagamento();
    String getDescricao();
}
