-- Criação das tabelas
CREATE TABLE alunos (
    -- Erro de digitação, o correto é PRIMARY
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    peso FLOAT,
    altura FLOAT,
    telefone VARCHAR(15)
);

CREATE TABLE treinos (
    id INT PRIMARY KEY,
    aluno_id INT,
    tipo VARCHAR(50),
    duracao INT, -- em minutos
    data DATE,
    -- Faltam os parênteses na coluna local (aluno_id) da FOREIGN KEY
    FOREIGN KEY (aluno_id) REFERENCES alunos(id)
);

-- Inserção de dados
INSERT INTO alunos (id, nome, data_nascimento, peso, altura, telefone)
VALUES (1, 'Lucas Nogueira', '1995-09-12', 78.5, 1.75, '11988776655'),
       (2, 'Patrícia Alves', '1988-03-22', 65.3, NULL, '11999887766');

INSERT INTO treinos (id, aluno_id, tipo, duracao, data)
VALUES (1, 1, 'Cardio', 45, '2023-05-10'),
       (2, 2, 'Musculação', '60', '2023-05-12');

-- Consulta com WHERE e ORDER BY
SELECT nome, peso, altura
FROM alunos
WHERE peso > 70 AND altura IS NOT NULL
-- Faltou a palavra 'BY' no comando ORDER BY
ORDER BY altura DESC;

-- IFNULL para altura
SELECT nome, IFNULL(altura, 0.0) AS altura
FROM alunos;

-- CONCAT para mensagem personalizada
SELECT CONCAT('Aluno: ', nome, ' - Telefone: ', IFNULL(telefone, 'N/A')) AS contato
FROM alunos;

-- CASE para avaliação do treino
-- A coluna 'nome' não existe na tabela 'treinos', é preciso fazer JOIN com 'alunos'
SELECT a.nome, t.tipo, t.duracao,
    -- Faltou o 'WHEN' na sintaxe do CASE
    CASE
        WHEN t.duracao < 30 THEN 'Curto'
        WHEN t.duracao BETWEEN 30 AND 60 THEN 'Moderado'
        ELSE 'Longo'
    END AS intensidade
FROM treinos t
JOIN alunos a ON t.aluno_id = a.id;