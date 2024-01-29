CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
  	pais VARCHAR(3)
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT,
    produto VARCHAR(100),
    quantidade INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);


INSERT into clientes (nome, email, pais) VALUES
('Sophia', 'sophia@.com', 'USA'),
('Paulo', 'paulo@.com', 'BRA'),
('Roberto', 'roberto@.com', 'MEX'),
('Frederico', 'frederico@.com', 'ITA')

SELECT * from clientes

insert INTO pedidos (cliente_id, produto, quantidade) VALUES
(1, 'Teclado', 200),
(1, 'Mouse', 200),
(2, 'Impressora', 10),
(4, 'Monitor', 3)

SELECT * FROM pedidos


SELECT clientes.nome, clientes.pais, pedidos.produto, pedidos.quantidade
FROM pedidos
INNER JOIN clientes
ON pedidos.cliente_id = clientes.id;