package decorator;
import java.math.BigDecimal;
import model.Pizza;

/**
 * Componente concreto do Decorator
 * Representa a pizza sem nenhuma personalizacao
 */
public class PizzaBase implements PizzaPersonalizavel {
    private final Pizza pizza;

    public PizzaBase(Pizza pizza) {
        this.pizza = pizza;
    }

    @Override
    public String getNome() {
        return pizza.getNome() + " (" + pizza.getTamanho() + ")";
    }

    @Override
    public String getDescricao() {
        return pizza.getNome() + " - " + pizza.getTamanho();
    }

    @Override
    public BigDecimal getPreco() {
        return pizza.getPreco();
    }
}
