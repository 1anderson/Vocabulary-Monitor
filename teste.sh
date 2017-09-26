#!/bin/bash

user=$1
password=$2
listOfUrls=$3
a="";
function downloadingProject(){
    git clone $1;
}

databaseName=''
url=''
while read -r line || [[ -n $line ]];
do
  url=$line 
  databaseName=$(echo $line | awk -v FS="(./|.git)" '{print $(NF-1)}')
  #echo $databaseName
  echo $databaseName | awk '{gsub(/-/,"_",$databaseName);print $databaseName}'
  #echo $databaseName
  #downloadingProject $url
  #./Initializer.sh $user $password $databaseName
  #./ReviewingHistory.sh $user $password $databaseName $databaseName

  #rm -rf $databaseName
  
done < url.txt




