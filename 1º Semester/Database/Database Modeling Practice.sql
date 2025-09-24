CREATE DATABASE ALUNOPROJETO;
USE ALUNOPROJETO;

CREATE TABLE PROJETO (
    ID_PROJETO INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(45) NOT NULL,
    DESCRICAO VARCHAR(200) NOT NULL
);

CREATE TABLE ALUNO (
    ID_ALUNO INT PRIMARY KEY AUTO_INCREMENT,
    FK_REPRESENTANTE INT,
    FK_PROJETO INT NOT NULL,
    NOME VARCHAR(100) NOT NULL,
    RA CHAR(8) NOT NULL UNIQUE,
    TELEFONE CHAR(11) NOT NULL UNIQUE,
    FOREIGN KEY (FK_REPRESENTANTE)
        REFERENCES ALUNO (ID_ALUNO),
    FOREIGN KEY (FK_PROJETO)
        REFERENCES PROJETO (ID_PROJETO)
);

-- Inserir dados nas tabelas.
INSERT INTO PROJETO VALUES 
	(DEFAULT, 'WHIS{KEY}', 'Controle de temperatura e umidade em destilarias de whisky.'),
	(DEFAULT, 'Stay Cold', 'Controle de temperatura em frigoríficos.'),
	(DEFAULT, 'Bee', 'Controle de temperatura em colmeias de abelha.'),
	(DEFAULT, 'Biblioteca', 'Sistema de biblioteca para a SPTech');
    
INSERT INTO ALUNO VALUES 
	(DEFAULT, NULL, 1, 'Gustavo Henrique', '01252330', '11987653342'),
	(DEFAULT, NULL, 2, 'Rafael Biaggi', '01252335', '11987653245'),
	(DEFAULT, NULL, 3, 'Wagne Moura', '01252213', '11989853342'),
	(DEFAULT, 2, 2, 'Matheus Strilicherk', '01252110', '11999653342'),
	(DEFAULT, 2, 2, 'Gabriel Adryan', '01252120', '11987333342'),
	(DEFAULT, 1, 1, 'Maria Okamoto', '01252333', '11987336501'),
	(DEFAULT, 1, 1, 'Gustavo Kenzo', '01252375', '11987349812');
    
-- Exibir todos os dados de cada tabela criada, separadamente.
SELECT * FROM ALUNO;
SELECT * FROM PROJETO;

-- Exibir os dados dos alunos e dos projetos correspondentes.
SELECT 
    A.NOME, R.NOME, P.NOME, P.DESCRICAO
FROM
    ALUNO A
        JOIN
    PROJETO P ON A.FK_PROJETO = P.ID_PROJETO
		JOIN
	ALUNO AS R ON A.FK_REPRESENTANTE = R.ID_ALUNO
ORDER BY P.NOME;

-- Exibir os dados dos alunos e dos seus representantes.
SELECT 
    A.NOME, R.NOME
FROM
    ALUNO A
        JOIN
    ALUNO AS R ON A.FK_REPRESENTANTE = R.ID_ALUNO;

-- Exibir os dados dos alunos e dos projetos correspondentes, mas somente de um determinado projeto (indicar o nome do projeto na consulta).
SELECT 
    ALUNO.NOME, PROJETO.NOME, DESCRICAO
FROM
    ALUNO
        LEFT JOIN
    PROJETO ON FK_PROJETO = ID_PROJETO
ORDER BY PROJETO.NOME;