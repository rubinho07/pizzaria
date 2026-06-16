package decorator;
import java.math.BigDecimal;

/**
 * Decorator concreto: upgrade de tamanho (+R$8,00)
 */
public class TamanhoGrandeDecorator extends PizzaDecorator {
    private static final BigDecimal PRECO = new BigDecimal("8.00");

    public TamanhoGrandeDecorator(PizzaPersonalizavel pizza) {
        super(pizza);
    }

    @Override
    public String getNome() {
        return pizza.getNome().replace("(M)", "(G)").replace("(P)", "(G)");
    }

    @Override
    public String getDescricao() {
        return pizza.getDescricao() + " | Upgrade para GG (+R$8,00)";
    }

    @Override
    public BigDecimal getPreco() {
        return pizza.getPreco().add(PRECO);
    }
}
