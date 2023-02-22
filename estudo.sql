drop table pedido;
drop table produto;
drop table categoria;


CREATE TABLE produto (
    id   numeric,
    nome VARCHAR2(100),
    preco numeric(8,2),
    avaliacao number,
    id_categoria numeric
);
ALTER TABLE produto ADD CONSTRAINT PK_produto PRIMARY KEY (id);
ALTER TABLE produto ADD CONSTRAINT FK_categoria1 FOREIGN KEY (id_categoria) REFERENCES categoria (id);	


CREATE TABLE categoria (
    id   numeric,
    categoria_descricao VARCHAR2(100),
    status char(1)
);
ALTER TABLE categoria ADD CONSTRAINT PK_categoria PRIMARY KEY (id);

create table pedido (
    id numeric,
    num_nota varchar2(100),
    obs varchar2(100),
    id_produto numeric
);
ALTER TABLE pedido add constraint pk_pedido primary key(id);
alter table pedido add constraint fk_produto foreign key(id_produto) REFERENCES produto (id);


commit


insert into categoria (id, categoria_descricao,status)  values (1, 'XBOX','A');
insert into categoria (id, categoria_descricao,status)  values (2, 'PLAYSTATION','A');
insert into categoria (id, categoria_descricao,status)  values (3, 'OUTROS','A');
insert into categoria (id, categoria_descricao,status)  values (4, 'NITENDI WI','A');
insert into categoria (id, categoria_descricao,status)  values (5, 'PC','I');
insert into categoria (id, categoria_descricao,status)  values (6, 'NOTEBOOK','I');
insert into produto (id,nome, preco, avaliacao, id_categoria) values (1,'xbox one', 1999.99,3,1);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (2,'ps4', 2499.99,4,2);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (3,'ps5', 4499.99,4,2);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (4,'xbox serie S', 5499.99,4,1);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (5,' Ana Trujillo Emparedados y helados', 6499.99,2,3);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (6,'Ana Trujillo Emparedados y helados', 6499.99,2,3);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (7,'ana Trujillo Emparedados y helados', 7499.99,5,3);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (8,'ana Trujillo Emparedados y mandioca', 9499.99,8,2);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (9,'ana Trujillo Emparedados y mandioca', 9499.99,9,null);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (10,'Ana Trujillo Emparedados y helados', 6499.99,2,3);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (11,'Ana Trujillo Emparedados y helados', 6499.99,2,3);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (12,'ana Trujillo Emparedados y mandioca', 9499.99,4,null);
insert into produto (id,nome, preco, avaliacao,id_categoria) values (13,'ana Trujillo Emparedados y mandioca', 91499.99,4,null);
insert into pedido (id, num_nota, obs, id_produto) values (1, 'N1', null,1);
insert into pedido (id, num_nota, obs, id_produto) values (2, 'N2', 'celular vendido 07/02/2023',1);
insert into pedido (id, num_nota, obs, id_produto) values (3, 'N3', null,1);
insert into pedido (id, num_nota, obs, id_produto) values (4, 'N4', null,5);
insert into pedido (id, num_nota, obs, id_produto) values (5, 'N5', 'promoção aplica cupom GANHA10',5);
insert into pedido (id, num_nota, obs, id_produto) values (6, 'N6', 'autoriado pelo departamento de vendas',3);
insert into pedido (id, num_nota, obs, id_produto) values (7, 'N7', 'autorizado pelo joacil',10);
insert into pedido (id, num_nota, obs, id_produto) values (8, 'N8', 'nota 18',4);


--SELECT 
select * from produto;
select * from produto where rownum <5;
select * from categoria;
select * from pedido;


-- minino e maximo
select max(preco) from produto;
select min(preco) from produto;

--média 
select AVG(preco) from produto;

--soma
select SUM(preco) from produto;


--like
select * from produto where UPPER(nome) like '%XB%' and UPPER(nome) like '%EM%';



-- between intervalo texto, número ou datas
select preco from produto where preco between 1000 and 2500;

-- alias
select id as codigo, preco as valor_cadastrado from produto;

-- inener join traz todos valores que corresponde nas duas tabelas
select * from produto prod 
inner join categoria cat ON
prod.id_categoria = cat.id

--left join, traz todos que tem relação, e o lado esquerdo que não tem vinculo com o direito

select * from produto prod 
left join categoria cat ON
 prod.id_categoria = cat.id;

-- rigth join, traz todas as categoria incluse as que não tem produtos

select * from produto prod 
right join categoria cat on
prod.id_categoria = cat.id;

-- FULL OUTER join = traz todas mesmo sem corresponder, união do left com rigth

select count(*) from produto;
select * from produto prod 
full outer join categoria cat on
prod.id_categoria = cat.id;

--

select * from categoria;
select * from produto;

--UNION , UNION ALL - PERMITE UNIFICAR TABELAS COM CARACTERISTICAS PARECIDAS EX: NÚMERO DE COLUNAS
select p.nome as p_nome, p.id_categoria as p_categoria from produto p 
union all select categoria_descricao, id from categoria c where c.id in (1,2);

--union com distinct
select distinct nome from produto where avaliacao = 3
union all
select distinct nome from produto where avaliacao = 2

-- sem distinct
select  * from produto where avaliacao = 3
union all
select *  from produto where avaliacao = 2

select p.id as p_id, p.nome as p_nome from produto p 
union all 
select c.id as c_id, c.categoria_descricao as c_cat_desc from categoria c where c.id in (4,3)

-- GROUP BY

--geralmente é usada com funções de agregação ( COUNT(), MAX(), MIN(), SUM(), AVG())

select * from produto;
select * from categoria;
select count(*) from produto group by avaliacao

select avaliacao, count(*) from produto p group by avaliacao


-- quantitativo de categoria na tabela de produto usando INNER JOIN, somente as categorias que tem relação
select p.id_categoria, count(*) from produto p 
inner join categoria c on p.id_categoria = c.id
group by p.id_categoria

-- quantitativo de categoria na tabela de produto LEFT JOIN
-- contagem e agrupado por id, na tabela de produto

select * from categoria;
select p.id_categoria, count(*) from produto p 
left join categoria c on p.id_categoria = c.id
group by p.id_categoria

-- quantitativo de categoria na tabela de produto, considerando quantitivo de categoria sem relação com produto (RIGHT JOIN)
-- contagem e agrupado por id, na tabela de categoria
select p.id_categoria, count(*) from produto p 
right join categoria c on p.id_categoria = c.id
group by p.id_categoria

-- leva em consideração tudo, tabela esquerda e direita (FULL JOIN)
select p.id_categoria, count(*) from produto p 
full join categoria c on p.id_categoria = c.id
group by p.id_categoria



-- HAVING é where , porém para group by

select avaliacao, count(*) from produto
group by avaliacao 
having avaliacao between 3 and 7
order by avaliacao asc

-- EXISTS and NOT EXISTS

-- executa o comando sql se atender a condição exists, caso contrário não
--
SELECT nome from produto where exists (
select id from categoria where status = 'I' 
);

SELECT nome from produto where exists (
select id from categoria where status = 'AI' 
);

--NOT EXISTS
SELECT nome from produto where not exists (
select id from categoria where status = 'AI' 
);

-- ANY E ALL

--any
/*
O operador Oracle ANY é usado para comparar um valor a uma lista de valores ou conjunto de resultados retornado por uma subconsulta. 
O seguinte ilustra a sintaxe do operador ANY quando usado com uma lista ou subconsulta:
*/
select prod.id, prod.nome from produto prod
where prod.id =  any (select pedid.id from pedido pedid where pedid.obs is not null);

--outra maneira mesmo resultado
select * from produto prod
inner join pedido pedi
on prod.id = pedi.id
where pedi.obs is not null;


--SQL SELECT INTO - criando copia da tabela com registro a partir do select

drop table pedido_backup;

create table pedido_backup as select * from pedido; --copia todos os campos
--create table pedido_backup as select id,num_nota from pedido; --vc especifica quais campos vc quer
select * from pedido_backup;

--INSERT INTO SELECT Sintaxe

select * from pedido;
insert into pedido_backup select id,num_nota from pedido where obs is not null;
select * from pedido_backup;

-- CASE

select * from produto

select nome, preco, avaliacao,
case
    when preco < 2000.00 then preco - 500
    when preco > 2000.00 then preco * 3
end as teste,
case
    when avaliacao = 3 then avaliacao * 2
end as teste2
from produto 


select p.id, p.nome, c.id, c.categoria_descricao, c.status, p.preco,
case
    when c.status = 'I' then 'INATIVADO'
    when c.status = 'A' and p.preco > 5000.00 then 'ATIVO E MAIOR QUE 5K'
    else 'ATIVADO'
end as status
from produto p 
inner join categoria c 
on p.id_categoria = c.id

-- NULL FUNCTIONS
--quando o valor é nulo substitui por outro

select nome, NVL(id_categoria, 100)
from produto

SELECT
  NVL(NULL, 'N/A')
FROM
  dual;

-- FETCH  limita o retorno de linha

select * from produto fetch next 5 rows only;

--CROSS JOIN , não possui a clausula on, pois ele faz o cruzamento de dados independente

select * from produto p
inner join categoria c
on p.id_categoria = c.id;

select * from produto p
cross join categoria c

--


select nome, preco
from produto
where
preco = (
    select
        max(preco)
            from
                produto
);

--- criando view

create view vw_todos_pedidos as
select * from pedido where obs is not null


select * from vw_todos_pedidos
--drop view vw_todos_pedidos

--












