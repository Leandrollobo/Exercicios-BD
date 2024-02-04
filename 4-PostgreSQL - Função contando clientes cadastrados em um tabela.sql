CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(20),
  	email VARCHAR(100) UNIQUE,
    idade INTEGER,    
    username VARCHAR(20) UNIQUE,
    senha VARCHAR(20),
    logradouro VARCHAR(100),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    cep VARCHAR(20),
    cidade VARCHAR(100),
    estado VARCHAR(50)
);

CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    nome_produto VARCHAR(20),
  	preco_produto DECIMAL,
    estoque_produto INTEGER
);

CREATE TABLE vendas_produto (
  id SERIAL PRIMARY KEY,
  fk_nome_produto INTEGER REFERENCES produto(ID),
  fk_nome INTEGER REFERENCES cliente(ID),
  quantidade_vendida INTEGER
 );
 
 INSERT INTO cliente (nome, email, idade, username, senha, logradouro, numero, complemento, cep, cidade, estado) 
VALUES 
('Anderson Silva', 'anderson@example.com', 30, 'anderson_silva', 'senha123', 'Rua das Flores', '123', 'Apto 101', '12345-678', 'São Paulo', 'SP'),
('João Oliveira', 'joao@example.com', 25, 'joao_oliveira', 'senha456', 'Av. Principal', '456', NULL, '54321-876', 'Rio de Janeiro', 'RJ'),
('Ana Souza', 'ana@example.com', 35, 'ana_souza', 'senha789', 'Rua da Praia', '789', 'Bloco B', '98765-432', 'Salvador', 'BA');


INSERT INTO produto (nome_produto, preco_produto, estoque_produto)
VALUES
('TV', 2499.00, 10),
('REF FF', 3599.00, 5);

INSERT INTO vendas_produto (fk_nome_produto, fk_nome, quantidade_vendida)
VALUES
(1, 3, 5),
(2, 1, 1);

SELECT * from cliente

SELECT * from produto

SELECT * from vendas_produto

--select com formatação de dados de coluna--
SELECT fk_nome_produto AS Produto, fk_nome AS nome_cliente, quantidade_vendida
from vendas_produto;


CREATE OR REPLACE FUNCTION contar_clientes()
RETURNS INTEGER AS $$
BEGIN
    DECLARE
        total_clientes INTEGER; --cria uma variavel
    BEGIN
        SELECT COUNT(id) INTO total_clientes FROM cliente; --conta os id's da tabela lista e guarda(INTO) total_pedidos
        RETURN total_clientes; --retorna a varivael
    END;
END;
$$ LANGUAGE PLPGSQL; 

SELECT contar_clientes() AS clientes_cadastrados;  -- aqui executamos a função e mudamos o nome da coluna para melhor visualização
