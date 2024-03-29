-- MySQL Script generated by MySQL Workbench
-- Tue May 31 12:51:22 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema banco
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `banco` ;

-- -----------------------------------------------------
-- Schema banco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `banco` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `banco` ;

-- -----------------------------------------------------
-- Table `banco`.`caixa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`caixa` ;

CREATE TABLE IF NOT EXISTS `banco`.`caixa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_cadastro` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `saldo` INT NULL DEFAULT NULL,
  `status` CHAR(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`categoria` ;

CREATE TABLE IF NOT EXISTS `banco`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(2000) NULL DEFAULT NULL,
  `ativo` CHAR(1) NOT NULL DEFAULT 'A',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`estado` ;

CREATE TABLE IF NOT EXISTS `banco`.`estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `sigla` CHAR(2) NOT NULL,
  `ativo` CHAR(1) NOT NULL DEFAULT 'A',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ESTADO_NOME_U` (`nome` ASC) VISIBLE,
  UNIQUE INDEX `ESTADO_SIGLA_U` (`sigla` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`cidade` ;

CREATE TABLE IF NOT EXISTS `banco`.`cidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `estado_id` INT NOT NULL,
  `ativo` CHAR(1) NOT NULL DEFAULT 'A',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `CIDADE_UNIQUE` (`nome` ASC, `estado_id` ASC) VISIBLE,
  INDEX `CIDADE_EST_FK` (`estado_id` ASC) VISIBLE,
  CONSTRAINT `CIDADE_EST_FK`
    FOREIGN KEY (`estado_id`)
    REFERENCES `banco`.`estado` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`cliente` ;

CREATE TABLE IF NOT EXISTS `banco`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf_cnpj` VARCHAR(18) NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  `endereo_numero` VARCHAR(20) NOT NULL,
  `endereco_bairro` VARCHAR(100) NOT NULL,
  `CEP` VARCHAR(10) NOT NULL,
  `fone` VARCHAR(15) NULL DEFAULT NULL,
  `ativo` CHAR(1) NOT NULL DEFAULT 'A',
  `cidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `FORNECEDOR_CPFCNPJ_U` (`cpf_cnpj` ASC) VISIBLE,
  INDEX `fk_cliente_cidade1_idx` (`cidade_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `banco`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`funcionario` ;

CREATE TABLE IF NOT EXISTS `banco`.`funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `CPF` CHAR(14) NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  `fone` VARCHAR(15) NULL DEFAULT NULL,
  `ativo` CHAR(1) NOT NULL DEFAULT 'A',
  `cidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `FUNCIONARIO_CPF_U` (`CPF` ASC) VISIBLE,
  INDEX `FUNCIONARIO_CID_FK` (`cidade_id` ASC) VISIBLE,
  CONSTRAINT `FUNCIONARIO_CID_FK`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `banco`.`cidade` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`ordem_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`ordem_servico` ;

CREATE TABLE IF NOT EXISTS `banco`.`ordem_servico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `e_orcamento` CHAR(1) NOT NULL DEFAULT 'S',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `desconto` DECIMAL(12,2) NULL DEFAULT NULL,
  `acrescimo` DECIMAL(12,2) NULL DEFAULT NULL,
  `total` DECIMAL(12,2) NOT NULL,
  `funcionario_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `COMPRA_FORNECEDOR_FK` (`cliente_id` ASC) VISIBLE,
  INDEX `COMPRA_FUNCIONARIO_FK` (`funcionario_id` ASC) VISIBLE,
  CONSTRAINT `COMPRA_FORNECEDOR_FK`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `banco`.`cliente` (`id`),
  CONSTRAINT `COMPRA_FUNCIONARIO_FK`
    FOREIGN KEY (`funcionario_id`)
    REFERENCES `banco`.`funcionario` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`forma_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`forma_pagamento` ;

CREATE TABLE IF NOT EXISTS `banco`.`forma_pagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `quantidade_parcela` INT NOT NULL,
  `entrada` CHAR(1) NOT NULL,
  `atiuvo` CHAR(1) NOT NULL DEFAULT 'A',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`conta_receber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`conta_receber` ;

CREATE TABLE IF NOT EXISTS `banco`.`conta_receber` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `forma_pagamento_id` INT NOT NULL,
  `ordem_servico_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conta_receber_forma_pagamento1_idx` (`forma_pagamento_id` ASC) VISIBLE,
  INDEX `fk_conta_receber_ordem_servico1_idx` (`ordem_servico_id` ASC) VISIBLE,
  CONSTRAINT `fk_conta_receber_forma_pagamento1`
    FOREIGN KEY (`forma_pagamento_id`)
    REFERENCES `banco`.`forma_pagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conta_receber_ordem_servico1`
    FOREIGN KEY (`ordem_servico_id`)
    REFERENCES `banco`.`ordem_servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`icaixa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`icaixa` ;

CREATE TABLE IF NOT EXISTS `banco`.`icaixa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NULL DEFAULT NULL,
  `natureza` CHAR(1) NOT NULL,
  `valor` INT NOT NULL,
  `hora` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recebimento_id` INT NULL DEFAULT NULL,
  `caixa_id` INT NOT NULL,
  PRIMARY KEY (`id`, `caixa_id`),
  INDEX `fk_icaixa_caixa1_idx` (`caixa_id` ASC) VISIBLE,
  CONSTRAINT `fk_icaixa_caixa1`
    FOREIGN KEY (`caixa_id`)
    REFERENCES `banco`.`caixa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`marca` ;

CREATE TABLE IF NOT EXISTS `banco`.`marca` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(100) NULL DEFAULT NULL,
  `ativo` CHAR(1) NOT NULL DEFAULT 'A',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`unidade_medida`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`unidade_medida` ;

CREATE TABLE IF NOT EXISTS `banco`.`unidade_medida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `sigla` VARCHAR(10) NOT NULL,
  `ativo` CHAR(1) NOT NULL DEFAULT 'A',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `SIGLA` (`sigla` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`peca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`peca` ;

CREATE TABLE IF NOT EXISTS `banco`.`peca` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `codigo_barra` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(2000) NULL DEFAULT NULL,
  `preco_custo` DECIMAL(12,2) NOT NULL,
  `preco_venda` DECIMAL(12,2) NOT NULL,
  `ativo` CHAR(1) NOT NULL DEFAULT 'A',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estoque` INT NOT NULL DEFAULT '0',
  `unidade_medida_id` INT NOT NULL,
  `marca_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `PROD_FK_UMEDIDA` (`unidade_medida_id` ASC) VISIBLE,
  INDEX `PROD_FK_MARCA` (`marca_id` ASC) VISIBLE,
  CONSTRAINT `PROD_FK_MARCA`
    FOREIGN KEY (`marca_id`)
    REFERENCES `banco`.`marca` (`id`),
  CONSTRAINT `PROD_FK_UMEDIDA`
    FOREIGN KEY (`unidade_medida_id`)
    REFERENCES `banco`.`unidade_medida` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`servico` ;

CREATE TABLE IF NOT EXISTS `banco`.`servico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `custo` DECIMAL(12,2) NOT NULL,
  `preco` DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco`.`servico_realizado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`servico_realizado` ;

CREATE TABLE IF NOT EXISTS `banco`.`servico_realizado` (
  `id` INT NOT NULL,
  `comissao` DECIMAL(12,2) NULL,
  `funcionario_id` INT NOT NULL,
  `servico_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servico_realizado_funcionario1_idx` (`funcionario_id` ASC) VISIBLE,
  INDEX `fk_servico_realizado_servico1_idx` (`servico_id` ASC) VISIBLE,
  CONSTRAINT `fk_servico_realizado_funcionario1`
    FOREIGN KEY (`funcionario_id`)
    REFERENCES `banco`.`funcionario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_realizado_servico1`
    FOREIGN KEY (`servico_id`)
    REFERENCES `banco`.`servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco`.`item_ordem_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`item_ordem_servico` ;

CREATE TABLE IF NOT EXISTS `banco`.`item_ordem_servico` (
  `quantidade` INT NOT NULL,
  `desconto` DECIMAL(12,2) NULL DEFAULT NULL,
  `ordem_servico_id` INT NOT NULL,
  `peca_id` INT NOT NULL,
  `servico_realizado_id` INT NOT NULL,
  PRIMARY KEY (`ordem_servico_id`),
  INDEX `fk_item_orcamento_peca1_idx` (`peca_id` ASC) VISIBLE,
  INDEX `fk_item_ordem_servico_ordem_servico1_idx` (`ordem_servico_id` ASC) VISIBLE,
  INDEX `fk_item_ordem_servico_servico_realizado1_idx` (`servico_realizado_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_orcamento_peca1`
    FOREIGN KEY (`peca_id`)
    REFERENCES `banco`.`peca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_ordem_servico_ordem_servico1`
    FOREIGN KEY (`ordem_servico_id`)
    REFERENCES `banco`.`ordem_servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_ordem_servico_servico_realizado1`
    FOREIGN KEY (`servico_realizado_id`)
    REFERENCES `banco`.`servico_realizado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`parcela_receber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`parcela_receber` ;

CREATE TABLE IF NOT EXISTS `banco`.`parcela_receber` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valor` DECIMAL(12,2) NOT NULL,
  `valor_quitado` DECIMAL(12,2) NULL DEFAULT '0.00',
  `juros_pago` DECIMAL(12,2) NULL DEFAULT '0.00',
  `desconto` DECIMAL(12,2) NULL DEFAULT '0.00',
  `vencimento` DATETIME NULL DEFAULT NULL,
  `conta_receber_id` INT NOT NULL,
  PRIMARY KEY (`id`, `conta_receber_id`),
  INDEX `fk_parcela_receber_conta_receber1_idx` (`conta_receber_id` ASC) VISIBLE,
  CONSTRAINT `fk_parcela_receber_conta_receber1`
    FOREIGN KEY (`conta_receber_id`)
    REFERENCES `banco`.`conta_receber` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`recebimento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`recebimento` ;

CREATE TABLE IF NOT EXISTS `banco`.`recebimento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NULL DEFAULT NULL,
  `valor` DECIMAL(12,2) NULL DEFAULT NULL,
  `data_recebimento` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `parcela_receber_id` INT NOT NULL,
  `icaixa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recebimento_parcela_receber1_idx` (`parcela_receber_id` ASC) VISIBLE,
  INDEX `fk_recebimento_icaixa1_idx` (`icaixa_id` ASC) VISIBLE,
  CONSTRAINT `fk_recebimento_parcela_receber1`
    FOREIGN KEY (`parcela_receber_id`)
    REFERENCES `banco`.`parcela_receber` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recebimento_icaixa1`
    FOREIGN KEY (`icaixa_id`)
    REFERENCES `banco`.`icaixa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`peca_categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`peca_categoria` ;

CREATE TABLE IF NOT EXISTS `banco`.`peca_categoria` (
  `peca_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`peca_id`, `categoria_id`),
  INDEX `PRODCAT_CATEGORIA_FK` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `PRODCAT_CATEGORIA_FK`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `banco`.`categoria` (`id`),
  CONSTRAINT `PRODCAT_PRODUTO_FK`
    FOREIGN KEY (`peca_id`)
    REFERENCES `banco`.`peca` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*
EXEMPLO DE FUNCTION
DELIMITER //
CREATE FUNCTION  verificar_cpf ( cpf_busca VARCHAR(11) )
RETURNS VARCHAR(200) DETERMINISTIC 
BEGIN
		DECLARE retorno VARCHAR(100);
        DECLARE fim_loop int DEFAULT 0;
        DECLARE cpf_comparar VARCHAR(11);
		
        DECLARE meu_cursor CURSOR FOR SELECT funcionario.cpf FROM funcionario;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_loop = 1;
        
        OPEN meu_cursor;
        WHILE( fim_loop != 1 ) DO
			FETCH meu_cursor INTO cpf_comparar;
            IF cpf_busca != cpf_comparar THEN
				SET retorno = 'DADO INEXISTENTE';
            ELSE
				SET retorno = 'CPF JÁ EXISTENTE';
            END IF;
            
        END WHILE ;
        
        RETURN retorno;
END ;
//
DELIMITER ;
*/ 

/*
EXEMPLO DE TRIGGER
DELIMITER //
	CREATE TRIGGER teste_decisao
    BEFORE INSERT ON item_venda
    FOR EACH ROW
    BEGIN
		DECLARE qtde_estoque INT;
        
        SELECT estoque INTO qtde_estoque FROM produto WHERE id = NEW.produto_id;
        
		IF NEW.quantidade < qtde_estoque THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'QTDE. ESTOQUE SUPERIOR';
        END IF;
    END;
//
DELIMITER  ;
*/

DELIMITER //
CREATE PROCEDURE verifica_par_impar (numero INT)
BEGIN
    DECLARE ativo CHAR;
    SELECT cliente.ativo INTO ativo FROM cliente WHERE cliente.id = id_cliente;
    IF ativo = 'N' THEN
    BEGIN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CLIENTE INATIVO';
    END;
    END IF;
    INSERT INTO venda (cliente_id) VALUES (id_cliente);
END;
//
DELIMITER ;

/*
EXEMPLO DE PROCEDURE
DELIMITER //
CREATE PROCEDURE insere_venda (id_cliente INT)
BEGIN
    DECLARE ativo CHAR; 
    SELECT cliente.ativo INTO ativo FROM cliente WHERE cliente.id = id_cliente;
    IF ativo = 'N' THEN
    BEGIN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CLIENTE INATIVO';
    END;
    END IF;
    INSERT INTO venda (cliente_id) VALUES (id_cliente);
END;
//
DELIMITER ;

SELECT * FROM venda; -- verificando se há venda
CALL insere_venda(1); -- executando procedure

SELECT * FROM venda; -- verificando se deu certo
CALL insere_venda(4); -- deverá gerar erro
*/
