CREATE table estoque (
  id serial PRIMARY KEY,
  nome_produto varchar(50),
  quantidade INT,
  preco DECIMAL
  )
  
INSERT INTO estoque (nome_produto, quantidade, preco) VALUES
('TV', 10, 2700.00),
('Refrigerador', 10, 3800.00),
('Cooktop', 10, 599.00)

SELECT * FROM estoque;

--criando a procedure 
CREATE or REPLACE PROCEDURe novas_compras (quantidade_adquirida INT)
LANGUAGE PLPGSQL
as $$
BEGIN

	UPDATE estoque
    set quantidade = quantidade + quantidade_adquirida
    WHERE nome_produto = 'TV';

end $$;

CALL novas_compras(100);

SELECT * FROM estoque;

