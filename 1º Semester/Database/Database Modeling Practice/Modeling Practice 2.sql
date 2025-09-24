USE SPRINT2;

/*------------------------------------------------------ Exercício 1.*/
CREATE TABLE ATLETA (
	ID_ATLETA INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(40) NOT NULL,
    MODALIDADE VARCHAR(40) NOT NULL,
    QTD_MEDALHA INT NOT NULL
);

CREATE TABLE PAIS (
	ID_PAIS INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(30) NOT NULL UNIQUE,
    CAPITAL VARCHAR(40) NOT NULL UNIQUE
);

INSERT INTO ATLETA (NOME, MODALIDADE, QTD_MEDALHA) VALUES
	('Michael Phelps', 'Natação', 28),
	('Usain Bolt', 'Atletismo', 8),
	('Simone Biles', 'Ginástica Artística', 7),
	('Rayssa Leal', 'Skate', 1),
	('Rebeca Andrade', 'Ginástica Artística', 3),
	('Serena Williams', 'Tênis', 4);

INSERT INTO PAIS (NOME, CAPITAL) VALUES
	('Brasil', 'Brasília'),
	('Estados Unidos', 'Washington, D.C.'),
	('Japão', 'Tóquio'),
	('França', 'Paris'),
	('Argentina', 'Buenos Aires'),
	('Jamaica', 'Kingston');

ALTER TABLE ATLETA ADD COLUMN ID_PAIS INT;
ALTER TABLE ATLETA ADD FOREIGN KEY (ID_PAIS) REFERENCES PAIS(ID_PAIS);

UPDATE ATLETA SET ID_PAIS = 2 WHERE ID_ATLETA IN (1,3,6);
UPDATE ATLETA SET ID_PAIS = 1 WHERE ID_ATLETA IN (4,5);
UPDATE ATLETA SET ID_PAIS = 6 WHERE ID_ATLETA IN (2);

SELECT * FROM ATLETA A JOIN PAIS P ON A.ID_PAIS = P.ID_PAIS;
SELECT A.NOME AS 'Atleta', P.NOME AS 'País' FROM ATLETA A JOIN PAIS P ON A.ID_PAIS = P.ID_PAIS;
SELECT 
    A.NOME AS 'Atleta',
    A.MODALIDADE AS 'Modalidade',
    A.QTD_MEDALHA AS 'Medalhas',
    P.NOME AS 'País',
    P.CAPITAL AS 'Capital'
FROM
    ATLETA A
        JOIN
    PAIS P ON A.ID_PAIS = P.ID_PAIS
WHERE
    CAPITAL = 'Brasília';
    
/*------------------------------------------------------ Exercício 2.*/
 USE SPRINT2;
 
 CREATE TABLE MUSICA (
	ID_MUSICA INT PRIMARY KEY AUTO_INCREMENT,
    TITULO VARCHAR(40) NOT NULL,
    ARTISTA VARCHAR(40) NOT NULL,
    GENERO VARCHAR(40) NOT NULL
);

 CREATE TABLE ALBUM (
	ID_ALBUM INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(40) NOT NULL,
    TIPO VARCHAR(7) CONSTRAINT TIPO_ALBUM CHECK(TIPO IN ('Físico', 'Digital')) NOT NULL,
    DT_LANCAMENTO DATE
);
 
 DROP TABLE ALBUM;
 INSERT INTO MUSICA (TITULO, ARTISTA, GENERO) VALUES
	('Cluster', 'Slipknot', 'Nu Metal'),
	('Billie Jean', 'Michael Jackson', 'Pop'),
	('Smells Like Teen Spirit', 'Nirvana', 'Grunge'),
	('Dead Memories', 'Slipknot', 'Nu Metal'),
	('War', 'System Of A Down', 'Nu Metal');

INSERT INTO ALBUM (NOME, TIPO, DT_LANCAMENTO) VALUES
	('Slipknot', 'Físico', '1999-06-29'),
	('Thriller', 'Físico', '1982-11-30'),
	('Nevermind', 'Físico', '1991-09-24'),
	('All Hope Is Gone', 'Físico', '2008-08-20'),
	('System of a Down', 'Físico', '1998-06-30');
 
SELECT * FROM MUSICA;
SELECT * FROM ALBUM;

ALTER TABLE MUSICA ADD COLUMN ID_ALBUM INT;
ALTER TABLE MUSICA ADD FOREIGN KEY (ID_ALBUM) REFERENCES ALBUM(ID_ALBUM);

UPDATE MUSICA SET ID_ALBUM = 1 WHERE ID_MUSICA = 1;
UPDATE MUSICA SET ID_ALBUM = 2 WHERE ID_MUSICA = 2;
UPDATE MUSICA SET ID_ALBUM = 3 WHERE ID_MUSICA = 3;
UPDATE MUSICA SET ID_ALBUM = 4 WHERE ID_MUSICA = 4;
UPDATE MUSICA SET ID_ALBUM = 5 WHERE ID_MUSICA = 5;

SELECT * FROM MUSICA JOIN ALBUM ON MUSICA.ID_ALBUM = ALBUM.ID_ALBUM;
SELECT M.TITULO AS 'Música', A.NOME AS 'Álbum' FROM MUSICA M JOIN ALBUM A ON M.ID_ALBUM = A.ID_ALBUM;
SELECT M.TITULO AS 'Música', M.ARTISTA 'Artista', M.GENERO AS 'Gênero', A.NOME AS 'Álbum' FROM MUSICA M JOIN ALBUM A ON M.ID_ALBUM = A.ID_ALBUM WHERE M.ARTISTA = 'Slipknot';

/*------------------------------------------------------ Exercício 3.*/
USE SPRINT2;

CREATE TABLE PESSOA (
  `idPessoa` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE RESERVA (
  `idReserva` INT PRIMARY KEY AUTO_INCREMENT,
  `fkPessoa` INT NOT NULL,
  `dtReserva` DATETIME NOT NULL,
  `dtRetirada` DATETIME NULL,
  `dtDevolucao` DATETIME NULL,
  FOREIGN KEY (fkPessoa) REFERENCES PESSOA(idPessoa)
);

INSERT INTO PESSOA (nome, cpf) VALUES
	('João Silva', '12345678901'),
	('Maria Oliveira', '98765432109'),
	('Pedro Santos', '11223344556'),
	('Ana Costa', '66554433221'),
	('Carlos Souza', '09876543210');

INSERT INTO RESERVA (fkPessoa, dtReserva, dtRetirada, dtDevolucao) VALUES
	(1, '2025-09-15 10:00:00', '2025-09-16 12:00:00', '2025-09-20 18:00:00'),
	(2, '2025-09-16 14:30:00', '2025-09-17 09:00:00', '2025-09-19 10:00:00'),
	(3, '2025-09-17 08:00:00', '2025-09-18 10:30:00', NULL),
	(4, '2025-09-17 19:45:00', '2025-09-19 14:00:00', '2025-09-22 11:00:00'),
	(5, '2025-09-18 11:00:00', '2025-09-19 16:00:00', '2025-09-21 16:00:00');

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

/*------------------------------------------------------ Exercício 4.*/
CREATE TABLE PESSOA1 (
  `idPessoa1` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `dtNascimento` DATE NOT NULL
);

CREATE TABLE PESSOA2 (
  `idPessoa2` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `dtNascimento` DATE NOT NULL,
  `fkPessoa1` INT,
  FOREIGN KEY (fkPessoa1) REFERENCES PESSOA1(idPessoa1)
);

INSERT INTO PESSOA1 (nome, dtNascimento) VALUES
	('Gabriel Ferreira', '1995-03-20'),
	('Juliana Castro', '1988-11-12'),
	('Rafael Gomes', '2001-07-05'),
	('Camila Lima', '1992-09-28'),
	('Fernando Ribeiro', '1976-02-14');

INSERT INTO PESSOA2 (nome, dtNascimento, fkPessoa1) VALUES
	('Isabela Souza', '2010-01-15', 1),
	('Lucas Martins', '2012-05-30', 2),
	('Mariana Oliveira', '2008-08-22', 3),
	('Guilherme Rocha', '2015-04-10', 4),
	('Beatriz Pires', '2007-06-03', NULL);

SELECT * FROM PESSOA1;
SELECT * FROM PESSOA2;

SELECT 
	P1.NOME AS 'Noivo', 
    P2.NOME AS 'Noiva'
FROM PESSOA1 P1 JOIN PESSOA2 P2
	ON idPessoa1 = fkPessoa1;
    
SELECT NOME AS 'Primogênito', IFNULL(fkPessoa1, 'Filho Único') AS 'Irmão' FROM PESSOA2;
    
SELECT NOME, CASE WHEN dtNascimento < '2010-01-01' THEN 'Velho' ELSE 'Novo' END AS 'Idade' FROM PESSOA2; 
    
/*------------------------------------------------------ Exercício 5.*/
CREATE TABLE CATEGORIA (
  `idCategoria` INT PRIMARY KEY AUTO_INCREMENT,
  `categoria` VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE CANDIDATO (
  `idCandidato` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `aprovado` TINYINT NOT NULL,
  `fkCategoria` INT,
  FOREIGN KEY (fkCategoria) REFERENCES CATEGORIA(idCategoria)
);

INSERT INTO CATEGORIA (categoria) VALUES
	('A'),
	('B'),
	('AB'),
	('ACC'),
	('ACC e B');

INSERT INTO CANDIDATO (nome, aprovado, fkCategoria) VALUES
	('João da Silva', 1, 1),
	('Maria Oliveira', 0, NULL),
	('Pedro Santos', 1, 3),
	('Ana Rodrigues', 0, NULL),
	('Carlos Lima', 1, 5);
    
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
        WHEN categoria = 'AB' THEN 'Carro e Moto'
        WHEN categoria = 'ACC' THEN 'Ciclomotor'
        ELSE 'Ciclomotor e Carro'
    END AS 'Veículo Permitido'
FROM
    CANDIDATO
        JOIN
    CATEGORIA ON fkCategoria = idCategoria;

/*------------------------------------------------------ Exercício 6.*/
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

/*------------------------------------------------------ Desafio.*/
    
  

