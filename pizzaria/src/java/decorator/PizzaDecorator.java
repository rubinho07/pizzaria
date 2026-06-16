package decorator;
import java.math.BigDecimal;

/**
 * Decorator abstrato - base para todos os adicionais
 * Encapsula um PizzaPersonalizavel e delega as chamadas
 */
public abstract class PizzaDecorator implements PizzaPersonalizavel {
    protected final PizzaPersonalizavel pizza;

    public PizzaDecorator(PizzaPersonalizavel pizza) {
        this.pizza = pizza;
    }

    @Override
    public String getNome() { return pizza.getNome(); }

    @Override
    public String getDescricao() { return pizza.getDescricao(); }

    @Override
    public BigDecimal getPreco() { return pizza.getPreco(); }
}
