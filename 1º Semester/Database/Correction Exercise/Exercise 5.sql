-- Criação das tabelas
CREATE TABLE jogadores (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    nickname VARCHAR(50),
    pais_origem VARCHAR(50)
);
CREATE TABLE torneios (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    premiacao DECIMAL(8,2),
    data_torneio DATE
);
CREATE TABLE inscricoes (
    jogador_id INT,
    torneio_id INT,
    data_inscricao DATE,
    status VARCHAR(20),
    -- Sintaxe de chave primária composta incorreta. Faltou 'KEY' e os parênteses.
    PRIMARY KEY (jogador_id, torneio_id),
    -- Erro de digitação, o correto é REFERENCES
    FOREIGN KEY (jogador_id) REFERENCES jogadores(id),
    FOREIGN KEY (torneio_id) REFERENCES torneios(id)
);

-- Inserção de dados
INSERT INTO jogadores (id, nome, nickname, pais_origem)
VALUES (1, 'Lucas Pereira', 'Lukao', 'Brasil'),
       (2, 'Emily Chan', 'ShadowQueen', 'China');
INSERT INTO torneios (id, nome, premiacao, data_torneio)
VALUES (1, 'Summer Cup', 5000.00, '2023-07-10'),
       (2, 'Winter Clash', 7500.00, '2023-12-15');
INSERT INTO inscricoes (jogador_id, torneio_id, data_inscricao, status)
VALUES (1, 1, '2023-06-01', 'confirmado'),
       (2, 2, '2023-11-20', NULL);

-- Atualização
UPDATE inscricoes
-- Correto é aspas simples
SET status = 'confirmado'
WHERE jogador_id = 2 AND torneio_id = 2;

-- Exclusão
-- Faltou o 'FROM' no comando DELETE
DELETE FROM inscricoes
WHERE status IS NULL;

-- Consulta com JOIN
SELECT j.nome, t.nome, i.status
FROM jogadores j
JOIN inscricoes i ON i.jogador_id = j.id
JOIN torneios t ON t.id = i.torneio_id;

-- LEFT JOIN
SELECT j.nome, t.nome
FROM jogadores j
LEFT JOIN inscricoes i ON j.id = i.jogador_id
LEFT JOIN torneios t ON i.torneio_id = t.id;

-- RIGHT JOIN
SELECT j.nome, t.nome
FROM jogadores j
RIGHT JOIN inscricoes i ON j.id = i.jogador_id
RIGHT JOIN torneios t ON i.torneio_id = t.id;

-- WHERE e ORDER BY
SELECT nickname, pais_origem
FROM jogadores
WHERE pais_origem = 'Brasil'
-- Faltou a palavra 'BY' no comando ORDER BY
ORDER BY pais_origem;

-- IFNULL e CONCAT
SELECT CONCAT(nome, ' (', nickname, ')') AS jogador,
       IFNULL(pais_origem, 'Não informado') AS pais
FROM jogadores;

-- CASE
SELECT j.nome, i.status,
    -- Faltou o 'WHEN' na sintaxe do CASE
    CASE
        WHEN i.status = 'confirmado' THEN 'Participante'
        WHEN i.status IS NULL THEN 'Aguardando'
        ELSE 'Outro'
    END AS situacao
FROM jogadores j
-- O JOIN com 'inscricoes' é necessário para acessar i.status
JOIN inscricoes i ON j.id = i.jogador_id;

-- ALTER TABLE
ALTER TABLE jogadores
ADD nacionalidade VARCHAR(50),
MODIFY nickname VARCHAR(100);