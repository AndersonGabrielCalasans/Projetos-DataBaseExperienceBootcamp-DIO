-- Criação de banco de dados para o cenário de E-commerce
-- DROP DATABASE ecommerce;
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Criação das tabelas:
-- Tabela cliente_pf:
CREATE TABLE IF NOT EXISTS cliente_pf(
		id_cliente_pf INT AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(20) NOT NULL,
        sobrenome VARCHAR(45),
        cpf CHAR(11),
        data_nascimento DATE,
        telefone VARCHAR(20) NOT NULL,
        email VARCHAR(120),
        endereco VARCHAR(200)
);

-- Tabela responsavel_pj:
CREATE TABLE IF NOT EXISTS responsavel_pj(
	id_responsavel_pj INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(45),
    cpf CHAR(11),
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(120),
    cargo VARCHAR(45) NOT NULL
);

-- Tabela anunciante_ext: 
CREATE TABLE IF NOT EXISTS anunciante_ext(
	id_anunciante_ext INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(120) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    responsavel VARCHAR(45),
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(120),
    site VARCHAR(45),
    endereco VARCHAR(200)
);

-- Tabela cliente_pj:
CREATE TABLE IF NOT EXISTS cliente_pj(
	id_cliente_pj INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(120),
    cnpj CHAR(14),
    telefone VARCHAR(20),
    email VARCHAR(120),
    endereco VARCHAR(200),
    id_responsavel_pj_fk INT,
    CONSTRAINT FOREIGN KEY (id_responsavel_pj_fk) REFERENCES responsavel_pj(id_responsavel_pj)
);

-- Tabela categoria:
CREATE TABLE IF NOT EXISTS categoria(
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(45), 
    colecao VARCHAR(45)
);

-- Tabela fornecedor:
CREATE TABLE IF NOT EXISTS fornecedor(
	id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(120) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    responsavel VARCHAR(45),
    cargo VARCHAR(45),
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(120),
    site VARCHAR(45),
    endereco VARCHAR(200)
);

-- Tabela loja:
CREATE TABLE IF NOT EXISTS loja(
	id_loja INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    endereco VARCHAR(200) NOT NULL
);

-- Tabela produto:
CREATE TABLE IF NOT EXISTS produto(
	id_produto INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(120) NOT NULL,
    tamanho VARCHAR(10),
    preco DECIMAL(8,2),
    descricao TEXT,
    CONSTRAINT nome_produto UNIQUE (nome)
);

-- Tabela pagamento:
CREATE TABLE IF NOT EXISTS pagamento(
	id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    forma_pagamento ENUM('DEBITO', 'CREDITO', 'BOLETO', 'PIX') NOT NULL,
    banco VARCHAR(45),
    numero_cartao INT,
    nome_titular VARCHAR(45),
    cpf_titular CHAR(11),
    data_vencimento VARCHAR(5),
    cod_seg DECIMAL(3)
);

-- Tabela pessoa_cliente:
CREATE TABLE IF NOT EXISTS pessoa_cliente(
	id_pessoa_cliente INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente_pf_fk INT,
    id_cliente_pj_fk INT,
    CONSTRAINT FOREIGN KEY (id_cliente_pf_fk) REFERENCES cliente_pf(id_cliente_pf),
    CONSTRAINT FOREIGN KEY (id_cliente_pj_fk) REFERENCES cliente_pj(id_cliente_pj)
    );
    
-- para evitar erros vi a necessidade de definir o auto increment de id cliente = 1
ALTER TABLE pessoa_cliente AUTO_INCREMENT = 1;

-- Tabela pagamento_cliente:
CREATE TABLE IF NOT EXISTS pagamento_cliente(	
    id_pagamento_fk INT NOT NULL,
    id_cliente_fk INT NOT NULL,
    PRIMARY KEY (id_pagamento_fk, id_cliente_fk),
	CONSTRAINT FOREIGN KEY (id_pagamento_fk) REFERENCES pagamento(id_pagamento),
    CONSTRAINT FOREIGN KEY (id_cliente_fk) REFERENCES pessoa_cliente(id_pessoa_cliente)
);

-- Tabela pedido:
CREATE TABLE IF NOT EXISTS pedido(
	id_pedido INT AUTO_INCREMENT,
	data_pedido DATETIME DEFAULT NOW(),
    id_pessoa_cliente_fk INT NOT NULL,
	id_pagamento_fk INT NOT NULL,
    status_pedido ENUM('PAGO','CANCELADO','EM PROCESSAMENTO') DEFAULT 'EM PROCESSAMENTO',
    descricao VARCHAR(200),
    frete FLOAT,
    valor_pedido DECIMAL(5,2) NOT NULL,
    valor_desconto DECIMAL(5,2),
    valor_a_pagar DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (id_pedido, data_pedido, id_pessoa_cliente_fk, id_pagamento_fk),
    CONSTRAINT FOREIGN KEY (id_pessoa_cliente_fk) REFERENCES pessoa_cliente(id_pessoa_cliente),
    CONSTRAINT FOREIGN KEY (id_pagamento_fk) REFERENCES pagamento(id_pagamento)
);

-- Tabela entrega:
CREATE TABLE IF NOT EXISTS entrega(
	id_entrega INT AUTO_INCREMENT,
    id_pedido_fk INT NOT NULL,
    status_entrega ENUM('EM PROCESSAMENTO', 'EM TRANSITO', 'ENTREGUE') DEFAULT 'EM PROCESSAMENTO',
    cod_rastreio VARCHAR(20),
    PRIMARY KEY (id_entrega, id_pedido_fk),
    CONSTRAINT FOREIGN KEY (id_pedido_fk) REFERENCES pedido(id_pedido)
);

-- Tabela categoria_produto:
CREATE TABLE IF NOT EXISTS categoria_produto(
	id_produto_fk INT NOT NULL,
    id_categoria_fk INT NOT NULL,
    PRIMARY KEY (id_produto_fk, id_categoria_fk),
    CONSTRAINT FOREIGN KEY (id_produto_fk) REFERENCES produto(id_produto),
    CONSTRAINT FOREIGN KEY (id_categoria_fk) REFERENCES categoria(id_categoria)
);

-- Tabela produto_anunciante_ext:
CREATE TABLE IF NOT EXISTS produto_anunciante_ext(
	id_anunciante_ext_fk INT NOT NULL,
    id_produto_fk INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_anunciante_ext_fk, id_produto_fk),
    CONSTRAINT FOREIGN KEY (id_anunciante_ext_fk) REFERENCES anunciante_ext(id_anunciante_ext),
    CONSTRAINT FOREIGN KEY (id_produto_fk) REFERENCES produto(id_produto)
);

-- Tabela produto_pedido:
CREATE TABLE IF NOT EXISTS produto_pedido(
	id_produto_fk INT NOT NULL,
    id_pedido_fk INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_produto_fk, id_pedido_fk),
    CONSTRAINT FOREIGN KEY (id_produto_fk) REFERENCES produto(id_produto),
    CONSTRAINT FOREIGN KEY (id_pedido_fk) REFERENCES pedido(id_pedido)
);

-- Tabela estoque_loja:
CREATE TABLE IF NOT EXISTS estoque_loja(
	id_loja_fk INT NOT NULL,
    id_produto_fk INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_loja_fk, id_produto_fk),
    CONSTRAINT FOREIGN KEY (id_loja_fk) REFERENCES loja(id_loja),
    CONSTRAINT FOREIGN KEY (id_produto_fk) REFERENCES produto(id_produto)
);

-- Tabela fornecedor_produto:
CREATE TABLE IF NOT EXISTS fornecedor_produto(
	id_fornecedor_fk INT NOT NULL,
    id_produto_fk INT NOT NULL,
    quantidade INT NOT NULL,
    custo_und DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (id_fornecedor_fk, id_produto_fk),
    CONSTRAINT FOREIGN KEY (id_fornecedor_fk) REFERENCES fornecedor(id_fornecedor),
    CONSTRAINT FOREIGN KEY (id_produto_fk) REFERENCES produto(id_produto)
);

-- listando e confirmando se todas as tabelas foram criadas:
SHOW TABLES;