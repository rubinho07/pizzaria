package decorator;
import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * Decorator concreto: aplica desconto percentual
 * Processo de negocio: promocao ou cupom
 */
public class DescontoDecorator extends PizzaDecorator {
    private final BigDecimal percentual;
    private final String descricaoDesconto;

    public DescontoDecorator(PizzaPersonalizavel pizza, BigDecimal percentual, String descricao) {
        super(pizza);
        this.percentual = percentual;
        this.descricaoDesconto = descricao;
    }

    @Override
    public String getDescricao() {
        return pizza.getDescricao() + " | " + descricaoDesconto + " (-" + percentual + "%)";
    }

    @Override
    public BigDecimal getPreco() {
        BigDecimal desconto = pizza.getPreco()
            .multiply(percentual)
            .divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);
        return pizza.getPreco().subtract(desconto);
    }

    public BigDecimal getValorDesconto() {
        return pizza.getPreco()
            .multiply(percentual)
            .divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);
    }
}
