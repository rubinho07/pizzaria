package decorator;
import java.math.BigDecimal;

/**
 * Decorator concreto: adiciona ingrediente extra
 */
public class IngredienteExtraDecorator extends PizzaDecorator {
    private final String ingrediente;
    private final BigDecimal preco;

    public IngredienteExtraDecorator(PizzaPersonalizavel pizza, String ingrediente, BigDecimal preco) {
        super(pizza);
        this.ingrediente = ingrediente;
        this.preco = preco;
    }

    @Override
    public String getNome() {
        return pizza.getNome() + " + " + ingrediente;
    }

    @Override
    public String getDescricao() {
        return pizza.getDescricao() + " | Extra: " + ingrediente + " (+R$" + preco + ")";
    }

    @Override
    public BigDecimal getPreco() {
        return pizza.getPreco().add(preco);
    }
}
