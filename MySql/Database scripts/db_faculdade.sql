CREATE DATABASE db_faculdade;
USE db_faculdade;

CREATE TABLE tb_depto(
	CodDepto CHAR(5),
    NomeDepto VARCHAR(40)
);

CREATE TABLE tb_disciplina(
	CodDepto CHAR(5),
    NumDisc INT4,
    NomeDisc VARCHAR(25),
    CreditoDisc INT4
);

CREATE TABLE tb_prereq(
	CodDeptoPreReq CHAR(5),
    NumDiscPreReq INT,
    CodDepto CHAR(5),
    NumDisc INT4
);

CREATE TABLE tb_turma (
    AnoSem INT4,
    CodDepto CHAR(5),
    NumDisc INT4,
    SiglaTur CHAR(2),
    CapacTur INT4
);

CREATE TABLE tb_horario (
    AnoSem INT4,
    CodDepto CHAR(5),
    NumDisc INT4,
    SiglaTur CHAR(2),
    DiaSem INT4,
    HoraInicio INT4,
    NumSala INT4,
    CodPred INT4,
    NumHoras INT4
);

CREATE TABLE tb_predio (
	CodPred 		INT4,
    NomePred 		VARCHAR(40)
);
 
CREATE TABLE tb_sala (
	CodPred 		INT4,
    NumSala			INT4,
    DescricaoSala	VARCHAR(40),
    CapacSala		INT4
);
 
CREATE TABLE tb_professor (
	CodProf			INT4,
    CodDepto		CHAR(5),
    CodTit			INT4,
    NomeProf		VARCHAR(40)
);

CREATE TABLE tb_profturma (
	AnoSem INT4,
    CodDepto CHAR(5),
    NumDisc INT4,
    SiglaTur CHAR(2),
    CodProf INT4
);

CREATE TABLE tb_titulacao(
	CodTit INT4,
    NomeTit VARCHAR(40)
);


-- Primary Keys e FK's

-- Tabela de departamento
ALTER TABLE tb_depto ADD
CONSTRAINT pk_CodDepto PRIMARY KEY (CodDepto);

-- Tabela disciplina
ALTER TABLE tb_disciplina ADD
CONSTRAINT pk_CodDepto_NumDisc PRIMARY KEY (CodDepto,NumDisc);

ALTER TABLE tb_disciplina ADD
CONSTRAINT fk_tb_disciplina_tb_depto FOREIGN KEY (CodDepto)
REFERENCES tb_depto (CodDepto);

-- Tabela prereq
ALTER TABLE tb_prereq ADD
CONSTRAINT fk_tb_prereq_tb_disciplina FOREIGN KEY (CodDeptoPreReq, NumDiscPreReq)
REFERENCES tb_disciplina (CodDepto, NumDisc);

ALTER TABLE tb_prereq ADD
CONSTRAINT fk_tb_prereq_tb_disciplina2 FOREIGN KEY (CodDepto, NumDisc)
REFERENCES tb_disciplina (CodDepto, NumDisc);

-- Tabela turma 
ALTER TABLE tb_turma ADD
CONSTRAINT pk_AnoSem_SiglaTur PRIMARY KEY (AnoSem,CodDepto,NumDisc,SiglaTur);

ALTER TABLE tb_turma ADD
CONSTRAINT fk_tb_turma_tb_disciplina FOREIGN KEY (CodDepto, NumDisc)
REFERENCES tb_disciplina (CodDepto,NumDisc);

-- Tabela horario
ALTER TABLE tb_horario ADD
CONSTRAINT pk_AnoSem_CodDepto_NumDisc_SiglaTur_DiaSem_HoraInicio
PRIMARY KEY (AnoSem,CodDepto,NumDisc,SiglaTur,DiaSem,HoraInicio);

ALTER TABLE tb_horario ADD
CONSTRAINT fk_tb_horario_tb_turma FOREIGN KEY (AnoSem,CodDepto,NumDisc,SiglaTur)
REFERENCES tb_turma (AnoSem,CodDepto,NumDisc,SiglaTur);

-- Tabela predio
ALTER TABLE tb_predio ADD
CONSTRAINT pk_CodPred
PRIMARY KEY (CodPred);

-- Tabela sala
ALTER TABLE tb_sala ADD
CONSTRAINT pk_CodPred_NumSala
PRIMARY KEY (CodPred,NumSala);

ALTER TABLE tb_sala ADD
CONSTRAINT fk_tb_sala_tb_predio FOREIGN KEY (CodPred)
REFERENCES tb_predio (CodPred);

-- Tabela horario 
ALTER TABLE tb_horario ADD
CONSTRAINT fk_tb_horario_tb_sala FOREIGN KEY (CodPred,NumSala)
REFERENCES tb_sala (CodPred,NumSala);

-- Tabela titulacao 
ALTER TABLE tb_titulacao ADD
CONSTRAINT pk_CodTit
PRIMARY KEY (CodTit);

-- Tabela professor 
ALTER TABLE tb_professor ADD
CONSTRAINT pk_CodProf
PRIMARY KEY (CodProf);

ALTER TABLE tb_professor ADD
CONSTRAINT fk_tb_professor_tb_titulacao FOREIGN KEY (CodTit)
REFERENCES tb_titulacao (CodTit);

ALTER TABLE tb_professor ADD
CONSTRAINT fk_tb_professor_tb_depto FOREIGN KEY (CodDepto)
REFERENCES tb_depto (CodDepto);

-- Tabela ProfTurma
ALTER TABLE tb_profturma ADD
CONSTRAINT pk_AnoSem_CodDepto_NumDisc_SiglaTur_CodProf 
PRIMARY KEY (AnoSem,CodDepto,NumDisc,SiglaTur,CodProf);

ALTER TABLE tb_profturma ADD
CONSTRAINT fk_tb_profturma_tb_turma FOREIGN KEY (AnoSem,CodDepto,NumDisc,SiglaTur)
REFERENCES tb_turma (AnoSem,CodDepto,NumDisc,SiglaTur);

ALTER TABLE tb_profturma ADD
CONSTRAINT fk_tb_profturma_tb_professor FOREIGN KEY (CodProf)
REFERENCES tb_professor (CodProf);


-- Inserção de dados na tabela tb_titulacao
INSERT INTO tb_titulacao (CodTit, NomeTit) VALUES
    (1, 'Graduação'),
    (2, 'Mestrado'),
    (3, 'Doutorado'),
    (4, 'Pós-Doutorado'),
    (5, 'Livro');

-- Inserção de dados na tabela tb_depto
INSERT INTO tb_depto(CodDepto, NomeDepto) VALUES 
    ('PROG', 'Programação'),
    ('MAT', 'Exatas'),
    ('ELE', 'Eletivas'),
	('BD', 'Banco de Dados'),
    ('ING', 'Ingles'),
	('CIE', 'Ciencia'),
    ('INF', 'Informatica');

-- Inserção de dados na tabela tb_predio
INSERT INTO tb_predio (CodPred, NomePred) VALUES
    (1234, 'Programacao'),
    (1235, 'Humanas'),
    (1236, 'Laboratório');

-- Inserção de dados na tabela tb_professor
INSERT INTO tb_professor (CodProf, CodDepto, CodTit, NomeProf) VALUES
    (1, 'PROG', 1, 'Antonio'),
    (2, 'PROG', 2, 'Marisa'),
    (3, 'MAT', 3, 'Mariana'),
    (4, 'MAT', 4, 'Marcelo'),
    (5, 'CIE', 1, 'Joilson'),
    (6, 'CIE', 2, 'Vendramel'),
    (7, 'INF', 3, 'Yuri'),
    (8, 'INF', 4, 'Felipe');

-- Inserção de dados na tabela tb_sala
INSERT INTO tb_sala (CodPred, NumSala, DescricaoSala, CapacSala) VALUES
    (1234, 101, 'Sala Pratica', 20),
    (1235, 102, 'Sala Teorica', 30),
    (1236, 211, 'Laboratorio', 20);

-- Inserção de dados na tabela tb_disciplina
INSERT INTO tb_disciplina (CodDepto, NumDisc, NomeDisc, CreditoDisc) VALUES
    ('PROG', 1, 'Banco de Dado', 5),
    ('PROG', 2, 'Orientacao a objetos', 5),
    ('PROG', 3, 'Redes', 7),
    ('MAT', 4, 'Matematica Discreta', 5),
    ('MAT', 5, 'Calculo', 6),
    ('CIE', 5, 'Biologia I', 5),
    ('CIE', 6, 'Anatomia I', 5),
    ('INF', 7, 'NoSQL', 7),
    ('INF', 8, 'Teste de Soft.', 5);

-- Inserção de dados na tabela tb_prereq
INSERT INTO tb_prereq (CodDeptoPreReq, NumDiscPreReq, CodDepto, NumDisc) VALUES
    ('PROG', 1, 'PROG', 2),
    ('MAT', 4, 'MAT', 5),
    ('PROG', 2, 'PROG', 3),
    ('PROG', 1, 'PROG', 3);
 
 
-- Inserção de dados na tabela tb_turma
INSERT INTO tb_turma(AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES 
    (20211, 'PROG', 1, 'T1', 20),
    (20212, 'PROG', 1, 'T1', 10),
    (20221, 'PROG', 2, 'T2', 20),
    (20222, 'PROG', 3, 'T1', 20),
    (20231, 'PROG', 3, 'T2', 10), 
    (20232, 'MAT', 5, 'T1', 15),
    (20241, 'CIE', 5, 'T1', 20),
    (20241, 'CIE', 6, 'T1', 10),
    (20241, 'CIE', 5, 'T3', 20),
    (20241, 'CIE', 6, 'T3', 10),
    (20241, 'INF', 7, 'T2', 20),
    (20241, 'INF', 8, 'T1', 20);

-- Inserção de dados na tabela tb_profturma
INSERT INTO tb_profturma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES
    (20211, 'PROG', 1, 'T1', 1),
    (20212, 'PROG', 1, 'T1', 1),
    (20221, 'PROG', 2, 'T2', 1),
    (20222, 'PROG', 3, 'T1', 2),
    (20231, 'PROG', 3, 'T2', 2),
    (20241, 'CIE', 5, 'T1', 5),
    (20241, 'CIE', 5, 'T1', 6),
    (20241, 'CIE', 5, 'T3', 5),
    (20241, 'CIE', 5, 'T3', 6),
    (20241, 'INF', 7, 'T2', 7),
    (20241, 'INF', 8, 'T1', 8); 
 
-- Inserção de dados na tabela tb_horario
INSERT INTO tb_horario (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio, NumSala, CodPred, NumHoras) VALUES
    (20211, 'PROG', 1, 'T1', 2, 1920, 101, 1234, 60),
    (20212, 'PROG', 1, 'T1', 2, 1920, 101, 1234, 60),
    (20221, 'PROG', 2, 'T2', 3, 1920, 101, 1234, 60),
    (20222, 'PROG', 3, 'T1', 4, 1920, 102, 1235, 60),
    (20231, 'PROG', 3, 'T2', 4, 0730, 211, 1236, 60),
    (20232, 'MAT', 5, 'T1', 4, 0730, 211, 1236, 60);