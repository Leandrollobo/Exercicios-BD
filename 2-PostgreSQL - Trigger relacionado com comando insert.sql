CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    pais VARCHAR(3)
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    produto VARCHAR(100),
    quantidade INT,
    fk_client_id INT,
    CONSTRAINT fk_cliente FOREIGN KEY (fk_client_id) REFERENCES clientes(id)
);

INSERT INTO clientes (nome, email, pais) VALUES
('Sophia', 'sophia@.com', 'USA'),
('Paulo', 'paulo@.com', 'BRA'),
('Roberto', 'roberto@.com', 'MEX'),
('Frederico', 'frederico@.com', 'ITA');

INSERT INTO pedidos (fk_client_id, produto, quantidade) VALUES
(1, 'Teclado', 200),
(1, 'Mouse', 200),
(2, 'Impressora', 10),
(4, 'Monitor', 3);

CREATE TABLE contagem_pedidos (
    cliente_id INT PRIMARY KEY,
    total_pedidos INT DEFAULT 0
);

CREATE OR REPLACE FUNCTION atualizar_contagem_pedidos()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE contagem_pedidos
    SET total_pedidos = total_pedidos + 1
    WHERE cliente_id = NEW.fk_client_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_contagem_pedidos_trigger
AFTER INSERT ON pedidos
FOR EACH ROW
EXECUTE FUNCTION atualizar_contagem_pedidos();

SELECT * FROM contagem_pedidos;

insert INTO pedidos (fk_client_id, produto, quantidade) VALUES
(1, 'Modem USB', 200)

INSERT INTO contagem_pedidos (cliente_id) SELECT id FROM clientes;

insert INTO pedidos (fk_client_id, produto, quantidade) VALUES
(4, 'Modem USB', 50)

SELECT * from pedidos