-- Exercício

-- CREATE DATABASE exercicio;
-- USE exercicio;

CREATE TABLE Aluno (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Curso (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100),
    descricao TEXT
);

CREATE TABLE Aluno_Curso (
    id_aluno INT,
    id_curso INT,
    data_inscricao DATE,
    PRIMARY KEY (id_aluno, id_curso),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Acesso (
    id_aluno INT,
    id_curso INT,
    data_acesso DATETIME,
    duracao_minutos INT,
    PRIMARY KEY (id_aluno, id_curso, data_acesso),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

-- Alunos
INSERT INTO Aluno (nome, email) VALUES
('Ana Silva', 'ana@email.com'),
('Bruno Costa', 'bruno@email.com'),
('Carla Mendes', 'carla@email.com');

-- Cursos
INSERT INTO Curso (nome_curso, descricao) VALUES
('Banco de Dados', 'Curso de modelagem e SQL'),
('Lógica de Programação', 'Curso introdutório à lógica'),
('Desenvolvimento Web', 'Front-end e back-end');

-- Aluno_Curso
INSERT INTO Aluno_Curso (id_aluno, id_curso, data_inscricao) VALUES
(1, 1, '2024-01-15'),
(1, 2, '2024-01-20'),
(2, 1, '2024-02-01'),
(3, 3, '2024-03-01');

-- Acessos
INSERT INTO Acesso (id_aluno, id_curso, data_acesso, duracao_minutos) VALUES
(1, 1, '2024-05-01 10:00:00', 45),
(1, 1, '2024-05-02 11:00:00', 30),
(1, 2, '2024-05-03 12:00:00', 60),
(2, 1, '2024-05-01 09:00:00', 20),
(3, 3, '2024-05-04 14:00:00', 50);


-- 1. Listar todos os alunos e os cursos em que estão inscritos

SELECT 
    a.nome AS aluno,
    c.nome_curso AS curso
FROM 
    Aluno a
JOIN 
    Aluno_Curso ac ON a.id_aluno = ac.id_aluno
JOIN 
    Curso c ON ac.id_curso = c.id_curso;

-- 2. Exibir todos os acessos feitos pela aluna “Ana Silva”, com data e duração

SELECT 
    a.nome, 
    acs.data_acesso, 
    acs.duracao_minutos
FROM 
    Aluno a
JOIN 
    Acesso acs ON a.id_aluno = acs.id_aluno
WHERE 
    a.nome = 'Ana Silva';


-- 3. Listar os cursos que têm mais de 1 aluno inscrito

SELECT 
    c.nome_curso, 
    COUNT(ac.id_aluno) AS qtd_alunos
FROM 
    Curso c
JOIN 
    Aluno_Curso ac ON c.id_curso = ac.id_curso
GROUP BY 
    c.id_curso
HAVING 
    COUNT(ac.id_aluno) > 1;


-- 4. Exibir a duração média dos acessos em cada curso

SELECT 
    c.nome_curso, 
    AVG(a.duracao_minutos) AS media_duracao
FROM 
    Curso c
JOIN 
    Acesso a ON c.id_curso = a.id_curso
GROUP BY 
    c.id_curso;


-- 5. Mostrar o total de minutos acessados por cada aluno em cada curso

SELECT 
    al.nome AS aluno,
    c.nome_curso AS curso,
    SUM(a.duracao_minutos) AS total_minutos
FROM 
    Acesso a
JOIN 
    Aluno al ON a.id_aluno = al.id_aluno
JOIN 
    Curso c ON a.id_curso = c.id_curso
GROUP BY 
    al.id_aluno, c.id_curso;


-- 6. Criar uma VIEW chamada vw_total_acessos

CREATE VIEW vw_total_acessos AS
SELECT 
    al.id_aluno,
    al.nome AS aluno,
    c.id_curso,
    c.nome_curso,
    SUM(a.duracao_minutos) AS total_minutos
FROM 
    Acesso a
JOIN 
    Aluno al ON a.id_aluno = al.id_aluno
JOIN 
    Curso c ON a.id_curso = c.id_curso
GROUP BY 
    al.id_aluno, c.id_curso;


-- 7. Criar uma VIEW chamada vw_estatisticas_curso

CREATE VIEW vw_estatisticas_curso AS
SELECT 
    c.id_curso,
    c.nome_curso,
    COUNT(DISTINCT ac.id_aluno) AS total_alunos,
    AVG(a.duracao_minutos) AS media_acesso
FROM 
    Curso c
LEFT JOIN 
    Aluno_Curso ac ON c.id_curso = ac.id_curso
LEFT JOIN 
    Acesso a ON c.id_curso = a.id_curso
GROUP BY 
    c.id_curso;


-- 8. Exibir os 3 alunos com mais tempo total de acesso

SELECT 
    al.nome,
    SUM(a.duracao_minutos) AS total_minutos
FROM 
    Acesso a
JOIN 
    Aluno al ON a.id_aluno = al.id_aluno
GROUP BY 
    al.id_aluno
ORDER BY 
    total_minutos DESC
LIMIT 3;

-- 9. Listar os cursos que nunca foram acessados

SELECT 
    c.nome_curso
FROM 
    Curso c
LEFT JOIN 
    Acesso a ON c.id_curso = a.id_curso
WHERE 
    a.id_curso IS NULL;


-- 10. Mostrar a quantidade de acessos por data (agrupado por dia)

SELECT 
    DATE(data_acesso) AS data,
    COUNT(*) AS total_acessos
FROM 
    Acesso
GROUP BY 
    DATE(data_acesso)
ORDER BY 
    data;
