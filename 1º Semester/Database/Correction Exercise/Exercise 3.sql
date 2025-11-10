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