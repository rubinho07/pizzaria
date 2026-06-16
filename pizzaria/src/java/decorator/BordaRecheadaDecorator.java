package decorator;
import java.math.BigDecimal;

/**
 * Decorator concreto: adiciona borda recheada (+R$5,00)
 */
public class BordaRecheadaDecorator extends PizzaDecorator {
    private static final BigDecimal PRECO = new BigDecimal("5.00");
    private final String tipo; // Catupiry, Cheddar, Chocolate

    public BordaRecheadaDecorator(PizzaPersonalizavel pizza, String tipo) {
        super(pizza);
        this.tipo = tipo;
    }

    @Override
    public String getNome() {
        return pizza.getNome() + " + Borda " + tipo;
    }

    @Override
    public String getDescricao() {
        return pizza.getDescricao() + " | Borda Recheada " + tipo + " (+R$5,00)";
    }

    @Override
    public BigDecimal getPreco() {
        return pizza.getPreco().add(PRECO);
    }
}
