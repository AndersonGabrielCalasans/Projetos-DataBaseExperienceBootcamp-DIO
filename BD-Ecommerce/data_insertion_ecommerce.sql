-- Inserção de dados:

-- Usar a base de dados para começar a persistir os dados:
USE ecommerce;

-- Começo adcionando alguns dados, para isso encontro a tabela e dou um DESC para descobrir a ordem a persistir as informações e começo a criar os dados:
SHOW TABLES;
DESC cliente_pf;

-- id_cliente_pf, nome, sobrenome, cpf, data_nascimento YYYY-MM-DD, telefone, email, endereco
INSERT INTO cliente_pf (nome, sobrenome, cpf, data_nascimento, telefone, email, endereco)
	VALUES 	('Gabriel', 'Calasans', 10314248498, '1995-05-03', 81997535500, 'gabrielcalasans@teste.com', 'rua tal, numero 10, jaboatão - PE'),
			('Ligia', 'Paula', 11547259874, '1998-08-10', 81997445587, 'ligiapaula@teste.com', 'rul 2, numero 4, recife - PE'),
            ('Elcida', 'Bezerra', 10547896748, '1971-01-07', 81978457896, 'elcidabezerra@email.com', 'rua ginae, numero 45, paulista - PE'),
            ('Vanda', 'Lima', 52478954731, '1972-04-23', 879794852225, 'vandalima@email.com', 'rua tal, numero 574, jaboatão - PE');
-- verificando se a informação foi persistida corretamente:
SELECT * FROM cliente_pf;

-- id_cliente_pj, razao_social, cnpj, telefone, email, endereco, id_responsavel_pj_fk
DESC cliente_pj;
INSERT INTO cliente_pj (razao_social, cnpj, telefone, email, endereco)
	VALUES 	('The fille', '43559487000145','81999774585', 'thefille@email.com', 'Av Imbiribeira, numero 557, Recife - PE'),
			('LP', '45778554000145', '8133450045', 'lptshit@teste.com', 'Rua fulano de tal, numero 15, Joao Pessoa - PB');
-- verificando se a informação foi persistida corretamente:        
SELECT * FROM cliente_pj;

-- id_responsavel_pj, nome, sobrenome, cpf, telefone, email, cargo
DESC responsavel_pj;
INSERT INTO responsavel_pj (nome, sobrenome, cpf, telefone, email, cargo)
	VALUES  ('Maria', 'Gabriela', '12201201474', '81997455220', 'mariagabriel@email.com', 'comercial'),
			('Pietro', 'Guilherme', '44522144778', '87995544475', 'pietrogui@teste.com', 'vendas');
-- verificando se a informação foi persistida corretamente:  
SELECT * FROM responsavel_pj;

-- relacionando os funcionarios aos clientes_pf
UPDATE cliente_pj SET id_responsavel_pj_fk=1 WHERE id_cliente_pj=1;
UPDATE cliente_pj SET id_responsavel_pj_fk=2 WHERE id_cliente_pj=2;

-- id_anunciante_ext, razao_social, cnpj, responsavel, telefone, email, site, endereco
DESC anunciante_ext;
INSERT INTO anunciante_ext (razao_social, cnpj, responsavel, telefone, email, site, endereco)
	VALUES  ('Dona Cegonha', '43154123000158', 'Laisa', '81997458856', 'donacegonha@email.com', 'www.donacegonha.com', 'rua taltal, numero 26, Recife - PE'),
			('Lojinha da esquina', '4512475300195', 'Tales', '81975468559', 'lojinha@gmail.com', 'lojinhadaesquina.com','rua sao cristóvao, numero 14, Escada - PE');
-- verificando se a informação foi persistida corretamente:  
SELECT * FROM anunciante_ext;

-- id_categoria, tipo, colecao
DESC categoria;
INSERT INTO categoria (tipo, colecao)
	VALUES 	('VESTIDO','INVERNO'),
			('SAIA', 'INVERNO'),
            ('CASACO', 'INVERNO'),
            ('CALÇA', 'INVERNO'),
            ('VESTIDO', 'VERÃO'),
			('BIQUINI', 'VERÃO'),
            ('BLUSA', 'VERÃO'),
            ('CALÇA', 'VERÃO');
-- verificando se a informação foi persistida corretamente:  
SELECT * FROM categoria;

-- id_fornecedor, razao_social, cnpj, responsavel, cargo, telefone, email, site, endereco
DESC fornecedor;
INSERT INTO fornecedor (razao_social, cnpj, responsavel, cargo, telefone, email, site, endereco)
	VALUES ('fornecedor1', '43559784000145', 'Alirio', 'Vendedor', '81999777894', 'fornecedor1@email.com', 'www.fornecedor1.com','Av copacabana, numero 744, Rio de Janeiro - RJ'),
			('fornecedor2', '45778954000147', 'João', 'Vendedor', '81973450047', 'fornecedor2@teste.com', 'www.fornecedor2.com', 'Rua morumbi, numero 459, Sao paulo - SP');
-- verificando se a informação foi persistida corretamente:  
SELECT * FROM fornecedor;

-- id_loja, nome, endereco
DESC loja;
INSERT INTO loja (nome, endereco)
	VALUES ('loja1','Av Sao Sebastiao, numero 112, Jaboatão - PE'),
			('loja2', 'Rua da praia, numero 35, Joao Pessoa - PB'),
            ('loja3', 'Rua Pacaembu, numero 79, Sao paulo - SP');
-- verificando se a informação foi persistida corretamente:  
SELECT * FROM loja;

-- id_produto, nome, endereco
DESC produto;
INSERT INTO produto (nome, tamanho, preco, descricao)
	VALUES 	('Tshirt A','P', 25.99, 'TSHIT CASUAL MODA PRAIA'),
			('Tshirt A','M', 25.99, 'TSHIT CASUAL MODA PRAIA'),
			('Tshirt A','G', 25.99, 'TSHIT CASUAL MODA PRAIA'),
			('Tshirt B', 'PP' , 39.99 ,'TSHIT DA COLEÇÃO VERÃO'),
            ('Tshirt B', 'M' , 39.99 ,'TSHIT DA COLEÇÃO VERÃO'),
            ('Tshirt B', 'GG' , 39.99 ,'TSHIT DA COLEÇÃO VERÃO'),
            ('Jaqueta Jeans', 'U', 199.99, 'JAQUELA FEMININA COLEÇÃO INVERNO'),
            ('Calça jeans', '40', 120.00, 'CALÇA FEMININA INVERNO'),
            ('Calça jeans', '42', 120.00, 'CALÇA FEMININA INVERNO'),
            ('Calça jeans', '44', 120.00, 'CALÇA FEMININA INVERNO'),
            ('Calça jeans', '46', 120.00, 'CALÇA FEMININA INVERNO');
-- verificando se a informação foi persistida corretamente:  
SELECT * FROM pessoa_cliente;

-- id_pagamento, forma_pagamento'enum(''DEBITO'',''CREDITO'',''BOLETO'',''PIX'')', banco, numero_cartao, nome_titular, cpf_titular, data_vencimento, cod_seg
DESC pagamento;
INSERT INTO pagamento (forma_pagamento, banco, numero_cartao, nome_titular, cpf_titular, data_vencimento, cod_seg)
	VALUE 	('DEBITO', null, null, null, null, null, null),
			('PIX', null, null, null, null, null, null);
SELECT * FROM pagamento;

