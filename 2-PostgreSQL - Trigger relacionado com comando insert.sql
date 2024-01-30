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


###############################
#                             #
#        CÓDIGO COMENTADO     #
#                             #
###############################


-- Cria a tabela clientes para armazenar informações sobre os clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,  
    nome VARCHAR(100),      
    email VARCHAR(100),     
    pais VARCHAR(3)        
);

-- Cria a tabela pedidos para armazenar informações sobre os pedidos dos clientes
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,         
    produto VARCHAR(100),          
    quantidade INT,                
    fk_client_id INT,              
    CONSTRAINT fk_cliente          -- Cria a constraint(restrição) de chave estrangeira para referenciar a tabela cliente
        FOREIGN KEY (fk_client_id) REFERENCES clientes(id)  -- Garante que fk_client_id seja uma chave estrangeira referenciando id na tabela clientes
);

-- Inserimos alguns dados na tabela clientes para popular ela
INSERT INTO clientes (nome, email, pais) VALUES
('Sophia', 'sophia@.com', 'USA'),
('Paulo', 'paulo@.com', 'BRA'),
('Roberto', 'roberto@.com', 'MEX'),
('Frederico', 'frederico@.com', 'ITA');

-- Inserimos alguns dados na tabela pedidos para popular ela (*opcional neste passo pois estes pedidos inseridos anteriormente não serão contados em nosso estudo de Trigger)
INSERT INTO pedidos (fk_client_id, produto, quantidade) VALUES
(1, 'Teclado', 200),
(1, 'Mouse', 200),
(2, 'Impressora', 10),
(4, 'Monitor', 3);

-- Criamos agora a tabela contagem_pedidos para armazenar a contagem de pedidos para cada cliente
CREATE TABLE contagem_pedidos (
    cliente_id INT PRIMARY KEY,  -- Coluna de identificação única para cada cliente
    total_pedidos INT DEFAULT 0  -- Coluna para o total de pedidos do cliente, inicializada com 0
                                    --LOGO: A coluna cliente_id vai guardar o ID do cliente que fez o pedido e a coluna total_pedidos vai guardar a quantidade de pedidos que esse cliente fizer
);

-- Criamos aqui uma função chamada: atualizar_contagem_pedidos, ela vai atualizar a contagem de pedidos feitas pelos clientes.
CREATE OR REPLACE FUNCTION atualizar_contagem_pedidos()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza o total de pedidos na tabela contagem_pedidos quando um novo pedido é inserido
    UPDATE contagem_pedidos --Aqui pegamos a tabela que queremos atualizar.
    SET total_pedidos = total_pedidos + 1  --Aqui indicamos que é para ele 'SETar' pegar a coluna total_pedidos e sempre pegar o valor que esta lá e somar + 1 sempre que um cliente fizer um novo pedido.
    WHERE cliente_id = NEW.fk_client_id;  --Aqui ele busca ONDE(Where), então se esse cliente(onde) fizer o pedido associe a ele o novo pedido(SETar a este cliente +1 na linha acima.

    RETURN NEW;  -- Retorna o novo pedido
END;
$$ LANGUAGE plpgsql;

--Aqui criamos o trigger(gatilho) chamado: atualizar_contagem_pedidos_trigger que vai disparar sempre que as condições abaixo descritas foram atendidas. Ele aciona a função atualizar_contagem_pedidos após inserção de pedidos na tabela pedidos.
CREATE TRIGGER atualizar_contagem_pedidos_trigger
AFTER INSERT ON pedidos -- depois de INSERIR dados na tabela pedidos.
FOR EACH ROW --Para cada linha inserida
EXECUTE FUNCTION atualizar_contagem_pedidos(); --execute a função

-- Seleciona todos os dados da tabela contagem_pedidos, para realizarmos um teste, aqui podemos observar que a tabela esta vazia mesmo que tenhamos populado ela no inicio do código que era opcional.
SELECT * FROM contagem_pedidos;

--Mesmo que nós inserirmos novos pedidos na tabela pedidos apartir deste ponto a contagem não seria realizada, para corrigir isso identifiquei que precisariamos ''iniciar'' a tabela contagem de pedidos.
--para isso usamos o comando: INSERT INTO contagem_pedidos (cliente_id) SELECT id FROM clientes; ele vai inserir na tabela contagem de pedidos todos os ID's dos clientes cadastrados na tabela clientes e...
--...iniciar seus contadores de pedidos em 0, por isso os pedidos inseridos antes desse ponto não são contados.

-- agora vamos iniciar nossa tabela contagem_pedidos com o codigo:
INSERT INTO contagem_pedidos (cliente_id) SELECT id FROM clientes;

--Aqui vamos inserir mais 2 pedidos na tabela de pedidos para testar se nosso gatilho esta sendo disparado:
INSERT INTO pedidos (fk_client_id, produto, quantidade) VALUES
(1, 'Modem USB', 200);

-- Insere mais um pedido na tabela pedidos para outro cliente
INSERT INTO pedidos (fk_client_id, produto, quantidade) VALUES
(4, 'Modem USB', 50);

--RESULTADO: Aqui podemos realizar a consulta e observar que os clientes 1 e 4 já tem novos pedidos registrados.
SELECT * FROM contagem_pedidos;


