-- -----------------------------------------------------
-- Schema oficina_mecanica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS oficina_mecanica DEFAULT CHARACTER SET utf8 ;
USE oficina_mecanica ;
show schemas;
-- -----------------------------------------------------
-- Table oficina_mecanica.pessoa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.pessoa (
  id_pessoa INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(200) NOT NULL,
  tipo ENUM('PF', 'PJ') NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(200) NULL,
  endereco TEXT NULL,
  PRIMARY KEY (id_pessoa))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oficina_mecanica.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.cliente (
  id_cliente INT NOT NULL AUTO_INCREMENT,
  id_pessoa_fk INT NOT NULL,
  cpf_cnpj VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_cliente),
  INDEX fk_cliente_pessoa1_idx (id_pessoa_fk ASC) VISIBLE,
  UNIQUE INDEX cpf_UNIQUE (cpf_cnpj ASC) VISIBLE,
  CONSTRAINT fk_cliente_pessoa1 FOREIGN KEY (id_pessoa_fk) REFERENCES oficina_mecanica.pessoa (id_pessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.funcionario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.funcionario (
  id_funcionario INT NOT NULL AUTO_INCREMENT COMMENT 'Matricula do funcionário',
  id_pessoa_fk INT NOT NULL,
  data_admissao DATE NOT NULL,
  data_demissao DATE NULL,
  PRIMARY KEY (id_funcionario),
  INDEX fk_funcionario_pessoa1_idx (id_pessoa_fk ASC) VISIBLE,
  CONSTRAINT fk_funcionario_pessoa1 FOREIGN KEY (id_pessoa_fk) REFERENCES oficina_mecanica.pessoa (id_pessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.modelo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.modelo (
  id_modelo INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(45) NOT NULL COMMENT 'SUV, Hacth, Sedan, Caminhão...',
  marca VARCHAR(45) NOT NULL,
  modelo VARCHAR(45) NOT NULL,
  ano INT NOT NULL,
  cor VARCHAR(45) NULL,
  PRIMARY KEY (id_modelo))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.veiculo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.veiculo (
  id_veiculo INT NOT NULL AUTO_INCREMENT,
  id_cliente_fk INT NOT NULL,
  id_modelo_fk INT NOT NULL,
  placa VARCHAR(8) NOT NULL,
  chaci VARCHAR(45) NULL,
  PRIMARY KEY (id_veiculo),
  INDEX fk_veiculo_cliente_idx (id_cliente_fk ASC) VISIBLE,
  INDEX fk_veiculo_modelo1_idx (id_modelo_fk ASC) VISIBLE,
  UNIQUE INDEX placa_UNIQUE (placa ASC) VISIBLE,
  UNIQUE INDEX chaci_UNIQUE (chaci ASC) VISIBLE,
  CONSTRAINT fk_veiculo_cliente FOREIGN KEY (id_cliente_fk) REFERENCES oficina_mecanica.cliente (id_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_veiculo_modelo1 FOREIGN KEY (id_modelo_fk) REFERENCES oficina_mecanica.modelo (id_modelo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.ordem_servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.ordem_servico (
  id_ordem_servico INT NOT NULL AUTO_INCREMENT,
  id_cliente_fk INT NOT NULL,
  id_veiculo_fk INT NOT NULL,
  status ENUM('CANCELADO', 'AGUARDANDO LIBERAÇÃO', 'EM ANDAMENTO', 'CONCLUIDO') NOT NULL,
  data_entrada DATETIME NOT NULL DEFAULT NOW(),
  id_funcionario_entrada INT NOT NULL COMMENT 'funcionario de deu entrada na OS',
  id_funcionario_responsavel INT NOT NULL,
  id_funcionario_saida INT NOT NULL COMMENT 'funcionario que deu saida à OS.',
  data_saida DATE NULL,
  descricao VARCHAR(255) DEFAULT NULL,
  valor DECIMAL(5,2) NOT NULL COMMENT '= Serviço/mão de obra + valor dos produtos',
  PRIMARY KEY (id_ordem_servico),
  INDEX fk_atendimento_veiculo1_idx (id_veiculo_fk ASC) VISIBLE,
  INDEX fk_ordem_servico_funcionario1_idx (id_funcionario_entrada ASC) VISIBLE,
  INDEX fk_ordem_servico_funcionario3_idx (id_funcionario_saida ASC) VISIBLE,
  INDEX fk_ordem_servico_cliente1_idx (id_cliente_fk ASC) VISIBLE,
  INDEX fk_ordem_servico_funcionario2_idx (id_funcionario_responsavel ASC) VISIBLE,
  CONSTRAINT fk_atendimento_veiculo1 FOREIGN KEY (id_veiculo_fk) REFERENCES oficina_mecanica.veiculo (id_veiculo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ordem_servico_funcionario1 FOREIGN KEY (id_funcionario_entrada) REFERENCES oficina_mecanica.funcionario (id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ordem_servico_funcionario3 FOREIGN KEY (id_funcionario_saida) REFERENCES oficina_mecanica.funcionario (id_funcionario) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ordem_servico_cliente1 FOREIGN KEY (id_cliente_fk) REFERENCES oficina_mecanica.cliente (id_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ordem_servico_funcionario2 FOREIGN KEY (id_funcionario_responsavel) REFERENCES oficina_mecanica.funcionario (id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.funcao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.funcao (
  id_funcao INT NOT NULL AUTO_INCREMENT,
  setor VARCHAR(45) NOT NULL COMMENT 'Financeiro, operacao, comercial, almoxarifado...',
  funcao VARCHAR(45) NOT NULL COMMENT 'Mecanico, atendente, contador...',
  especialidade VARCHAR(45) NULL COMMENT 'Caso mecanico - funilaria, motores, eletricista... Caso gerencia - supervisor, gerente...',
  PRIMARY KEY (id_funcao))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.servico (
  id_servico INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(45) NOT NULL COMMENT 'CONCERTO, REVISAO, ORCAMENTO',
  descricao TEXT NOT NULL,
  valor DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (id_servico))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.funcionario_funcao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.funcionario_funcao (
  id_funcionario_fk INT NOT NULL,
  id_funcao_fk INT NOT NULL,
  PRIMARY KEY (id_funcionario_fk, id_funcao_fk),
  INDEX fk_funcionario_has_funcao_funcao1_idx (id_funcao_fk ASC) VISIBLE,
  INDEX fk_funcionario_has_funcao_funcionario1_idx (id_funcionario_fk ASC) VISIBLE,
  CONSTRAINT fk_funcionario_has_funcao_funcionario1 FOREIGN KEY (id_funcionario_fk) REFERENCES oficina_mecanica.funcionario (id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_funcionario_has_funcao_funcao1 FOREIGN KEY (id_funcao_fk) REFERENCES oficina_mecanica.funcao (id_funcao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.produto (
  id_produto INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(200) NOT NULL,
  modelo VARCHAR(200) NULL,
  marca VARCHAR(45) NULL,
  descricao VARCHAR(200) NULL,
  valor_compra DECIMAL(5,2) NOT NULL COMMENT 'valor por unidade',
  valor_venda DECIMAL(5,2) NOT NULL COMMENT 'valor por unidade',
  PRIMARY KEY (id_produto))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.compra_venda_produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.compra_venda_produto (
  id_compra_venda_produto INT NOT NULL AUTO_INCREMENT,
  id_produto_fk INT NOT NULL,
  quantidade INT NOT NULL,
  tipo ENUM('VENDA', 'COMPRA') NOT NULL,
  valor_venda DECIMAL(5,2) NULL COMMENT '= SOMATORIO(VALOR_VENDA_PRODUTO * QUANTIDADE)',
  valor_compra DECIMAL(5,2) NULL COMMENT '= SOMATORIO(VALOR_COMPRA_PRODUTO * QUANTIDADE)',
  PRIMARY KEY (id_compra_venda_produto),
  INDEX fk_compra_venda_produto1_idx (id_produto_fk ASC) VISIBLE,
  CONSTRAINT fk_compra_venda_produto1 FOREIGN KEY (id_produto_fk) REFERENCES oficina_mecanica.produto (id_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.financeiro_nota
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.financeiro_nota (
  id_nota INT NOT NULL AUTO_INCREMENT,
  ordem_servico_fk INT NULL,
  id_compra_venda_produto_fk INT NULL COMMENT 'Aqui seria o caso de vender/comprar apenas o produto sem gerar OS.',
  id_funcionario_financeiro INT NOT NULL COMMENT 'Funcionario que fez ou recebeu o pagamento',
  data_lancamento DATETIME NOT NULL DEFAULT NOW(),
  tipo ENUM('ENTRADA', 'SAIDA') NOT NULL,
  valor DECIMAL(5,2) NOT NULL,
  status ENUM('PAGO', 'NAO_PAGO') NULL,
  PRIMARY KEY (id_nota),
  INDEX fk_nota_funcionario1_idx (id_funcionario_financeiro ASC) VISIBLE,
  INDEX fk_nota_ordem_servico1_idx (ordem_servico_fk ASC) VISIBLE,
  INDEX fk_financeiro_nota_compra_venda_produto1_idx (id_compra_venda_produto_fk ASC) VISIBLE,
  CONSTRAINT fk_nota_funcionario1 FOREIGN KEY (id_funcionario_financeiro) REFERENCES oficina_mecanica.funcionario (id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_nota_ordem_servico1 FOREIGN KEY (ordem_servico_fk) REFERENCES oficina_mecanica.ordem_servico (id_ordem_servico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_financeiro_nota_compra_venda_produto1
    FOREIGN KEY (id_compra_venda_produto_fk) REFERENCES oficina_mecanica.compra_venda_produto (id_compra_venda_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.servico_solicitado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.servico_solicitado (
  id_servico_fk INT NOT NULL,
  id_ordem_servico_fk INT NOT NULL,
  PRIMARY KEY (id_servico_fk, id_ordem_servico_fk),
  INDEX fk_servico_has_ordem_servico_ordem_servico1_idx (id_ordem_servico_fk ASC) VISIBLE,
  INDEX fk_servico_has_ordem_servico_servico1_idx (id_servico_fk ASC) VISIBLE,
  CONSTRAINT fk_servico_has_ordem_servico_servico1 FOREIGN KEY (id_servico_fk) REFERENCES oficina_mecanica.servico (id_servico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servico_has_ordem_servico_ordem_servico1 FOREIGN KEY (id_ordem_servico_fk) REFERENCES oficina_mecanica.ordem_servico (id_ordem_servico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.fornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.fornecedor (
  id_pessoa_empresa INT NOT NULL,
  id_pessoa_representante_fk INT NULL,
  cnpj VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_pessoa_empresa),
  INDEX fk_representante_pessoa1_idx (id_pessoa_empresa ASC) VISIBLE,
  INDEX fk_representante_representante1_idx (id_pessoa_representante_fk ASC) VISIBLE,
  CONSTRAINT fk_representante_representante1 FOREIGN KEY (id_pessoa_representante_fk) REFERENCES oficina_mecanica.pessoa (id_pessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_representante_pessoa1 FOREIGN KEY (id_pessoa_empresa) REFERENCES oficina_mecanica.pessoa (id_pessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina_mecanica.compra_produto_fornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.compra_produto_fornecedor (
  id_compra_venda_produto_fk INT NOT NULL,
  id_pessoa_empresa_fk INT NOT NULL,
  PRIMARY KEY (id_compra_venda_produto_fk, id_pessoa_empresa_fk),
  INDEX fk_compra_venda_produto_fornecedor1_idx (id_pessoa_empresa_fk ASC) VISIBLE,
  INDEX fk_compra_venda_produto_compra_venda_idx (id_compra_venda_produto_fk ASC) VISIBLE,
  CONSTRAINT fk_compra_venda_produto_has_fornecedor_compra_venda_produto1 FOREIGN KEY (id_compra_venda_produto_fk)
    REFERENCES oficina_mecanica.compra_venda_produto (id_compra_venda_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_compra_venda_produto_has_fornecedor_fornecedor1
    FOREIGN KEY (id_pessoa_empresa_fk)
    REFERENCES oficina_mecanica.fornecedor (id_pessoa_empresa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina_mecanica.produto_usado_ordem_servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina_mecanica.produto_usado_ordem_servico (
  id_produto_fk INT NOT NULL,
  id_ordem_servico_fk INT NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (id_produto_fk, id_ordem_servico_fk),
  INDEX fk_servico_ordem_servico1_idx (id_ordem_servico_fk ASC) VISIBLE,
  INDEX fk_produto1_idx (id_produto_fk ASC) VISIBLE,
  CONSTRAINT fk_ordem_servico_produto1 FOREIGN KEY (id_produto_fk) REFERENCES oficina_mecanica.produto (id_produto) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servico_ordem_servico1 FOREIGN KEY (id_ordem_servico_fk) REFERENCES oficina_mecanica.ordem_servico (id_ordem_servico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;