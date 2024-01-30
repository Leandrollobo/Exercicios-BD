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
CREATE or REPLACE PROCEDURE novas_compras (quantidade_adquirida INT)
LANGUAGE PLPGSQL
as $$
BEGIN

	UPDATE estoque
    set quantidade = quantidade + quantidade_adquirida
    WHERE nome_produto = 'TV';

end $$;

CALL novas_compras(100);

SELECT * FROM estoque;




###############################
#                             #
#        CÓDIGO COMENTADO     #
#                             #
###############################

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
CREATE or REPLACE PROCEDURE novas_compras (quantidade_adquirida INT)
LANGUAGE PLPGSQL
as $$
BEGIN

	UPDATE estoque --Atualizaremos a tabela estoque
    set quantidade = quantidade + quantidade_adquirida  --na coluna quantidade, vamos pegar a quantidade existente no estoque e somar com a quantidade que acabou de chegar para o estoque da loja.
    WHERE nome_produto = 'TV'; --na linha onde o nome do produto for igual a 'TV'

end $$;

CALL novas_compras(100); --chamamos a procedure e passamos a nova quantidade adquirida para a loja para seu estoque no caso 100. esses 100 se somara ao estoque que a loja já tinha.

SELECT * FROM estoque; -- realizamos uma consulta da tabela estoque para ver a nova quantidade já inserida no estoque.
