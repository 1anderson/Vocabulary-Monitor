create database mydb;
use mydb;
create table terms_table (id int NOT NULL AUTO_INCREMENT,nome varchar(20),quant INT,PRIMARY KEY (id),build_id DATE,CONSTRAINT `fk_build_table` FOREIGN KEY (build_id) REFERENCES build_date (id) ON DELETE CASCADE);
insert into terms_table (nome,quant,build_id) values ("term1",10,"2017-03-17");


create table build_date (id DATE NOT NULL,commit_hash varchar(100),PRIMARY KEY (id));

CONSTRAINT fk_animais_usuario FOREIGN KEY (iduser) REFERENCES usuario (iduser) 
insert into build_date (id,commit_hash) values ("2017-03-17","eaeeeedadadaeaddaaedaed");

