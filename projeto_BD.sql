DROP DATABASE IF EXISTS aula_banco; 
CREATE DATABASE aula_banco;	
USE aula_banco;	

CREATE TABLE estado(
id INT NOT NULL UNIQUE AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)
);

INSERT INTO estado (id,nome,sigla,ativo, data_cadastro) VALUES (1,'SÃO PAULO','SP','S','2016-10-31');
INSERT INTO estado (id,nome,sigla,ativo, data_cadastro) VALUES (2,'PARANÁ','PR','S','2015-2-25');
INSERT INTO estado (id,nome,sigla,ativo, data_cadastro) VALUES (3,'MATO GROSSO','MT','N','2015-12-02');

CREATE TABLE cidade(
id INT NOT NULL UNIQUE AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL 
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT cidade_unica UNIQUE(nome, estado_id)
);

INSERT INTO cidade (nome, estado_id) VALUES ('BAURU',1);
INSERT INTO cidade (nome, estado_id) VALUES ('MÁRINGA', 2);
INSERT INTO cidade (nome, estado_id) VALUES ('BARRA DOS GARÇAS',3);

CREATE TABLE contato(
id INT NOT NULL UNIQUE AUTO_INCREMENT
,numero VARCHAR(11) NOT NULL 
,email VARCHAR(200) NOT NULL 
,geral VARCHAR(220) AS (CONCAT(numero,'-',email))
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,CONSTRAINT pk_contato PRIMARY KEY (id)
);

INSERT INTO contato (id, numero, email) VALUES (1,'999801213', 'João@Gmail.com');
INSERT INTO contato (id, numero, email) VALUES (2,'997089076', 'Maria@bol.com');
INSERT INTO contato (id, numero, email) VALUES (3,'989007675', 'José@hotmail.com');
INSERT INTO contato (id, numero, email) VALUES (4,'998501213', 'Mauro@Gmail.com');
INSERT INTO contato (id, numero, email) VALUES (5,'992301213', 'Leticia@Gmail.com');
INSERT INTO contato (id, numero, email) VALUES (6,'990001213', 'Laura@Gmail.com');
INSERT INTO contato (id, numero, email) VALUES (7,'998501213', 'Ogochi@Gmail.com');
INSERT INTO contato (id, numero, email) VALUES (8,'999681213', 'Lacoste@Gmail.com');
INSERT INTO contato (id, numero, email) VALUES (9,'995551213', 'Hurley@Gmail.com');

CREATE TABLE funcionario(
id INT NOT NULL UNIQUE AUTO_INCREMENT 
,nome VARCHAR(200) NOT NULL UNIQUE 
,cpf VARCHAR(11) NOT NULL UNIQUE 
,salario DECIMAL NOT NULL
,desempenho INT NOT NULL
,data_cadastro DATE NOT NULL
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,contato_id INT NOT NULL 
,cidade_id INT NOT NULL 
,CONSTRAINT pk_funcionario PRIMARY KEY (id)
,CONSTRAINT fk_funcionario_contato FOREIGN KEY (contato_id) REFERENCES contato (id)
,CONSTRAINT fk_funcionario_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
);

INSERT INTO funcionario (id, nome, cpf, salario, desempenho, data_cadastro, contato_id, cidade_id) VALUES (1, 'JOÃO','11111111111', 1550.00, 50, '2021-03-10', 3, 1);
INSERT INTO funcionario (id, nome, cpf, salario, desempenho, data_cadastro, contato_id, cidade_id) VALUES (2, 'MARIA','22222222222', 2100.00, 70, '2021-10-23', 2, 2);
INSERT INTO funcionario (id, nome, cpf, salario, desempenho, data_cadastro, contato_id, cidade_id) VALUES (3, 'JOSÉ','01212021021', 3000.00, 90, '2021-11-20', 1, 3);

CREATE TABLE cliente(
id INT NOT NULL AUTO_INCREMENT 
,nome VARCHAR(200) NOT NULL UNIQUE 
,cpf CHAR(11) NOT NULL UNIQUE 
,ativo VARCHAR(1) NOT NULL DEFAULT 'A'
,data_cadastro  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,contato_id INT NOT NULL 
,CONSTRAINT pk_cliente PRIMARY KEY (id)
,CONSTRAINT fk_cliente_contato FOREIGN KEY (contato_id) REFERENCES contato (id)
);

INSERT INTO cliente (id, nome, cpf, data_cadastro, contato_id) VALUES (1, 'MAURO', '10912398721', '2021-10-12', 4);
INSERT INTO cliente (id, nome, cpf, data_cadastro, contato_id) VALUES (2, 'LETICIA', '92345686791', '2021-10-15', 5);
INSERT INTO cliente (id, nome, cpf, data_cadastro, contato_id) VALUES (3, 'LAURA', '97834523411', '2021-10-17', 6);

CREATE TABLE produto(
id INT NOT NULL AUTO_INCREMENT 
,categoria ENUM('Calça','Camiseta','Shorts','Meias','Jaqueta')
,tamanho ENUM('P','M','G','GG')
,cor VARCHAR(200)
,tipo VARCHAR(200) 
,descrição VARCHAR(1300) AS (CONCAT(categoria,'-',tipo,'-',cor))
,quantidade INT NOT NULL 
,preço_compra DECIMAL(10,2) NOT NULL  
,CONSTRAINT pk_produto PRIMARY KEY (id)
);

INSERT INTO produto (id, categoria, tamanho, cor, tipo, quantidade, preço_compra) VALUES (1,'Calça','G','Beje','Cargo',10,70.00);   
INSERT INTO produto (id, categoria, tamanho, cor, tipo, quantidade, preço_compra) VALUES (2,'Calça','M','Azul','Jeans',10,60.00); 
INSERT INTO produto (id, categoria, tamanho, cor, tipo, quantidade, preço_compra) VALUES (3,'Jaqueta','G','Preto','Couro',10,80.00);
INSERT INTO produto (id, categoria, tamanho, cor, tipo, quantidade, preço_compra) VALUES (4,'Camiseta','M','Branco','Casual',20,40.00);

CREATE TABLE peças_vendidas(
id INT NOT NULL AUTO_INCREMENT 
,quantidade INT NOT NULL
,valor DECIMAL NOT NULL 
,produto_id INT NOT NULL
,CONSTRAINT pk_peças_vendidas PRIMARY KEY (id)
,CONSTRAINT fk_produto_peças_vendidas FOREIGN KEY (produto_id) REFERENCES produto (id)
);

INSERT INTO peças_vendidas(id, quantidade, valor, produto_id) VALUES (1, 1, 70*1.50, 1);
INSERT INTO peças_vendidas(id, quantidade, valor, produto_id) VALUES (2, 3, 60*1.50, 2);
INSERT INTO peças_vendidas(id, quantidade, valor, produto_id) VALUES (3, 10, 50*1.50, 3);
INSERT INTO peças_vendidas(id, quantidade, valor, produto_id) VALUES (4, 1, 40*1.50, 4);

CREATE TABLE venda(
id INT NOT NULL AUTO_INCREMENT UNIQUE 
,valor_total DECIMAL NOT NULL 
,data_venda DATETIME
,estação VARCHAR(50) NOT NULL 
,cliente_id INT NOT NULL 
,peças_vendidas_id INT NOT NULL
,CONSTRAINT pk_venda PRIMARY KEY (id)
,CONSTRAINT fk_peças_vendidas FOREIGN KEY (peças_vendidas_id) REFERENCES peças_vendidas (id)
,CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

INSERT INTO venda (id, valor_total, data_venda, estação, cliente_id, peças_vendidas_id) VALUES (1, 70*1.50, '2022-07-10', 'VERÃO', 1, 1);
INSERT INTO venda (id, valor_total, data_venda, estação, cliente_id, peças_vendidas_id) VALUES (2, 60*1.50, '2022-01-10', 'OUTONO', 2, 2);
INSERT INTO venda (id, valor_total, data_venda, estação, cliente_id, peças_vendidas_id) VALUES (3, 80*1.50, '2022-06-10', 'INVERNO', 3, 3);
INSERT INTO venda (id, valor_total, data_venda, estação, cliente_id, peças_vendidas_id) VALUES (4, 4*(80*1.50), '2022-06-05', 'INVERNO', 1, 3);
INSERT INTO venda (id, valor_total, data_venda, estação, cliente_id, peças_vendidas_id) VALUES (5, 5*(80*1.50), '2022-06-20', 'INVERNO', 1, 3);

CREATE TABLE recebimento(
id INT NOT NULL AUTO_INCREMENT UNIQUE 
,valor DECIMAL(10,2) NOT NULL
,data_recebimento DATETIME
,cliente_id INT NOT NULL
,venda_id INT NOT NULL 
,CONSTRAINT pk_recebimento PRIMARY KEY (id)
,CONSTRAINT fk_recebimento_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id) 
,CONSTRAINT fk_recebimento_venda FOREIGN KEY (venda_id) REFERENCES venda (id)
);

INSERT INTO recebimento (id, valor, data_recebimento, cliente_id, venda_id) VALUES (1, 70*1.50, '2022-05-10', 1, 1);
INSERT INTO recebimento (id, valor, data_recebimento, cliente_id, venda_id) VALUES (2, 60*1.50, '2022-01-10', 2, 2);
INSERT INTO recebimento (id, valor, data_recebimento, cliente_id, venda_id) VALUES (3, 80*1.50, '2022-09-10', 3, 3);

CREATE TABLE fornecedor(
id INT NOT NULL AUTO_INCREMENT UNIQUE
,nome VARCHAR(200) NOT NULL 
,cnpj CHAR(18) NOT NULL UNIQUE 
,contato_id INT NOT NULL 
,cidade_id INT NOT NULL 
,CONSTRAINT pk_fornecedor PRIMARY KEY (id)
,CONSTRAINT fk_fornecedor_contato FOREIGN KEY (contato_id) REFERENCES contato (id)
,CONSTRAINT fk_fornecedor_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
);

INSERT INTO fornecedor (id, nome, cnpj, contato_id, cidade_id) VALUES (1, 'OGOCHI', '121343123/1111-20', 7, 1);
INSERT INTO fornecedor (id, nome, cnpj, contato_id, cidade_id) VALUES (2, 'LACOSTE', '231343123/4444-30', 8, 2);
INSERT INTO fornecedor (id, nome, cnpj, contato_id, cidade_id) VALUES (3, 'HURLEY', '233343123/9829-89', 9, 3);

CREATE TABLE peças_compradas(
id INT NOT NULL AUTO_INCREMENT 
,quantidade INT NOT NULL
,valor_pago DECIMAL NOT NULL 
,produto_id INT NOT NULL
,CONSTRAINT pk_peças_compradas PRIMARY KEY (id)
,CONSTRAINT fk_peças_compradas_produto FOREIGN KEY (produto_id) REFERENCES produto (id)
);

INSERT INTO peças_compradas (id, quantidade, valor_pago, produto_id) VALUES (1, 10, 70.00, 1);
INSERT INTO peças_compradas (id, quantidade, valor_pago, produto_id) VALUES (2, 10, 60.00, 2);
INSERT INTO peças_compradas (id, quantidade, valor_pago, produto_id) VALUES (3, 10, 50.00, 3);
INSERT INTO peças_compradas (id, quantidade, valor_pago, produto_id) VALUES (4, 20, 40.00, 4);

CREATE TABLE compra(
id INT NOT NULL AUTO_INCREMENT UNIQUE  
,total_da_compra DECIMAL NOT NULL 
,fornecedor_id INT NOT NULL
,peças_compradas_id INT NOT NULL 
,CONSTRAINT pk_compra PRIMARY KEY (id)
,CONSTRAINT fk_compra_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor (id) 
,CONSTRAINT fk_compra_peças_compradas FOREIGN KEY (peças_compradas_id) REFERENCES peças_compradas (id) 
);

INSERT INTO compra (id, total_da_compra, fornecedor_id, peças_compradas_id) VALUES (1, 70.00 * 10, 1, 1);
INSERT INTO compra (id, total_da_compra, fornecedor_id, peças_compradas_id) VALUES (2, 60.00 * 10, 1, 2);
INSERT INTO compra (id, total_da_compra, fornecedor_id, peças_compradas_id) VALUES (3, 50.00 * 10, 1, 3);
INSERT INTO compra (id, total_da_compra, fornecedor_id, peças_compradas_id) VALUES (4, 40.00 * 10, 1, 4);

CREATE TABLE pagamento(
id INT NOT NULL AUTO_INCREMENT UNIQUE 
,valor DECIMAL(10,2) NOT NULL
,data_pagamento  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,fornecedor_id INT NOT NULL
,compra_id INT NOT NULL 
,CONSTRAINT pk_recebimento PRIMARY KEY (id)
,CONSTRAINT fk_pagamento_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor (id) 
,CONSTRAINT fk_pagamento_compra FOREIGN KEY (compra_id) REFERENCES compra (id) 
);

INSERT INTO pagamento (id, valor, data_pagamento, fornecedor_id, compra_id) VALUES (1, 70.00*10, '2020-10-20', 1, 1);
INSERT INTO pagamento (id, valor, data_pagamento, fornecedor_id, compra_id) VALUES (2, 60.00*10, '2020-10-20', 2, 2);
INSERT INTO pagamento (id, valor, data_pagamento, fornecedor_id, compra_id) VALUES (3, 50.00*10, '2020-10-20', 3, 3);

CREATE TABLE caixa(
id INT NOT NULL UNIQUE AUTO_INCREMENT 
,data_do_dia DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,saldo DECIMAL NOT NULL 
,funcionario_id INT NOT NULL 
,CONSTRAINT pk_caixa PRIMARY KEY (id)
,CONSTRAINT fk_caixa_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionario (id) 
);

INSERT INTO caixa (id, data_do_dia, saldo, funcionario_id) VALUES (1, '2018-10-20', 1000.00, 1);
INSERT INTO caixa (id, data_do_dia, saldo, funcionario_id) VALUES (2, '2018-10-20', 1000.00, 2);
INSERT INTO caixa (id, data_do_dia, saldo, funcionario_id) VALUES (3, '2018-10-20', 1000.00, 3);

CREATE TABLE item_de_caixa(
id INT NOT NULL UNIQUE AUTO_INCREMENT 
,valor DECIMAL NOT NULL 
,data_a DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP 
,caixa_id INT NOT NULL 
,pagamento_id INT 
,recebimento_id INT  
,CONSTRAINT pk_item_de_caixa PRIMARY KEY (id) 
,CONSTRAINT fk_item_de_caixa_caixa_id FOREIGN KEY (caixa_id) REFERENCES caixa (id) 
,CONSTRAINT fk_item_de_caixa_pagamento_id FOREIGN KEY (pagamento_id) REFERENCES pagamento (id) 
,CONSTRAINT fk_item_de_caixa_recebimento_id FOREIGN KEY (recebimento_id) REFERENCES recebimento (id) 
);

INSERT INTO item_de_caixa (id, valor, data_a, caixa_id, pagamento_id) VALUES (1, 70.00 * 10, '2020-10-20', 1, 1);
INSERT INTO item_de_caixa (id, valor, data_a, caixa_id, pagamento_id) VALUES (2, 60.00 * 10, '2020-10-20', 2, 2);
INSERT INTO item_de_caixa (id, valor, data_a, caixa_id, pagamento_id) VALUES (3, 50.00 * 10, '2020-10-20', 3, 3);

-- 2 colunas virtuais criadas na tabela produto e uma em contato

DELIMITER //
CREATE FUNCTION vendas_realizadas_nessa_data (data_pesquisada DATETIME)
RETURNS INT DETERMINISTIC 
BEGIN
	DECLARE resultado INT;
    SELECT COUNT(id) INTO resultado FROM venda WHERE data_venda = data_pesquisada;
    RETURN resultado;
END ;
//
DELIMITER ;

DELIMITER // 
CREATE FUNCTION valor_de_revenda ( preço_compra DECIMAL(10,2), quantidade INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
		DECLARE valor_venda DECIMAL(10,2);
		IF quantidade <= 10 THEN
			SET valor_venda = preço_compra * 2.25;
		ELSE 
			SET valor_venda = preço_compra * 1.75;
        END IF;
        RETURN valor_venda;
END ;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION calcula_saldo ( entradas DECIMAL, saidas DECIMAL, id_caixa INT)
RETURNS DECIMAL(9,2) DETERMINISTIC 
BEGIN
		DECLARE Retorno DECIMAL(9,2);
        DECLARE aux DECIMAL;
        Select saldo into aux from caixa where id_caixa = caixa.id;
        Set Retorno = (entradas + aux) - saidas ;
        RETURN Retorno;
END ;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION produto_mais_vendido_por_estação (estação_busca VARCHAR(100))
RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
	DECLARE resultado VARCHAR(200);
    DECLARE quantidade_vendida INT;
    
    SELECT MAX(peças_vendidas.quantidade) INTO quantidade_vendida FROM venda, peças_vendidas, produto
	WHERE venda.peças_vendidas_id = peças_vendidas.id AND venda.estação = estação_busca;
	
    SELECT produto.descrição INTO resultado FROM peças_vendidas, produto
    WHERE peças_vendidas.produto_id = produto.id AND peças_vendidas.quantidade = quantidade_vendida;
  
    RETURN resultado ;
END ;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION situação_estoque ( codigo_produto INT)
RETURNS VARCHAR(100) DETERMINISTIC 
BEGIN
		DECLARE Situação VARCHAR(100);
        DECLARE Quantidade_ INT;
        DECLARE Quantidade_vendida INT;
        DECLARE Quantidade_atual INT;
        
        select produto.quantidade INTO Quantidade_ FROM produto 
        Where produto.id = codigo_produto;
       
        select SUM(peças_vendidas.quantidade) INTO Quantidade_vendida FROM produto, peças_vendidas
        WHERE peças_vendidas.produto_id = produto.id AND produto.id = codigo_produto;
        
        SET Quantidade_atual = Quantidade_ - Quantidade_vendida;
        
        IF Quantidade_atual >= 10 THEN
			SET Situação = 'NÂO NECESSITA REPOSIÇÂO';
		ELSEIF Quantidade_atual <= 10 AND Quantidade_atual >=1 THEN
			SET Situação = 'PRECISA DE REPOSIÇÃO / URGENTE';
		ELSE 
			SET Situação = 'SEM ESTOQUE';
        END IF;
        
        RETURN Situação;
END ;
//
DELIMITER ;

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

select verificar_cpf('22222222222');
select id, descrição, situação_estoque(id) from produto;
select produto_mais_vendido_por_estação('INVERNO');
select calcula_saldo(500, 200, 1);
select valor_de_revenda(50, 10);
select vendas_realizadas_nessa_data('2022-06-20');
