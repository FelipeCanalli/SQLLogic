-- Aula 09 - Tratamento de Exceções
-- Database: db_faculdade

-- Criar procedure que:
-- Liste os códigos dos professores com título denominado 'Doutor' que não ministraram aulas em 2019/1.
-- Caso nao existam professores dar uma mensagem de erro usando um dos métodos para o tratamento de Exceções.

USE db_faculdade;

DELIMITER \\
CREATE PROCEDURE pr_listar_profs_doutorado_20191()
BEGIN
	DECLARE v_CodProf, v_AnoSem INT;
	DECLARE v_NomeTit VARCHAR (40);
	DECLARE done INT DEFAULT 0;     
	DECLARE C1 CURSOR FOR
    
-- SELECT
SELECT p.CodProf, t.NomeTit, pt.AnoSem from tb_professor p
INNER JOIN tb_titulacao t
ON p.CodTit = t.CodTit 
INNER JOIN tb_profturma pt
ON p.CodProf = pt.CodProf AND p.CodDepto = pt.CodDepto
WHERE pt.CodDepto <> "20191"
AND t.NomeTit = "Doutorado1" ;

-- CURSOR
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN C1;
read_loop: LOOP
        FETCH C1 INTO v_CodProf, v_NomeTit, v_AnoSem;
        IF v_CodProf IS NULL THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Nenhum professor encontrado com o nome especificado';
        END IF;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        SELECT v_CodProf, v_NomeTit, v_AnoSem;
    END LOOP;
END \\

CALL pr_listar_profs_doutorado_20191();
