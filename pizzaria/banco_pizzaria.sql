CREATE DATABASE IF NOT EXISTS pizzaria;
USE pizzaria;

CREATE TABLE IF NOT EXISTS usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    perfil VARCHAR(20) DEFAULT 'ADMIN'
);

CREATE TABLE IF NOT EXISTS pizza (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    tamanho VARCHAR(5) NOT NULL,
    categoria VARCHAR(50),
    preco DECIMAL(10,2) NOT NULL,
    disponivel BOOLEAN DEFAULT true,
    ingredientes VARCHAR(255),
    imagem_url VARCHAR(255),
    tempo_preparo INT DEFAULT 30,
    calorias INT DEFAULT 0,
    vegana BOOLEAN DEFAULT false,
    sem_gluten BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS adicional (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    tipo VARCHAR(30),
    disponivel BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    telefone_cliente VARCHAR(20),
    endereco_entrega VARCHAR(255),
    forma_pagamento VARCHAR(30),
    status VARCHAR(30) DEFAULT 'AGUARDANDO',
    total_bruto DECIMAL(10,2),
    total_final DECIMAL(10,2),
    desconto DECIMAL(10,2) DEFAULT 0,
    observacao VARCHAR(255),
    data_pedido DATETIME DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS item_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    pizza_id INT NOT NULL,
    nome_pizza VARCHAR(150),
    quantidade INT DEFAULT 1,
    preco_unitario DECIMAL(10,2),
    preco_final DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    adicionais TEXT,
    observacao VARCHAR(255),
    FOREIGN KEY (pedido_id) REFERENCES pedido(id) ON DELETE CASCADE,
    FOREIGN KEY (pizza_id) REFERENCES pizza(id)
);

-- DADOS INICIAIS
INSERT IGNORE INTO usuario (nome, email, senha, perfil) VALUES ('Administrador', 'admin@pizza.com', '123', 'ADMIN');

INSERT INTO pizza (nome, descricao, tamanho, categoria, preco, disponivel, ingredientes, tempo_preparo, calorias, vegana, sem_gluten) VALUES
('Margherita', 'A classica italiana com ingredientes frescos', 'M', 'Tradicional', 35.90, true, 'Molho de tomate, Mozzarella, Manjericao', 25, 720, false, false),
('Calabresa', 'Calabresa artesanal com cebola roxa caramelizada', 'M', 'Tradicional', 38.90, true, 'Molho de tomate, Mozzarella, Calabresa, Cebola roxa', 28, 850, false, false),
('Quatro Queijos', 'Blend de quatro queijos especiais', 'M', 'Especial', 44.90, true, 'Molho de tomate, Mozzarella, Provolone, Parmesao, Gorgonzola', 30, 980, false, false),
('Portuguesa', 'Rica cobertura com ovo, presunto e azeitonas', 'M', 'Tradicional', 41.90, true, 'Molho de tomate, Mozzarella, Presunto, Ovo, Cebola, Azeitona, Pimentao', 28, 890, false, false),
('Frango com Catupiry', 'Frango desfiado com o cremoso catupiry', 'M', 'Especial', 43.90, true, 'Molho de tomate, Mozzarella, Frango desfiado, Catupiry', 30, 920, false, false),
('Pepperoni', 'Generosa quantidade de pepperoni importado', 'M', 'Premium', 49.90, true, 'Molho de tomate, Mozzarella, Pepperoni importado, Oregano', 25, 1050, false, false),
('Vegana Especial', 'Pizza deliciosa sem ingredientes animais', 'M', 'Especial', 39.90, true, 'Molho de tomate, Mozzarella vegana, Berinjela, Abobrinha, Pimentao, Tomate seco', 30, 650, true, false),
('Chocolate com Morango', 'Sobremesa irresistivel em forma de pizza', 'M', 'Doce', 42.90, true, 'Chocolate ao leite, Morango fresco, Chocolate branco', 20, 1100, false, false);

INSERT INTO adicional (nome, descricao, preco, tipo, disponivel) VALUES
('Mozzarella Extra', 'Dobro de mozzarella', 4.00, 'INGREDIENTE', true),
('Pepperoni Extra', 'Mais pepperoni importado', 5.00, 'INGREDIENTE', true),
('Bacon', 'Bacon crocante defumado', 4.00, 'INGREDIENTE', true),
('Ovo', 'Ovo cozido fatiado', 2.00, 'INGREDIENTE', true),
('Champignon', 'Champignon ao vinho', 5.00, 'INGREDIENTE', true),
('Tomate Seco', 'Tomate seco temperado', 4.00, 'INGREDIENTE', true),
('Catupiry', 'Catupiry cremoso original', 4.00, 'INGREDIENTE', true),
('Rucula', 'Rucula fresca apos assar', 2.00, 'INGREDIENTE', true);

SELECT 'usuarios' as tabela, COUNT(*) as total FROM usuario
UNION ALL SELECT 'pizzas', COUNT(*) FROM pizza
UNION ALL SELECT 'adicionais', COUNT(*) FROM adicional;
