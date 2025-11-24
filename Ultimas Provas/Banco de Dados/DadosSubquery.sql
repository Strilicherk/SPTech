create database subquerie;

use subquerie;

create table cliente
(
	id int not null,
    nome varchar(100) not null,
    idade int,
	primary key(id)
);

insert into cliente(id, nome, idade)
values (1,'João', 30),
       (2, 'Maria', 35),
       (3, 'Pedro', 28),
       (4, 'Ana', 42),
       (5, 'Luiza', 25),
	   (6, 'Joaquin', 55);
       
create table produto
(
	id int not null,
    nome varchar(100) not null,
    tipo  varchar(20) not null,
    preco decimal(10,2),
	primary key(id)
);
       
insert into produto(id, nome,tipo, preco)       
values (1, 'Camiseta', 'Roupa', 29.99),
		(2, 'Calça', 'Roupa', 59.99),
		(3, 'Sapato', 'Calcado', 99.99),
		(4, 'Bolsa', 'Acessorio', 39.99),
		(5, 'Relógio', 'Acessorio', 199.99),
		(6, 'Boné', 'Acessorio',19.99),
		(7, 'Vestido','Roupa', 79.99),
		(8, 'Meia', 'Calcado', 9.99),
		(9, 'Óculos', 'Acessorio', 49.99),
		(10, 'Jaqueta', 'Roupa', 89.99),
        (11, 'Camisa Social', 'Roupa', 289.00);


create table vendas
(
	id int not null,
    fkcliente  int not null,
    fkproduto  int not null,
    quantidade  decimal(10,3) not null,
	primary key(id),
    constraint ven_cli foreign key (fkcliente) references cliente(id),
    constraint ven_pro foreign key (fkproduto) references produto(id)
);

insert into vendas(id, fkcliente, fkproduto, quantidade)
values (1, 1  , 2  , 1),
		(2, 3  , 5  , 2),
		(3, 2  , 9  , 3),
		(4, 5  , 7  , 1),
		(5, 4  , 1  , 2),
		(6, 1  , 3  , 1),
		(7, 3  , 4  , 2),
		(8, 2  , 8  , 1),
		(9, 5  , 6  , 3),
		(10 , 4  , 10 , 1);
