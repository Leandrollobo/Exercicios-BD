CREATE TABLE usuario (
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

CREATE TABLE lista (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  	fk_usuario_id INT,
    CONSTRAINT fk_usuario_id FOREIGN KEY (fk_usuario_id) REFERENCES usuario(id)
);

CREATE TABLE categoria_de_itens (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(250)
);

CREATE TABLE item_de_lista (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    quantidade INTEGER,
  	fk_categoria_id INT,
  	fk_lista_id INT,
    CONSTRAINT fk_categoria_id FOREIGN key (fk_categoria_id) REFERENCES categoria_de_itens(id),
  	CONSTRAINT fk_lista_id FOREIGN KEY (fk_lista_id) REFERENCES lista(ID)
);

create table avaliacao (
  id SERIAL PRIMARY KEY,
  nota INT,
  descricao_avaliacao VARCHAR(250),
  fk_usuario_id INT,
  CONSTRAINT fk_usuario_id FOREIGN KEY (fk_usuario_id) REFERENCES usuario(id)
);
 
INSERT INTO usuario (nome, email, idade, username, senha, logradouro, numero, complemento, cep, cidade, estado) 
VALUES 
('Anderson Silva', 'anderson@example.com', 30, 'anderson_silva', 'senha123', 'Rua das Flores', '123', 'Apto 101', '12345-678', 'São Paulo', 'SP'),
('João Oliveira', 'joao@example.com', 25, 'joao_oliveira', 'senha456', 'Av. Principal', '456', NULL, '54321-876', 'Rio de Janeiro', 'RJ'),
('Ana Souza', 'ana@example.com', 35, 'ana_souza', 'senha789', 'Rua da Praia', '789', 'Bloco B', '98765-432', 'Salvador', 'BA');

INSERT INTO lista (nome, fk_usuario_id) 
VALUES 
('Minha lista', 1),
('Lista de Compras 1', 2),
('Minha lista do mercado', 3);

INSERT INTO categoria_de_itens (nome, descricao) 
VALUES
('supermarket', 'Disponibiliza itens como: alimentos, higiene e limpeza de modo geral'),
('pharmacy', 'Disponibiliza medicamentos e itens para cuidados pessoais'),
('shopping_mall','Shopping center, locais com alta quantidade de bens e serviços');

--popular a (tabela item_de_lista) lista 3(que pertence a Ana Souza), com itens da categoria 1-Supermarket
INSERT into item_de_lista (nome, quantidade, fk_lista_id, fk_categoria_id)
VALUES
	('Arroz', 1, 3, 1),
    ('Feijão', 2, 3, 1),
    ('MacarrãoNinho', 2, 3, 1),
    ('Carne', 1, 3, 1),
    ('Leite', 12, 3, 1),
    ('Ovos', 1, 3, 1),
    ('Pão de forma', 2, 3, 1),
    ('Açúcar', 2, 3, 1),
    ('Café', 1, 3, 1),
    ('Óleo', 2, 3, 1);

--popular a (tabela item_de_lista) lista 2(que pertence ao João Oliveira), com itens da categoria 1-Supermarket
INSERT INTO item_de_lista (nome, quantidade, fk_lista_id, fk_categoria_id)
VALUES 
    ('Maçãs', 6, 2, 1),
    ('Cenouras', 1, 2, 1),
    ('Papel Higiênico', 1, 2, 1),
    ('Sabonete', 2, 2, 1),
    ('Detergente', 1, 2, 1),
    ('Biscoitos', 3, 2, 1),
    ('Refrigerante', 2, 2, 1),
    ('Frango', 1, 2, 1),
    ('Chocolate', 2, 2, 1),
    ('Salsicha', 6, 2, 1);
    
--popular a (tabela item_de_lista) lista 1(que pertence ao Anderson Silva), com itens da categoria 2-pharmacy
INSERT INTO item_de_lista (nome, quantidade, fk_lista_id, fk_categoria_id)
VALUES 
    ('Dorflex', 1, 1, 2),
    ('Soro', 2, 1, 2),
    ('Álcool em gel', 1, 1, 2);
    
INSERT INTO avaliacao (nota, descricao_avaliacao, fk_usuario_id)
VALUES 
    (5, 'Excelente, me avisou quando precisei', 1),
    (4, 'Esta funcionando', 2);
    
------------------------
----Consultas ao BD-----
------------------------

--consulta a tabela usuario
SELECT * from usuario 

--consulta a tabela categoria
SELECT * from categoria_de_itens

--consulta a tabela lista
SELECT * from lista

--consulta a tabela item_de_lista
SELECT * from item_de_lista

--consulta a tabela avaliacao
SELECT * from avaliacao

--Aqui podemos realizar uma consulta da tabela listas que guarda
--o id da lista, o nome da lista do usuario e a data de criação da lista
--realizamos um junção a direita para que pudessemos ver qual o nome do usuario que criou esta lista.
SELECT lista.id, lista.nome, lista.data_criacao, usuario.nome
FROM lista
RIGHT JOIN usuario 
ON lista.fk_usuario_id = usuario.id;


--Aqui podemos realizar uma consulta da tabela item_de_lista(onde os itens estão cadastrados ex:o arroz, o feijão etc.)
--que guarda nome do item que o usuario cadastrou na lista dele, a quantidade de itens que ele quer comprar desse item,
--e após selecionar estes dados colocaremos a direita dele(Right Join) o id do usuario que cadastrou esse item na lista e
--em seguida colocaremos a esquerda destes dados (left join) o nome do usuario pois sem essas seleções previas não poderiamos
--acessar diretamente o nome do usuario que criou a lista e assim conseguimos saber qual o nome do usuario que cadastrou o produto
--e a quantidade desse produto na lista dele e tambem o estado em que esse usuario mora.
SELECT item_de_lista.nome, item_de_lista.quantidade, lista.fk_usuario_id AS identificao_do_usuario, usuario.nome, usuario.estado 
FROM item_de_lista
RIGHT JOIN lista
on item_de_lista.fk_lista_id = lista.id
left JOIN usuario
on lista.fk_usuario_id = usuario.id;

--------------------------Query apresenta resultado incorreto------------------------------------------
--Aqui temos mais uma consulta com junção de tabelas onde:
--Selecionamos o nome do usuario, o nome da lista de compras do usuario e apenas se a lista do usuario
--tiver cadastrado Arroz.
---------------SELECT usuario.nome, lista.nome, item_de_lista.nome
---------------from usuario
---------------right JOIN lista
---------------on lista.id = usuario.id
---------------LEFT JOIN item_de_lista
---------------on item_de_lista.id = lista.id
---------------WHERE item_de_lista.nome = 'Arroz'
-------------------------------------------------------------------------------------------------------

--Aqui temos uma consulta com junção de tabelas onde:
--Selecionamos o nome do usuario, o nome da lista de compras do usuario e apenas se a lista do usuario
--usuario tiver cadastrado o item Arroz.
SELECT usuario.nome AS nome_do_usuario, lista.nome AS nome_da_lista_do_usuario, item_de_lista.nome AS nome_do_item_na_lista
FROM item_de_lista
JOIN lista
ON item_de_lista.fk_lista_id = lista.id
JOIN usuario ON lista.fk_usuario_id = usuario.id
WHERE item_de_lista.nome = 'Arroz';

------------------------------
--Consulta ao BD  com função--
------------------------------

--Aqui criamos uma função que conta quantas listas temos armazenadas
CREATE OR REPLACE FUNCTION contar_listas()
RETURNS INTEGER AS $$
BEGIN
    DECLARE
        total_listas INTEGER; --cria uma variavel
    BEGIN
        SELECT COUNT(id) INTO total_listas FROM lista; --conta os id's da tabela lista e guarda(INTO) total_pedidos
        RETURN total_listas; --retorna a varivael
    END;
END;
$$ LANGUAGE PLPGSQL; 

--executamos a função
SELECT contar_listas() AS listas_cadastradas;  -- aqui executamos a função e mudamos o nome da coluna para melhor visualização


------------------------------------------------------------------------
INSERT INTO item_de_lista (nome, quantidade, fk_lista_id, fk_categoria_id)
VALUES 
    ('Arroz', 6, 2, 1)
    
   SELECT * from item_de_lista
------------------------------------------------------------------------    
