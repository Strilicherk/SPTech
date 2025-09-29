CREATE DATABASE SPRINT2;

USE SPRINT2;

CREATE TABLE PESSOA (
	ID_PESSOA INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(45) NOT NULL,
    DT_NASC DATE NOT NULL,
    FK_PAI INT,
    FK_MAE INT,
    CONSTRAINT FK_FILHO_PAI FOREIGN KEY (FK_PAI) REFERENCES PESSOA(ID_PESSOA),
    CONSTRAINT FK_FILHO_MAE FOREIGN KEY (FK_MAE) REFERENCES PESSOA(ID_PESSOA)
);

INSERT INTO PESSOA(NOME, DT_NASC, FK_PAI, FK_MAE) VALUES 
	('Osvaldo Strilicherk', '1943-03-11', null, null), -- 1
	('Cleide Strilicherk', '1962-05-23', null, null), -- 2
	('Neuza Regina da Silva', '1961-02-05', null, null), -- 3
	('Roberto Regina da Silva', '1947-04-09', null, null), -- 4
	('Paulo César Strilicherk', '1970-08-11', 1, 2), -- 5
	('Carlos Eduardo Strilicherk', '1975-05-13', 1, 2), -- 6
	('Célia Regina da Silva', '1974-07-14', 4, 3), -- 7
	('Matheus Strilicherk', '2004-07-22', 5, 7), -- 8
	('Gabriel Strilicherk', '2004-09-04', 5, 7); -- 9

SELECT 
    FILHO.NOME AS 'Nome', 
    PAI.NOME AS 'Pai', 
    MAE.NOME AS 'Mãe', 
    AVOMM.NOME AS 'Avô Materno', 
    AVOFM.NOME AS 'Avó Materna',
    AVOMP.NOME AS 'Avô Paterno', 
    AVOFP.NOME AS 'Avó Paterna'
FROM
    PESSOA AS FILHO
        JOIN
    PESSOA AS PAI ON FILHO.FK_PAI = PAI.ID_PESSOA
        JOIN
    PESSOA AS MAE ON FILHO.FK_MAE = MAE.ID_PESSOA
		JOIN 
	PESSOA AS AVOMP ON PAI.FK_PAI = AVOMP.ID_PESSOA
		JOIN
	PESSOA AS AVOFP ON PAI.FK_MAE = AVOFP.ID_PESSOA
		JOIN
	PESSOA AS AVOMM ON MAE.FK_PAI = AVOMM.ID_PESSOA
		JOIN
	PESSOA AS AVOFM ON MAE.FK_MAE = AVOFM.ID_PESSOA
