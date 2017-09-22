#!/bin/bash

user=$1
password=$2
listOfUrls=$4

function downloadingProject(){
    git clone $1;
}

databaseName=''
url=''
while read -r line || [[ -n $line ]];
do
  url=$line 
  databaseName=$(echo $line | awk -v FS="(./|.git)" '{print $(NF-1)}')
  echo $databaseName
  downloadingProject $url
  ./ReviewingHistory $user $password $databaseName $databaseName

  rm -rf $databaseName
  
done < url.txt




