package decorator;
import java.math.BigDecimal;

/**
 * PADRAO DECORATOR - Interface base
 * Define o contrato para pizzas e personalizacoes
 */
public interface PizzaPersonalizavel {
    String getNome();
    String getDescricao();
    BigDecimal getPreco();
}
