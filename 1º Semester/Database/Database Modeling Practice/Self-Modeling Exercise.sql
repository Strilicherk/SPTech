CREATE DATABASE SPRINT2;
USE SPRINT2;

-- Exercício 1

CREATE TABLE AREA (
    ID_AREA INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(45) NOT NULL,
    DESCRICAO VARCHAR(200) NOT NULL
);

CREATE TABLE FUNCIONARIO (
    ID_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
    FK_SUPERVISOR INT,
    FK_AREA INT NOT NULL,
    NOME VARCHAR(45) NOT NULL,
    FOREIGN KEY (FK_SUPERVISOR)
        REFERENCES FUNCIONARIO (ID_FUNCIONARIO),
    FOREIGN KEY (FK_AREA)
        REFERENCES AREA (ID_AREA)
);

INSERT INTO AREA VALUES
	(DEFAULT, 'Marketing', 'Área de marketing da empresa'),
	(DEFAULT, 'Desenvolvimento', 'Área de desenvolvimento de software da empresa'),
	(DEFAULT, 'Financeiro', 'Área financeira da empresa');

INSERT INTO FUNCIONARIO VALUES 
	(DEFAULT, null, 2, 'Matheus Strilicherk'),
	(DEFAULT, 1, 2, 'Carlos Eduardo'),
	(DEFAULT, null, 3, 'Roberto Carvalho'),
	(DEFAULT, 3, 3, 'Diana Leona'),
	(DEFAULT, null, 1, 'Vayne Viktoria'),
	(DEFAULT, 5, 1, 'Giovana Eduarda'),
	(DEFAULT, 1, 2, 'Robson Bobson');
   
SELECT 
    F.NOME AS 'Funcionário',
    IFNULL(S.NOME,
            'Este funcionário não possui superiores.') AS 'Supervisor',
    A.NOME AS 'Área'
FROM
    FUNCIONARIO F
        LEFT JOIN
    FUNCIONARIO AS S ON F.FK_SUPERVISOR = S.ID_FUNCIONARIO
        JOIN
    AREA A ON F.FK_AREA = A.ID_AREA
ORDER BY S.NOME;
 
SELECT 
    F.NOME AS 'Funcionário',
    CASE
        WHEN S.NOME IS NULL THEN 'Este funcionário não possui superiores.'
        ELSE S.NOME
    END AS 'Supervisor',
    A.NOME AS 'Área'
FROM
    FUNCIONARIO F
        LEFT JOIN
    FUNCIONARIO AS S ON F.FK_SUPERVISOR = S.ID_FUNCIONARIO
        JOIN
    AREA A ON F.FK_AREA = A.ID_AREA
WHERE
    A.NOME = 'Desenvolvimento';

CREATE TABLE USUARIO (
  ID_USUARIO INT PRIMARY KEY AUTO_INCREMENT,
  FK_GERENTE INT,
  NOME VARCHAR(100) NOT NULL,
  FOREIGN KEY (FK_GERENTE) REFERENCES USUARIO(ID_USUARIO)
);

CREATE TABLE EMAIL (
  ID_EMAIL INT PRIMARY KEY AUTO_INCREMENT,
  FK_USUARIO INT,
  EMAIL VARCHAR(100) NOT NULL UNIQUE,
  FOREIGN KEY (FK_USUARIO) REFERENCES USUARIO(ID_USUARIO)
);

INSERT INTO USUARIO (ID_USUARIO, FK_GERENTE, NOME) VALUES 
	(1, NULL, 'Carlos Diretor'),
	(2, 1, 'Beatriz Gerente TI'),
	(3, 2, 'Daniel Coordenador'),
	(4, 3, 'Fernanda Analista'),
	(5, 3, 'Gabriel Desenvolvedor');
    
INSERT INTO EMAIL (FK_USUARIO, EMAIL) VALUES 
	(1, 'carlos.diretor@empresa.com'),
	(2, 'beatriz.gerente@empresa.com'),
	(4, 'fernanda.analista@empresa.com'),
	(5, 'gabriel.dev@empresa.com'),
	(5, 'gabriel.pessoal@email.com'),
	(3, 'daniel.coordenador@empresa.com'),
	(3, 'daniel.contato@email.com');
  
SELECT 
    U.NOME AS 'Usuário',
    E.EMAIL AS 'Email'
FROM
    USUARIO U
        LEFT JOIN
	EMAIL AS E ON E.FK_USUARIO = U.ID_USUARIO
WHERE U.NOME LIKE '%coordenador%';
 
SELECT 
    U.NOME AS Usuário,
    E.EMAIL AS Email,
    CASE
        WHEN G.NOME IS NULL THEN 'Não Possui Gerente Direto'
        ELSE G.NOME
    END AS Gerente,
    CASE
        WHEN U.FK_GERENTE IS NULL THEN 'Diretoria'
        ELSE 'Membro de Equipe'
    END AS 'Nível Hierarquico'
FROM
    USUARIO U
        LEFT JOIN
    USUARIO G ON U.FK_GERENTE = G.ID_USUARIO
        LEFT JOIN
    EMAIL E ON U.ID_USUARIO = E.FK_USUARIO
ORDER BY U.ID_USUARIO