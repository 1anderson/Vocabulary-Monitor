#!/bin/bash

function downloadingProject(){
    git clone $1;
}

user=$1
password=$2
listOfUrls=$3
databaseName=''
url=''
repositoryName=''
while read -r line || [[ -n $line ]];
do
  url=$line 
  databaseName=$(echo $line | awk -v FS="(./|.git)" '{print $(NF-1)}')
  repositoryName=$databaseName;
  #echo $databaseName
  databaseName=$(echo $databaseName | awk '{gsub(/-/,"_",$databaseName); print $databaseName}')
  #downloadingProject $url
  ./Initializer.sh $user $password $databaseName
  ./ReviewingHistory.sh $user $password $databaseName $repositoryName

  #rm -rf $databaseName
  
done < url.txt




