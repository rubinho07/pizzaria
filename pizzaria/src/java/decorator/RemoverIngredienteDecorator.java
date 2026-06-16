package decorator;
import java.math.BigDecimal;

/**
 * Decorator concreto: remove ingrediente (sem custo)
 * Processo de negocio: personalizacao do cliente
 */
public class RemoverIngredienteDecorator extends PizzaDecorator {
    private final String ingrediente;

    public RemoverIngredienteDecorator(PizzaPersonalizavel pizza, String ingrediente) {
        super(pizza);
        this.ingrediente = ingrediente;
    }

    @Override
    public String getNome() {
        return pizza.getNome() + " s/" + ingrediente;
    }

    @Override
    public String getDescricao() {
        return pizza.getDescricao() + " | Sem: " + ingrediente;
    }

    @Override
    public BigDecimal getPreco() {
        return pizza.getPreco(); // sem custo adicional
    }
}
