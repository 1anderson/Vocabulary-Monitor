
mysql -uanderson -pmetallica <<EOF
use vocabulary_db;
drop table terms;
drop table entities;
drop table termsXentities;
drop table snapshot_git_date;


EOF

mysql -uanderson -pmetallica <<EOF
use vocabulary_db;
create table snapshot_git_date (id DATE NOT NULL,commit_hash varchar(100),PRIMARY KEY (id));
create table terms (id int NOT NULL AUTO_INCREMENT,name varchar(200),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table entities (id int NOT NULL AUTO_INCREMENT,name varchar(200),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);
create table termsXentities (id int NOT NULL AUTO_INCREMENT,name varchar(200),quantity INT,PRIMARY KEY (id),fk_snapshot_git_date DATE,FOREIGN KEY (fk_snapshot_git_date) REFERENCES snapshot_git_date (id) ON DELETE CASCADE);


EOF
