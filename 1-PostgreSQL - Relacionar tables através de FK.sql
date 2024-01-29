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


#######################################
#                                    #
#          Código Comentado          #
#                                    #
######################################

//primeiro criamos a tabela cliente

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);


//depois criamos a tabela pedidos
//aqui na tabela pedidos criamos uma coluna chamada cliente_id que será usada
como uma foreign key para receber os dados da tabela clientes(id)

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT,
    produto VARCHAR(100),
    quantidade INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

//agora vamos inserir dados na tabela clientes:

INSERT into clientes (nome, email, pais) VALUES
('Sophia', 'sophia@.com', 'USA'),
('Paulo', 'paulo@.com', 'BRA'),
('Roberto', 'roberto@.com', 'MEX'),
('Frederico', 'frederico@.com', 'ITA')


//agora realizo uma consulta para conferir os dados que acabaram de ser inseridos:

SELECT * from clientes

//agora vamos inserir dados na tabela pedidos:


insert INTO pedidos (cliente_id, produto, quantidade) VALUES
(1, 'Teclado', 200),
(1, 'Mouse', 200),
(2, 'Impressora', 10),
(4, 'Monitor', 3)


//agora realizo uma consulta para conferir que os dados que acabaram de ser inseridos:

SELECT * FROM pedidos


agora que temos 2 tabelas populadas podemos fazer uma consulta usando JOIN's:


SELECT clientes.nome, pedidos.produto, pedidos.quantidade //selecionamos as colunas que queremos consultar em nosso banco de dados
FROM pedidos //indicamos de onde queremos obter os dados (aqui no caso tabela chamada pedidos
INNER JOIN clientes  //aqui indicamos que queremos um inner join com a tabela chamada clientes
ON pedidos.cliente_id = clientes.id; //aqui é indicado ONDE(ON - "estar em cima de algo, estar conectado ou envolvido em algo, estar em um estado de atividade ou funcionamento, entre outros.)" onde as colunas/linhas da tabela iram cruzar seus dados
neste caso ele ira até a tabela pedidos na coluna cliente_id e fará correspondencia com a coluna clientes.id da tabela clientes.

