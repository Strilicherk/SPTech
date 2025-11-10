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