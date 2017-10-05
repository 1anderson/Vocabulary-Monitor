user=$1
password=$2
database=$3

if [[ ! $user ]]; 
  then
    echo "ERR: User is required" 1>&2
    exit 1
elif [[ ! $password ]]; 
  then
     echo "ERR: Password is required" 1>&2
     exit 1
elif [[ ! $database ]]; 
  then
     echo "ERR: Database is required" 1>&2
     exit 1
fi

RESULT=`mysql -u $user -p$password --skip-column-names -e "SHOW DATABASES LIKE '$database'"`
if [ "$RESULT" == $database ]; 
  then
   echo "ERR: Banco de dados com esse nome já existe, por favor, escolha outro nome"
   exit	1
fi

mysql -u$user -p$password <<EOF
create database $database;
use $database;
create table snapshot_git_date (id DATE NOT NULL,commit_hash varchar(100),PRIMARY KEY (id));
create table terms (id int NOT NULL AUTO_INCREMENT,name varchar(200),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table entities (id int NOT NULL AUTO_INCREMENT,name varchar(200),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table created_terms (id int NOT NULL AUTO_INCREMENT,name varchar(100),PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table deleted_terms (id int NOT NULL AUTO_INCREMENT,name varchar(100),PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table top_terms (id int NOT NULL AUTO_INCREMENT,name varchar(100),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table created_entities (id int NOT NULL AUTO_INCREMENT,name varchar(100),PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table deleted_entities (id int NOT NULL AUTO_INCREMENT,name varchar(100),PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table top_entities (id int NOT NULL AUTO_INCREMENT,name varchar(100),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);     

DELIMITER $$
CREATE PROCEDURE gerando_tabelas_de_sumarização (IN data_atual DATE,IN data_anterior DATE)
BEGIN  
CREATE TEMPORARY TABLE snapshot_atual_terms SELECT * from terms where fk_snapshot_git_date=data_atual;
CREATE TEMPORARY TABLE snapshot_anterior_terms SELECT * from terms where fk_snapshot_git_date=data_anterior;
insert into created_terms select null,name,fk_snapshot_git_date from snapshot_atual_terms where name NOT IN (select name from snapshot_anterior_terms);
CREATE TEMPORARY TABLE t1 select name,fk_snapshot_git_date from snapshot_anterior_terms where name  NOT IN (select name from snapshot_atual_terms);
update t1 SET fk_snapshot_git_date=data_atual;
insert into deleted_terms select null,name,fk_snapshot_git_date from t1;
insert into top_terms select null,name,quantity,fk_snapshot_git_date from terms where fk_snapshot_git_date=data_atual ORDER BY quantity DESC LIMIT 10;
CREATE TEMPORARY TABLE snapshot_atual_entities SELECT * from entities where fk_snapshot_git_date=data_atual;
CREATE TEMPORARY TABLE snapshot_anterior_entities SELECT * from entities where fk_snapshot_git_date=data_anterior;
insert into created_entities select null,name,fk_snapshot_git_date from snapshot_atual_entities where name NOT IN (select name from snapshot_anterior_entities);
CREATE TEMPORARY TABLE t1_entities select name,fk_snapshot_git_date from snapshot_anterior_entities where name  NOT IN (select name from snapshot_atual_entities);
update t1_entities SET fk_snapshot_git_date=data_atual;
insert into deleted_entities select null,name,fk_snapshot_git_date from t1_entities;
insert into top_entities select null,name,quantity,fk_snapshot_git_date from entities where fk_snapshot_git_date=data_atual ORDER BY quantity DESC LIMIT 10;
END $$ 
DELIMITER ;


EOF
