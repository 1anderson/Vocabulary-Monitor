
mysql -uanderson -pmetallica <<EOF
use history_db;
drop table terms;
drop table entities;
drop table termsXentities;
drop table nascidos;
drop table falescidos;
drop table top_terms;
drop table snapshot_git_date;
drop procedure gerando_tabelas_de_sumarização;



EOF

mysql -uanderson -pmetallica <<EOF
use history_db;
create table snapshot_git_date (id DATE NOT NULL,commit_hash varchar(100),PRIMARY KEY (id));
create table terms (id int NOT NULL AUTO_INCREMENT,name varchar(200),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table entities (id int NOT NULL AUTO_INCREMENT,name varchar(200),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table termsXentities (id int NOT NULL AUTO_INCREMENT,name varchar(200),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table nascidos (id int NOT NULL AUTO_INCREMENT,name varchar(100),PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table falescidos (id int NOT NULL AUTO_INCREMENT,name varchar(100),PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table top_terms (id int NOT NULL AUTO_INCREMENT,name varchar(100),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);   

DELIMITER $$
CREATE PROCEDURE gerando_tabelas_de_sumarização (IN data_atual DATE,IN data_anterior DATE)
BEGIN  
CREATE TEMPORARY TABLE snapshot_atual SELECT * from terms where fk_snapshot_git_date=data_atual;
CREATE TEMPORARY TABLE snapshot_anterior SELECT * from terms where fk_snapshot_git_date=data_anterior;
insert into nascidos select null,name,fk_snapshot_git_date from snapshot_atual where name NOT IN (select name from snapshot_anterior);
insert into falescidos select null,name,fk_snapshot_git_date from snapshot_anterior where name NOT IN (select name from snapshot_atual);
insert into top_terms select null,name,quantity,fk_snapshot_git_date from terms where fk_snapshot_git_date=data_atual ORDER BY quantity DESC LIMIT 10;
END $$ 
DELIMITER ;


EOF
