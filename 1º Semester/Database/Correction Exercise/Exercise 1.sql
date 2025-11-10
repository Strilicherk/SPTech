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