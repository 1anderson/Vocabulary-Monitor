#!/bin/bash
user=$1
pass=$2
#IFS=","
myDb=$3
csvPath=$4
snapshotGitDate=$5 
before_date=$6 
hashCommit=$7

echo "$1 $2 $3 $4 $5 $6"

mysql -u$user -p$pass <<EOF
use history_db;
insert into snapshot_git_date (id,commit_hash) values ("$snapshotGitDate","$hashCommit");
EOF
while read f1 
do
  echo $f1','"$snapshotGitDate"
done < $csvPath/terms.csv > $csvPath/termsFormated.csv

while read f1 
do
  echo $f1','"$snapshotGitDate"
done < $csvPath/entities.csv > $csvPath/entitiesFormated.csv

while read f1 
do
  echo $f1','"$snapshotGitDate"
done < $csvPath/termsXentities.csv > $csvPath/termsXentitiesFormated.csv

mysql -u$user -p$pass <<EOF
use history_db;
LOAD DATA LOCAL INFILE '$csvPath/termsFormated.csv' INTO TABLE terms FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' (name,quantity,fk_snapshot_git_date) SET ID = NULL;
LOAD DATA LOCAL INFILE '$csvPath/entitiesFormated.csv' INTO TABLE entities FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' (name,quantity,fk_snapshot_git_date) SET ID = NULL;
LOAD DATA LOCAL INFILE '$csvPath/termsXentitiesFormated.csv' INTO TABLE termsXentities FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' (name,quantity,fk_snapshot_git_date) SET ID = NULL;
call gerando_tabelas_de_sumarizacao("$snapshotGitDate","$before_date")
EOF
