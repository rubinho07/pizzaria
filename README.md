#  Sistema de Pizzaria Web

## Descrição

Sistema web de gerenciamento de pedidos para uma pizzaria, desenvolvido em Java utilizando JSP, Servlets e banco de dados MySQL.

O sistema permite que clientes visualizem o cardápio, personalizem pizzas e realizem pedidos, enquanto administradores podem gerenciar pizzas e acompanhar os pedidos realizados.

## Objetivo

Aplicar conceitos de Programação Orientada a Objetos, desenvolvimento web Java, integração com banco de dados e utilização de Design Patterns.

## Tecnologias Utilizadas

* Java
* JSP
* Servlets
* Apache Tomcat
* MySQL
* HTML
* CSS
* GitHub
* NetBeans

## Funcionalidades

### Cliente

* Login no sistema
* Visualização do cardápio
* Personalização de pizzas
* Adição de ingredientes extras
* Remoção de ingredientes
* Seleção de borda recheada
* Escolha do tamanho da pizza
* Finalização de pedidos

### Administrador

* Cadastro de pizzas
* Alteração de pizzas
* Exclusão de pizzas
* Visualização de pedidos
* Painel administrativo

## Padrões de Projeto Utilizados

### Decorator

Utilizado para personalização das pizzas, permitindo adicionar funcionalidades dinamicamente:

* Ingrediente Extra
* Borda Recheada
* Tamanho Grande
* Remoção de Ingredientes
* Aplicação de Descontos

Classes principais:

* PizzaBase
* PizzaDecorator
* IngredienteExtraDecorator
* BordaRecheadaDecorator
* TamanhoGrandeDecorator
* RemoverIngredienteDecorator
* DescontoDecorator

### Strategy

Utilizado para os diferentes métodos de pagamento:

* PagamentoPixStrategy
* PagamentoCartaoStrategy
* PagamentoDinheiroStrategy

## Estrutura do Projeto

```text
src/java/
├── controller/
├── dao/
├── model/
├── decorator/
├── strategy/
└── util/

web/
├── admin/
├── css/
├── WEB-INF/
├── index.jsp
├── login.jsp
├── cardapio.jsp
├── personalizar.jsp
├── pedido.jsp
└── confirmacao.jsp
```

## Banco de Dados

O script de criação do banco encontra-se no arquivo:

```text
banco_pizzaria.sql
```

Importe o script no MySQL antes de executar a aplicação.

## Como Executar

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/pizzaria.git
```

2. Abra o projeto no NetBeans.

3. Configure a conexão com o MySQL.

4. Execute o script `banco_pizzaria.sql`.

5. Inicie o Apache Tomcat.

6. Execute o projeto.

## Autor

Luis Fernando Rubinho Souza

Arthur Zanelato Souza

## Projeto Acadêmico

Projeto desenvolvido para fins acadêmicos com foco na aplicação de Programação Orientada a Objetos, Banco de Dados e Design Patterns.
