/*Este banco de dados (uvv) terá por finalidade cadastrar e identificar clientes.
O cliente também poderá ver o status dos pedidos, conseguindo
identificar e análisar como se encontra o pedido.
Terá os dados, localizações das lojas dando total suporte
para os clientes.
É possível identificar os produtos comprados e também
identificar envios, estoques e itens do pedido.*/

-- Excluindo banco de dados se estiver algum criado.

DROP DATABASE IF EXISTS uvv;

-- Excluindo usuário se estiver algum criado.

DROP USER IF EXISTS marcos;

/*Criando usuário com permissões para criar banco de dados e usuários,
e definindo uma senha encrypted.*/

CREATE USER marcos WITH createdb createrole encrypted password 'sevira';

-- Criação do banco de dados "uvv".

CREATE DATABASE uvv
    WITH 
    OWNER = marcos
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;


-- logando no banco de dados e no usuário criado.

\c "dbname=uvv user=marcos password=sevira"

-- Criação do esquema.

CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION marcos;

-- Colocando o esquema "lojas" como padrão permanentemente.
ALTER USER marcos
SET SEARCH_PATH TO lojas, "$user", public;

-- Criação da tabela (produtos).
CREATE TABLE lojas.produtos (
produto_id                    NUMERIC  (38)    NOT NULL,
nome                          VARCHAR  (255)   NOT NULL,
preco_unitario                NUMERIC  (10,2)          ,
detalhes                      BYTEA                    ,
imagem                        BYTEA                    ,
imagem_mime_type              VARCHAR  (512)           ,
imagem_arquivo                VARCHAR  (512)           ,
imagem_charset                VARCHAR  (512)           ,
imagem_ultima_atualizacao     DATE                     ,
CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

-- Adicionando checagem na coluna "preco_unitario" para que seja acima de 0.

ALTER TABLE lojas.produtos
ADD CONSTRAINT ck_preco_unitario_produtos
CHECK
(preco_unitario > 0);

-- Comentários das colunas e da tabela em geral (produtos):

COMMENT ON TABLE lojas.produtos
                        IS 
'Criação da tabela "produtos" que têm finalidade identificar
produtos, nomes, preços, detalhes e imagens.';

COMMENT ON COLUMN lojas.produtos.produto_id
                        IS 
'Criação da coluna "produto_id" que têm finalidade identificar produtos.
Está coluna é uma primary key da tabela.
Está coluna faz parte da tabela (lojas.produtos).';

COMMENT ON COLUMN lojas.produtos.nome
                        IS 
'Criação da coluna "nome" que têm finalidade identificar
o nome do produto.
Está coluna faz parte da tabela (lojas.produtos).';

COMMENT ON COLUMN lojas.produtos.preco_unitario
                        IS 
'Criação da coluna "preco_unitario" que têm finalidade
mostrar o preço unitário de cada produto.
Está coluna faz parte da tabela (lojas.produtos).';

COMMENT ON COLUMN lojas.produtos.detalhes
                        IS
'Criação da coluna "detalhes" que têm finalidade informar
os detalhes dos produtos.
Está coluna faz parte da tabela (lojas.produtos).';

COMMENT ON COLUMN lojas.produtos.imagem
                        IS 
'Criação da coluna "imagem" que tẽm finalidade fornecer
imagens do produto.
Está coluna faz parte da tabela (lojas.produtos).';

COMMENT ON COLUMN lojas.produtos.imagem_mime_type
                        IS 
'Criação da coluna "imagem_mime_type" que têm finalidade
guardar e identificar a forma do arquivo da imagem.
Está coluna faz parte da tabela (lojas.produtos).';

COMMENT ON COLUMN lojas.produtos.imagem_arquivo
                        IS
'Criação da coluna "imagem_arquivo" que têm
finalidade de armazenar uma imagem digital.
Está coluna faz parte da tabela (lojas.produtos).';

COMMENT ON COLUMN lojas.produtos.imagem_charset
                        IS 
'Criação da coluna "imagem_charset" que têm finalidade exibir caracteres
especiais ou algoritmos complexos em uma imagem.
Está coluna faz parte da tabela (lojas.produtos).';

COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao
                        IS
'Criação da coluna "imagem_ultima_atualizacao" que têm finalidade de armazenar
o nome da última imagem adicionada ou atualizada na tabela.
Está coluna faz parte da tabela (lojas.produtos).';

CREATE TABLE lojas.lojas (
loja_id                   NUMERIC  (38)     NOT NULL,
nome                      VARCHAR  (255)    NOT NULL,
endereco_web              VARCHAR  (100)            ,
endereco_fisico           VARCHAR  (512)            ,
latitude                  NUMERIC                   ,
longitude                 NUMERIC                   ,
logo BYTEA                                              ,                            
logo_mime_type            VARCHAR  (512)            ,
logo_arquivo              VARCHAR  (512)            ,
logo_charset              VARCHAR  (512)            ,
logo_ultima_atualizacao   DATE                      ,
CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

/*Adicionando uma checagem para coluna (lojas.lojas) na coluna endereco_web
e endereco_fisico para que uma delas
não seja nula.*/

ALTER TABLE lojas.lojas
ADD CONSTRAINT ck_endereco
CHECK
(endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);

-- Comentários da tabela e das colunas em geral (lojas.lojas).

COMMENT ON TABLE lojas.lojas
                        IS 
'Criação da tabela lojas que têm por finalidade
registrar todos os dados da loja.
Como nome, endereço físico, web, logo.';

COMMENT ON COLUMN lojas.lojas.loja_id
                        IS 
'Criação da coluna "loja_id" que têm por finalidade
identificar a loja.
Está coluna é a primary key da tabela (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.nome
                        IS 
'Criação da coluna "nome" que têm por finalidade
registrar o nome da loja.
Está coluna faz parte da tabela (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.endereco_web
                        IS 
'Criação da coluna "endereco_web" que têm finalidade de
registrar o endereço web da loja.
Está coluna faz parte da tabela (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.endereco_fisico
                        IS
 'Criação da coluna "endereco_fisico" que têm finalidade
 registrar o endereço físico da loja.
Está coluna faz parte da coluna (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.latitude
                        IS 
'Criação da coluna "latitude" que têm finalidade
registrar a latitude da loja.
Está coluna faz parte da tabela (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.longitude
                        IS 
'Criação da coluna "longitude" que têm por finalidade
registrar a longitude da loja.
Está coluna faz parte da tabela (lojas.lojas).';
COMMENT ON COLUMN lojas.lojas.logo
                        IS 
'Criação da coluna "logo" que têm finalidade
registrar a logo da loja.
Está coluna faz parte da tabela (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.logo_mime_type
                        IS
'Criação da coluna "logo_mime_type" que têm por
finalidade identificar o formato
do arquivo da logo, para que outros aplicativos da web
identifiquem o tipo de conteúdo de um arquivo.
Está coluna faz parte da tabela (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.logo_arquivo
                        IS 
'Criação da coluna "logo_arquivo" que têm por
finalidade exibir o formato da imagem em que está o
arquivo da loja.
Está coluna faz parte da tabela (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.logo_charset
                        IS
'Criação da coluna "logo_charset" que têm finalidade
exibir caracteres especiais ou algoritmos complexos na logo.
Está coluna faz parte da tabela (lojas.lojas).';

COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao
                        IS 
'Criação da coluna "logo_ultima_atualizacao" que têm por finalidade
armazenar o nome da última imagem
adicionada ou atualizada na tabela.
Está coluna faz parte da tabela (lojas.lojas).';

CREATE TABLE lojas.estoques (
estoque_id                   NUMERIC  (38) NOT NULL,
loja_id                      NUMERIC  (38) NOT NULL,
produto_id                   NUMERIC  (38) NOT NULL,
quantidade                   NUMERIC  (38) NOT NULL,
CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

-- Adicionando checagem na tabela (lojas.estoques) para que a quantidade seja acima de 0.

ALTER TABLE lojas.estoques
ADD CONSTRAINT ck_quantidade_estoques
CHECK
(quantidade > 0);

--Comentários das colunas e da tabela em geral (lojas.estoques).

COMMENT ON TABLE lojas.estoques
                        IS 
'Criação da tabela "estoques" que têm finalidade de
identificar quantidades, produtos, lojas e estoques.';

COMMENT ON COLUMN lojas.estoques.estoque_id
                        IS 
'Criação da coluna "estoque_id" que têm finalidade
identificar estoques.
Está coluna é uma primary key da tabela.
Está coluna faz parte da tabela (lojas.estoques).';

COMMENT ON COLUMN lojas.estoques.loja_id
                        IS 
'Criação da coluna "loja_id" que têm finalidade
identificar o estoque de produtos da loja.
Está coluna é uma foreign key da tabela.
Está coluna faz parte da tabela (lojas.estoques).';

COMMENT ON COLUMN lojas.estoques.produto_id
                        IS 
'Criação da coluna "produto_id" que têm finalidade
identificar os produtos.
Está coluna é uma foreign key da tabela.
Está coluna faz parte da tabela (lojas.estoques).';

COMMENT ON COLUMN lojas.estoques.quantidade
                        IS 
'Criação da coluna "quantidade" que têm finalidade registrar
a quantidades de produtos.
Está coluna é uma foreign key da tabela.
Está coluna faz parte da tabela (lojas.estoques).';

CREATE TABLE lojas.clientes (
cliente_id                   NUMERIC  (38)  NOT NULL,
email                        VARCHAR  (255) NOT NULL,
nome                         VARCHAR  (255) NOT NULL,
telefone1                    VARCHAR  (20)          ,
telefone2                    VARCHAR  (20)          ,
telefone3                    VARCHAR  (20)          ,
CONSTRAINT pk_cliente_id PRIMARY KEY (cliente_id)
);

-- Comentários das colunas e da tabela (lojas.clientes).

COMMENT ON TABLE lojas.clientes
                        IS
'Criação da tabela "lojas.clientes" que têm por
finalidade registrar o cadastro de clientes.';

COMMENT ON COLUMN lojas.clientes.cliente_id
                        IS
'Coluna "cliente_id" que têm finalidade de identificar o cliente.
Está coluna é uma primary key da tabela (lojas.clientes).';

COMMENT ON COLUMN lojas.clientes.email
                        IS 
'Criação da coluna "email", que têm por finalidade
registrar os emails dos clientes da tabela (lojas.clientes).';

COMMENT ON COLUMN lojas.clientes.nome
                        IS
'Criação da coluna "nome" que têm por finalidade
listar os nomes dos clientes da tabela (lojas.clientes).';

COMMENT ON COLUMN lojas.clientes.telefone1
                        IS 
'Criação da coluna "telefone1", que têm por finalidade
registrar o primeiro telefone de clientes da tabela
(clientes).';

COMMENT ON COLUMN lojas.clientes.telefone2
                        IS 
'Criação da coluna "telefone2", que têm por finalidade
registrar o segundo telefone da pessoa caso ela obtenha.
Coluna que faz parte da tabela (lojas.clientes).';

COMMENT ON COLUMN lojas.clientes.telefone3
                        IS
'Criação da coluna "telefone3",que têm por finalidade
registrar o terceiro número da pessoa caso ela obtenha.
Coluna que faz parte da tabela (lojas.clientes).';

CREATE TABLE lojas.envios (
envio_id                   NUMERIC  (38)  NOT NULL,
loja_id                    NUMERIC  (38)  NOT NULL,
cliente_id                 NUMERIC  (38)  NOT NULL,
endereco_entrega           VARCHAR  (512) NOT NULL,
status                     VARCHAR  (15)  NOT NULL,
CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

/*Adicionando checagem na tabela (lojas.envios) para que a coluna
"status" ela dê os resultados informados
conforme a atualização do pedido.*/

ALTER TABLE lojas.envios
ADD CONSTRAINT ck_status_envios
CHECK
(status in ('CRIADO', 'ENVIADO', 'TRANSITO','ENTREGUE'));

--Comentários das colunas e da tabela (lojas.envio).

COMMENT ON TABLE lojas.envios
                        IS
'Criação da tabela  "envios" que têm por finalidade
registrar o id da loja, id de clientes, endereço de entrega e
status da entrega.';

COMMENT ON COLUMN lojas.envios.envio_id
                        IS 
'Criação da coluna "envio_id", que têm por finalidade
identificar o envio do produto.
Está coluna é uma primary key da tabela.
Está coluna faz parte da tabela (lojas.envios).';

COMMENT ON COLUMN lojas.envios.loja_id
                        IS 
'Criação da coluna "loja_id" que têm por finalidade
identificar a loja que efetuou o pedido.
Está coluna é uma foreign key da tabela.
Está coluna faz parte da tabela (lojas.envios).';

COMMENT ON COLUMN lojas.envios.cliente_id
                        IS
'Criação da coluna "cliente_id" que têm finalidade
identificar clientes que efetuaram pedido.
Está coluna é uma foreign key da tabela.
Está coluna faz parte da tabela (lojas.envios).';

COMMENT ON COLUMN lojas.envios.endereco_entrega
                        IS 
'Criação da coluna "endereco_entrega" que têm finalidade
mostrar o endereço de entrega do cliente.
Está coluna faz parte da tabela (lojas.envios).';

COMMENT ON COLUMN lojas.envios.status
                        IS
'Criação da coluna "status" que têm finalidade mostrar
o status do envio do produto.
Está coluna faz parte da tabela (lojas.envios).';

CREATE TABLE lojas.pedidos (
pedido_id                   NUMERIC   (38)    NOT NULL,
data_hora                   TIMESTAMP         NOT NULL,
cliente_id                  NUMERIC   (38)    NOT NULL,
status                      VARCHAR   (15)    NOT NULL,
loja_id                     NUMERIC   (38)    NOT NULL,
CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);


/*Adicionando checagem na tabela (lojas.pedidos) para que
a coluna "status" dê as especificações conforme foi
atualizado.*/  

ALTER TABLE lojas.pedidos
ADD CONSTRAINT ck_status_pedidos
CHECK
(status in ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO','REEMBOLSADO', 'ENVIADO'));

--Comentários das colunas e da tabela (lojas.pedidos).

COMMENT ON TABLE lojas.pedidos
                        IS
'Criação da tabela "pedidos" que têm por finalidade
registrar pedidos, id de clientes, a data e a hora do pedido,
o status e o id da loja.';

COMMENT ON COLUMN lojas.pedidos.pedido_id
                        IS
'Criação da coluna "pedido_id" que tem finalidade
identificar o pedido dos clientes.
Está coluna é primary key da tabela (lojas.pedidos).';

COMMENT ON COLUMN lojas.pedidos.data_hora
                        IS 
'Criação da coluna "data_hora" que têm por finalidade
registrar a data e a hora que o pedido foi feito pelos clientes.
Está coluna faz parte da tabela (lojas.pedidos).';

COMMENT ON COLUMN lojas.pedidos.cliente_id
                        IS 
'Criação da coluna "cliente_id", que têm por finalidade
registrar o id de clientes que fizeram pedidos.
Está coluna é uma foreign key da tabela.
Está coluna faz parte da tabela (lojas.pedidos).';

COMMENT ON COLUMN lojas.pedidos.status
                        IS
 'Criação da coluna "status" que têm por finalidade
 ver as atualizações do pedido do cliente.
Está coluna faz parte da tabela (lojas.pedidos).';

COMMENT ON COLUMN lojas.pedidos.loja_id
                        IS
'Criação da coluna "loja_id" que têm por finalidade
registrar o id da loja que efetuou o pedido.
Está coluna é uma foreign key da tabela.
Está coluna faz parte da tabela (lojas.pedidos).';

CREATE TABLE lojas.pedidos_itens (
pedido_id                           NUMERIC  (38)   NOT NULL,
produto_id                          NUMERIC  (38)   NOT NULL,
numero_da_linha                     NUMERIC  (38)   NOT NULL,
preco_unitario                      NUMERIC  (10,2) NOT NULL,
quantidade                          NUMERIC  (38)   NOT NULL,
envio_id                            NUMERIC  (38)           ,
CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

/*Adicionando checagem na tabela (lojas.pedidos_itens)
na coluna "preco_unitario" para que o preço
seja maior que 0.*/

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT ck_preco_unitario_pedidos_itens
CHECK
(preco_unitario > 0);

/* Adicionando checagem na tabela (lojas.pedidos_itens)
na coluna "quantidade" para que a quantidade
seja maior que 0.*/

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT ck_quantidade_pedidos_itens CHECK (quantidade > 0);

-- Comentários das colunas e da tabela (lojas.pedidos_itens).

COMMENT ON TABLE lojas.pedidos_itens
                        IS 
'Criação da tabela "pedidos_itens" que têm finalidade de
identificar preços unitários, produtos,
pedidos, quantidades e o envio.';

COMMENT ON COLUMN lojas.pedidos_itens.pedido_id
                        IS
'Criação da coluna "pedido_id" que têm finalidade de
identificar os pedidos feitos.
Está coluna é uma Primary Foreign key da tabela.
Está coluna faz parte da tabela (lojas.pedidos_itens).';

COMMENT ON COLUMN lojas.pedidos_itens.produto_id
                        IS
'Criação da coluna "produto_id" que têm finalidade
identificar produtos.
Está coluna é uma Primary Foreign key da tabela.
Está coluna faz parte da tabela (lojas.pedidos_itens).';

COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha
                        IS
'Criação da coluna "numero_da_linha" que têm finalidade
mostrar o número da linha do produto fornecido.
Está coluna faz parte da tabela (lojas.pedidos_itens).';

COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario
                        IS
'Criação da coluna "preco_unitario" que têm finalidade
de mostrar o preço unitário por cada peça/item do pedido.
Está coluna faz parte da tabela (lojas.pedidos_itens).';

COMMENT ON COLUMN lojas.pedidos_itens.quantidade
                        IS 
'Criação da coluna "quantidade" que têm finalidade mostrar a
quantidade de pedidos/itens realizados e fornecidos.
Está coluna faz parte da tabela (lojas.pedidos_itens).';

COMMENT ON COLUMN lojas.pedidos_itens.envio_id
                        IS
'Criação da coluna "envio_id", que têm por finalidade
identificar o envio do produto.
Está coluna é uma primary key da tabela.
Está coluna faz parte da tabela (lojas.pedidos_itens).';

/*adicionando as foreign keys para dar
relacionamentos entre as tabelas.*/

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques
ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos
ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios
ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques
ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos
ADD CONSTRAINT fk_clientes_pedidos
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios
ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
