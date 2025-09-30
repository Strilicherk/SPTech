CREATE DATABASE SPRINT2;
USE SPRINT2;

-- Exercício 1

CREATE TABLE PESSOA (
  `idPessoa` INT PRIMARY KEY NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE RESERVA (
  `idReserva` INT PRIMARY KEY NOT NULL,
  `fkPessoa` INT NOT NULL,
  `dtReserva` DATETIME NOT NULL,
  `dtRetirada` DATETIME NULL,
  `dtDevolucao` DATETIME NULL,
  FOREIGN KEY (fkPessoa) REFERENCES PESSOA(idPessoa)
);

INSERT INTO PESSOA (idPessoa, nome, cpf) VALUES
	(1, 'João Silva', '12345678901'),
	(2, 'Maria Oliveira', '98765432109'),
	(3, 'Pedro Santos', '11223344556'),
	(4, 'Ana Costa', '66554433221'),
	(5, 'Carlos Souza', '09876543210');

INSERT INTO RESERVA (idReserva, fkPessoa, dtReserva, dtRetirada, dtDevolucao) VALUES
	(101, 1, '2025-09-15 10:00:00', '2025-09-16 12:00:00', '2025-09-20 18:00:00'),
	(102, 2, '2025-09-16 14:30:00', '2025-09-17 09:00:00', '2025-09-19 10:00:00'),
	(103, 3, '2025-09-17 08:00:00', '2025-09-18 10:30:00', NULL),
	(104, 4, '2025-09-17 19:45:00', '2025-09-19 14:00:00', '2025-09-22 11:00:00'),
	(105, 5, '2025-09-18 11:00:00', '2025-09-19 16:00:00', '2025-09-21 16:00:00');

SELECT * FROM PESSOA;
SELECT * FROM RESERVA;

SELECT 
	idReserva AS 'Código da Reserva', 
    nome AS 'Cliente',
	IFNULL(dtDevolucao, 'Não Devolvido') AS 'Data Devolução'
FROM RESERVA R JOIN PESSOA P ON fkPessoa = idPessoa;

SELECT 
	idReserva AS 'Código da Reserva', 
    nome AS 'Cliente',
    dtRetirada AS 'Data de Retirada',
    CASE
		WHEN dtDevolucao IS NULL THEN 'Não Devolvido'
        ELSE 'Devolvido'
        END AS 'Data Devolução'
FROM RESERVA R JOIN PESSOA P ON fkPessoa = idPessoa;

-- Exercício 2
CREATE TABLE PESSOA1 (
  `idPessoa1` INT PRIMARY KEY NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dtNascimento` DATE NOT NULL
);
 
CREATE TABLE PESSOA2 (
  `idPessoa2` INT PRIMARY KEY NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dtNascimento` DATE NOT NULL,
  `fkPessoa1` INT,
  FOREIGN KEY (fkPessoa1) REFERENCES PESSOA1(idPessoa1)
);

INSERT INTO PESSOA1 (idPessoa1, nome, dtNascimento) VALUES
	(6, 'Gabriel Ferreira', '1995-03-20'),
	(7, 'Juliana Castro', '1988-11-12'),
	(8, 'Rafael Gomes', '2001-07-05'),
	(9, 'Camila Lima', '1992-09-28'),
	(10, 'Fernando Ribeiro', '1976-02-14');

INSERT INTO PESSOA2 (idPessoa2, nome, dtNascimento, fkPessoa1) VALUES
	(201, 'Isabela Souza', '2010-01-15', 6),
	(202, 'Lucas Martins', '2012-05-30', 7),
	(203, 'Mariana Oliveira', '2008-08-22', 8),
	(204, 'Guilherme Rocha', '2015-04-10', 9),
	(205, 'Beatriz Pires', '2007-06-03', NULL);
    
SELECT * FROM PESSOA1;
SELECT * FROM PESSOA2;

SELECT 
	P1.NOME AS 'Noivo', 
    P2.NOME AS 'Noiva'
FROM PESSOA1 P1 JOIN PESSOA2 P2
	ON idPessoa1 = fkPessoa1;
    
SELECT NOME AS 'Primogênito', IFNULL(fkPessoa1, 'Filho Único') AS 'Irmão' FROM PESSOA2;
    
SELECT NOME, CASE WHEN dtNascimento < '2010-01-01' THEN 'Velho' ELSE 'Novo' END AS 'Idade' FROM PESSOA2; 
    
-- Exercício 3
CREATE TABLE CATEGORIA (
  `idCategoria` INT PRIMARY KEY NOT NULL,
  `categoria` VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE CANDIDATO (
  `idCandidato` INT PRIMARY KEY NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `aprovado` TINYINT NOT NULL,
  `fkCategoria` INT,
  FOREIGN KEY (fkCategoria) REFERENCES CATEGORIA(idCategoria)
);

INSERT INTO CATEGORIA (idCategoria, categoria) VALUES
	(1, 'A'),
	(2, 'B'),
	(3, 'A e B');

INSERT INTO CANDIDATO (idCandidato, nome, aprovado, fkCategoria) VALUES
	(101, 'João da Silva', 1, 1),
	(102, 'Maria Oliveira', 0, NULL),
	(103, 'Pedro Santos', 1, 3),
	(104, 'Ana Rodrigues', 0, NULL),
	(105, 'Carlos Lima', 1, 2);
    
SELECT * FROM CATEGORIA;
SELECT * FROM CANDIDATO;

SELECT 
    nome AS 'Nome do Candidato',
    CASE
        WHEN aprovado = 1 THEN 'Aprovado'
        ELSE 'Reprovado'
    END AS 'Status',
    IFNULL(fkCategoria, 'Nenhuma') AS 'Categoria'
FROM
    CANDIDATO;
    
SELECT 
    nome AS 'Nome do Candidato',
    CASE
        WHEN aprovado = 1 THEN 'Aprovado'
        ELSE 'Reprovado'
    END AS 'Status',
    CASE
        WHEN categoria = 'A' THEN 'Moto'
        WHEN categoria = 'B' THEN 'Carro'
        ELSE 'Carro e moto'
    END AS 'Veículo Permitido'
FROM
    CANDIDATO
        JOIN
    CATEGORIA ON fkCategoria = idCategoria;

-- Exercício 4
CREATE TABLE FARMACIA (
  `idFarmacia` INT PRIMARY KEY NOT NULL,
  `nome` VARCHAR(45) NOT NULL
);

CREATE TABLE ENDERECO (
  `idEndereco` INT PRIMARY KEY NOT NULL,
  `fkFarmacia` INT NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  FOREIGN KEY (fkFarmacia) REFERENCES FARMACIA(idFarmacia)
);

CREATE TABLE FARMACEUTICO (
  `idFarmaceutico` INT PRIMARY KEY NOT NULL,
  `fkFarmacia` INT NULL,
  `nome` VARCHAR(45) NOT NULL,
  FOREIGN KEY (fkFarmacia) REFERENCES FARMACIA(idFarmacia)
);

INSERT INTO FARMACIA (idFarmacia, nome) VALUES
	(1, 'Farmácia Central'),
	(2, 'Drogaria do Povo'),
	(3, 'Farmácia da Saúde');

INSERT INTO ENDERECO (idEndereco, fkFarmacia, endereco) VALUES
	(101, 1, 'Rua das Flores, 123'),
	(102, 2, 'Avenida Principal, 456'),
	(103, 3, 'Praça da Matriz, 789');

INSERT INTO FARMACEUTICO (idFarmaceutico, fkFarmacia, nome) VALUES
	(201, 1, 'João da Silva'),
	(202, 2, 'Maria Oliveira'),
	(203, NULL, 'Pedro Santos'),
	(204, 1, 'Ana Rodrigues'),
	(205, 3, 'Carlos Ferreira');
    
SELECT * FROM FARMACIA;
SELECT * FROM ENDERECO;
SELECT * FROM FARMACEUTICO;

SELECT 
    FA.nome AS 'Farmácia', endereco AS 'Endereço', FO.nome AS 'Farmacêutico'
FROM
    FARMACIA FA
        JOIN
    ENDERECO ON FA.idFarmacia = fkFarmacia
        JOIN
    FARMACEUTICO FO ON idFarmacia = FO.fkFarmacia;

SELECT nome, IFNULL(fkFarmacia, 'Desempregado') AS 'Trabalho' FROM FARMACEUTICO;

SELECT nome, CASE WHEN fkFarmacia IS NULL THEN 'Desempregado' ELSE 'Empregado' END AS 'Trabalho' FROM FARMACEUTICO;


    
  
