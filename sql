create database mydb;
use mydb;
create table terms_table (id int NOT NULL AUTO_INCREMENT,nome varchar(20),quant INT,PRIMARY KEY (id),build_id DATE,CONSTRAINT `fk_build_table` FOREIGN KEY (build_id) REFERENCES build_date (id) ON DELETE CASCADE);
insert into terms_table (nome,quant,build_id) values ("term1",10,"2017-03-17");


create table build_date (id DATE NOT NULL,commit_hash varchar(100),PRIMARY KEY (id));

CONSTRAINT fk_animais_usuario FOREIGN KEY (iduser) REFERENCES usuario (iduser) 
insert into build_date (id,commit_hash) values ("2017-03-17","eaeeeedadadaeaddaaedaed");




create database mydb;
use mydb;
create table terms_table (id int NOT NULL AUTO_INCREMENT,nome varchar(20),quant INT,PRIMARY KEY (id),build_id DATE,CONSTRAINT `fk_build_table` FOREIGN KEY (build_id) REFERENCES build_date (id) ON DELETE CASCADE);
insert into terms_table (nome,quant,build_id) values ("term1",10,"2017-03-17");2017-03-17


create table build_date (id DATE NOT NULL,commit_hash varchar(100),PRIMARY KEY (id));

CONSTRAINT fk_animais_usuario FOREIGN KEY (iduser) REFERENCES usuario (iduser) 
insert into build_date (id,commit_hash) values ("2017-03-17","eaeeeedadadaeaddaaedaed");

LOAD DATA LOCAL INFILE './saida.csv' INTO TABLE terms_table FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' (nome,quant,build_id) SET ID = NULL;

select nome from terms_table where build_id "2017-03-18" NOT IN (select nome from terms_table where build_id"2017-03-17");

2017-03-17
2017-03-18



select * from terms_2 where nome NOT IN (select nome from terms_1)
select * from tabela_temporaria order by quant DESC


CREATE TEMPORARY TABLE Snapshot_atual SELECT * from terms_table where build_id=2012-11-13;
select name from tabela_temporaria where name  NOT IN (select name from tabela_temporaria1); nascidos emp1=2012-11-09 temp=2012-11-13
select name from tabela_temporaria1 where name  NOT IN (select name from tabela_temporaria); = falecidos

create table nascidos select name, fk_snapshot_git_date from tabela_temporaria where name NOT IN (select name from tabela_temporaria1);
create table falecidos select name, fk_snapshot_git_date from tabela_temporaria1 where name  NOT IN (select name from tabela_temporaria);


DELIMITER $$
CREATE PROCEDURE gerando_tabelas_de_sumarização (IN data_atual DATE,IN data_anterior DATE)
BEGIN

CREATE TEMPORARY TABLE snapshot_atual SELECT * from terms_table where build_id=data_atual;
CREATE TEMPORARY TABLE snapshot_anterior SELECT * from terms_table where build_id=data_anterior;
create table nascidos select name,fk_snapshot_git_date from snapshot_atual where name NOT IN (select name from snapshot_anterior);

END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE gerando_tabelas_de_sumarização (IN data_atual DATE,IN data_anterior DATE)
BEGIN  
CREATE TEMPORARY TABLE snapshot_atual SELECT * from terms where fk_snapshot_git_date=data_atual; CREATE TEMPORARY TABLE snapshot_anterior SELECT * from terms where fk_snapshot_git_date=data_anterior; 
create table nascidos select name,fk_snapshot_git_date from snapshot_atual where name NOT IN (select name from snapshot_anterior);
create table falecidos select name, fk_snapshot_git_date from snapshot_anterior where name  NOT IN (select name from snapshot_atual);
create table top_terms select * from terms where fk_snapshot_git_date=data_atual ORDER BY quantity DESC LIMIT 10;
END $$ 
DELIMITER ;

