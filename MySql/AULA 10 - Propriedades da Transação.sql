-- Aula 10 - Propriedades da Transação

-- Criar um script descrevendo os passos para simular uma possível situação de DeadLock,
-- com os respectivos comandos das DISTINTAS sessões (1 e 2).

-- ACID: atomicidade, consistência, isolamento e durabilidade

CREATE DATABASE aula10;
USE aula10;

SET AUTOCOMMIT = OFF;

CREATE TABLE tb_saldo(
	id_saldo INT,
    saldo DOUBLE,
    cpf_cliente VARCHAR(11)
);

CREATE TABLE tb_cliente (
	cpf_cliente VARCHAR(11),
    nome VARCHAR (10000)
);

-- Tabela tb_saldo
ALTER TABLE tb_saldo ADD
CONSTRAINT pk_id_saldo
PRIMARY KEY (id_saldo);

-- Tabela tb_cliente
ALTER TABLE tb_cliente ADD
CONSTRAINT pk_cpf_cliente
PRIMARY KEY (cpf_cliente);

ALTER TABLE tb_saldo ADD
CONSTRAINT fk_tb_saldo_tb_cliente FOREIGN KEY (cpf_cliente)
REFERENCES tb_cliente (cpf_cliente);

INSERT INTO tb_cliente (cpf_cliente, nome) VALUES
('12345678901', 'João Silva'),
('98765432109', 'Maria Santos'),
('11122233344', 'José Oliveira'),
('55566677788', 'Ana Costa'),
('99988877766', 'Carlos Souza');

-- Inserções na tabela tb_saldo
INSERT INTO tb_saldo (id_saldo, saldo, cpf_cliente) VALUES
(1, 1500.00, '12345678901'),
(2, 2500.50, '98765432109'),
(3, 300.25, '11122233344'),
(4, 800.00, '55566677788'),
(5, 1200.75, '99988877766');

START TRANSACTION;
UPDATE tb_saldo
SET saldo = 5000.00 
WHERE cpf_cliente = "55566677788";

UPDATE tb_cliente
SET nome = "Yuri Augusto"
WHERE cpf_cliente = "99988877766";

COMMIT;


-- Este script abaixo deve ser executado em uma nova sessão do Workbench para simular o deadlock e testar o isolamento 

SET AUTOCOMMIT = OFF;

START TRANSACTION;
UPDATE tb_saldo
SET saldo = 5000.00 
WHERE cpf_cliente = "55566677788";
 
UPDATE tb_cliente
SET nome = "Yuri Augusto"
WHERE cpf_cliente = "99988877766";
 
COMMIT;