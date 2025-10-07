CREATE DATABASE TENIS;
USE TENIS;

CREATE TABLE Campeonato (
	id_campeonato INT PRIMARY KEY AUTO_INCREMENT,
	nome_campeonato VARCHAR(45) NOT NULL,
	ano YEAR NOT NULL,
	data_inicio DATE NOT NULL,
	data_termino DATE NOT NULL
);

CREATE TABLE Jogador (
	id_jogador INT PRIMARY KEY AUTO_INCREMENT,
	nome_jogador VARCHAR(45) NOT NULL,
	pais_origem VARCHAR(45) NOT NULL,
	data_nascimento DATE NOT NULL,
	ranking_atual INT NOT NULL
);

CREATE TABLE Partida (
	id_partida INT PRIMARY KEY AUTO_INCREMENT,
    fk_campeonato INT,
    fk_jogador1 INT,
	fk_jogador2 INT,
	data_partida VARCHAR(45) NOT NULL,
	hora_partida VARCHAR(45) NOT NULL,
	numero_quadra VARCHAR(45) NOT NULL,
	fase_campeonato VARCHAR(45) NOT NULL,
	CONSTRAINT FK_PARTIDA_JOGADOR1
		FOREIGN KEY (fk_jogador1) REFERENCES Jogador(id_jogador),
	CONSTRAINT FK_PARTIDA_JOGADOR2
		FOREIGN KEY (fk_jogador2) REFERENCES Jogador(id_jogador),
	CONSTRAINT FK_PARTIDA_CAMPEONATO
		FOREIGN KEY (fk_campeonato) REFERENCES Campeonato(id_campeonato)
);

CREATE TABLE Placar (
	id_placar INT AUTO_INCREMENT,
	fk_partida INT,
	placar_jogador1 INT,
	placar_jogador2 INT,
	CONSTRAINT PK_COMPOSTA
		PRIMARY KEY (id_placar, fk_partida)
);

INSERT INTO Campeonato (nome_campeonato, ano, data_inicio, data_termino) VALUES
	('SPTech Worlds', 2025, '2025-01-16', '2025-01-29'),
	('Pimba na Gorduchinha', 2024, '2024-05-28', '2024-06-11');

INSERT INTO Jogador (nome_jogador, pais_origem, data_nascimento, ranking_atual) VALUES
	('Vivian', 'Sérvia', '1987-05-22', 1),
	('Thiago', 'Espanha', '1985-05-05', 2),
	('Frizza', 'Rússia', '1940-02-11', 3),
	('Julia', 'Itália', '2000-08-16', 4),
	('João Pedro', 'Rússia', '1995-10-20', 5),
	('Davi', 'Dinamarca', '2003-04-29', 6),
	('Luan', 'Grécia', '2004-08-12', 7);

INSERT INTO Partida (fk_campeonato, fk_jogador1, fk_jogador2, data_partida, hora_partida, numero_quadra, fase_campeonato) VALUES
	(1, 1, 7, '2025-01-16', '19:30', 'Quadra 1', 'Oitavas de Final'),
	(1, 6, 1, '2025-01-19', '11:00', 'Quadra 2', 'Quartas de Final'),
	(1, 1, 4, '2025-01-22', '15:00', 'Quadra 2', 'Semi Final'),
	(1, 5, 1, '2025-01-29', '14:00', 'Quadra 3', 'Final'),
    
    (1, 1, 7, '2025-01-16', '19:30', 'Quadra 1', 'Oitavas de Final'),
	(1, 6, 1, '2025-01-19', '11:00', 'Quadra 2', 'Quartas de Final'),
	(1, 1, 4, '2025-01-22', '15:00', 'Quadra 2', 'Semi Final'),
	(1, 5, 1, '2025-01-29', '14:00', 'Quadra 3', 'Final');

INSERT INTO Placar (fk_partida, placar_jogador1, placar_jogador2) VALUES
	(1, 3, 0),
	(2, 3, 1),
	(3, 3, 2),
	(4, 0, 3),
	(5, 1, 2),
	(6, 0, 2),
	(7, 2, 1),
	(8, 2, 1),
	(9, 3, 0),
	(10, 2, 3),
	(11, 3, 1),
	(12, 0, 2);