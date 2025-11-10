-- Primeiro erro é que não cria nenhum database, como que vai criar as tabelas sem banco de dados?
CREATE DATABASE PRATICAR;
USE PRATICAR;

-- Criação das tabelas
CREATE TABLE usuarios (
    id INT PRIMARY KEY, -- Correto é PRIMARY
    nome VARCHAR(100),
    email VARCHAR(100), -- Correto é VARCHAR
    data_nascimento DATE
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    id_usuario INT,
    data_pedido DATETIME,
    valor DECIMAL(10,2),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) -- Nome correto da coluna é id_usuario e não usuario_id
);

-- Inserção de dados
INSERT INTO usuarios (id, nome, email, data_nascimento)
VALUES (1, 'João Silva', 'joao@email.com', '1988-05-12'),
       (2, 'Maria Souza', 'maria@email', '1992-08-23');

INSERT INTO pedidos (id, id_usuario, data_pedido, valor)
VALUES (1, 1, '2023-03-10 14:30', 259.90),
       (2, 2, '2023-04-02 10:45', '399.50');

-- Atualização de dados
UPDATE usuarios SET email = 'joao.silva@email.com' WHERE id = 1; -- Falta aspas simples.

-- Remoção de pedidos com valor menor que 300
DELETE FROM pedidos WHERE valor < 300; -- Precisa do FROM para referenciar a tabela.


-- Consulta com JOIN
SELECT u.nome, p.data_pedido, p.valor
FROM usuarios u
JOIN pedidos p ON u.id = p.id;

-- Consulta com LEFT JOIN
SELECT u.nome, p.data_pedido
FROM usuarios u
LEFT JOIN pedidos p ON u.id = p.id_usuario; -- O correto é id_usuario

-- Consulta com RIGHT JOIN
SELECT u.nome, p.data_pedido
FROM usuarios u
RIGHT JOIN pedidos p ON p.id_usuario = u.id; -- id_usuario é da tabela pedidos e não usuário.

-- Alteração da tabela
ALTER TABLE usuarios MODIFY email VARCHAR(150), ADD COLUMN telefone VARCHAR(20); -- Para rodar duas alterações em um só comando precisa da vírgula.

-- EXERCICIO 2

-- Criação das tabelas
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    -- Erro de digitação, o correto é VARCHAR
    nome VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100)
);
CREATE TABLE vendas (
    id INT PRIMARY KEY,
    id_cliente INT,
    data_venda DATE,
    -- Erro de digitação, o correto é DECIMAL
    valor_total DECIMAL(10,2),
    -- Sintaxe incorreta da FK. Faltam os parênteses na coluna local (id_cliente)
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

-- Inserção de dados
INSERT INTO clientes (id, nome, telefone, email)
VALUES (1, 'Carlos Lima', '1199999999', 'carlos@email.com'),
       (2, 'Fernanda Dias', NULL, 'fernanda@email.com');
       
INSERT INTO vendas (id, id_cliente, data_venda, valor_total)
VALUES (1, 1, '2023-02-15', 150.00),
       (2, 2, '2023-03-01', NULL);

-- Consulta com WHERE e ORDER BY
SELECT c.nome, v.valor_total
FROM vendas v JOIN clientes c ON v.id_cliente = c.id
WHERE v.valor_total >= 100
-- Erro de digitação no ORDER BY, o correto é valor_total e faltou o 'BY'
ORDER BY v.valor_total DESC;

-- Uso de IFNULL
SELECT nome, IFNULL(telefone, 'Sem telefone') AS telefone_formatado
FROM clientes;

-- Uso de CONCAT
-- Usa (,) para concatenar.
SELECT CONCAT(nome, ' - ', email) AS contato
FROM clientes;

-- Uso de CASE
SELECT c.nome, v.valor_total,
    -- Faltou o WHEN
    CASE 
        WHEN v.valor_total > 200 THEN 'Alto'
        WHEN v.valor_total BETWEEN 100 AND 200 THEN 'Médio'
        ELSE 'Baixo'
    END AS categoria
FROM vendas v
JOIN clientes c ON c.id = v.id_cliente;

-- EXERCICIO 3 

-- Criação das tabelas
CREATE TABLE livros (
    -- Faltou a palavra 'KEY' após 'PRIMARY'
    id INT PRIMARY KEY,
    titulo VARCHAR(150),
    autor VARCHAR(100),
    ano_publicacao INT,
    disponivel BOOL
);
CREATE TABLE emprestimos (
    id INT PRIMARY KEY,
    livro_id INT,
    nome_leitor VARCHAR(100),
    data_emprestimo DATE,
    -- Faltou uma vírgula (,) antes da FOREIGN KEY
    data_devolucao DATE,
    -- O correto é 'FOREIGN KEY' (singular)
    FOREIGN KEY (livro_id) REFERENCES livros(id)
);

-- Inserção de dados
INSERT INTO livros (id, titulo, autor, ano_publicacao, disponivel)
VALUES (1, '1984', 'George Orwell', 1949, true),
       (2, 'Dom Casmurro', 'Machado de Assis', 1899, false);

INSERT INTO emprestimos (id, livro_id, nome_leitor, data_emprestimo, data_devolucao)
-- O livro id 3 não existe na tabela 'livros', alterei para 1.
VALUES (1, 2, 'Ana Paula', '2023-01-10', NULL),
       (2, 1, 'Carlos Alberto', '2023-02-05', '2023-02-20');

-- Consulta com WHERE e ORDER BY
SELECT titulo, ano_publicacao
FROM livros WHERE disponivel = 'TRUE'
-- Faltou o 'BY' no ORDER BY
ORDER BY ano_publicacao DESC;

-- Uso de IFNULL
SELECT nome_leitor, IFNULL(data_devolucao, 'Não devolvido') AS status_devolucao
FROM emprestimos;

-- Uso de CONCAT
-- CONCAT usa vírgula (,) e não o sinal de (+)
SELECT CONCAT(e.nome_leitor, ' - ', l.titulo) AS leitura
FROM emprestimos e
JOIN livros l ON e.livro_id = l.id;

-- Uso de CASE
SELECT titulo, disponivel,
    -- Faltou o 'WHEN'
    CASE 
        WHEN disponivel = true THEN 'Disponível'
        WHEN disponivel = false THEN 'Emprestado'
        ELSE 'Desconhecido'
    END AS status
FROM livros;

-- EXERCICIO 4

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

-- EXERCICIO 5

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


