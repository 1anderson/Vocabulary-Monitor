time=$(date +%H:%M:%S)
path=$2
user=$(sed -n '5p' $path/Monitor.txt | awk -F ":" '{print $2}')
password=$(sed -n '6p' $path/Monitor.txt | awk -F ":" '{print $2}')
database=$1

if ! [ -e "$NODE_NAME" ] ; then
mkdir $NODE_NAME
fi

if ! [ -e $WORKSPACE/$NODE_NAME/dateActual.txt ]; then
  $(date +%Y%m%d > $WORKSPACE/$NODE_NAME/dateActual.txt)
  $(date +%Y%m%d > $WORKSPACE/$NODE_NAME/dateAfter.txt)    
fi 

dateActual=$(cat $WORKSPACE/$NODE_NAME/dateActual.txt)
dateAfter=$(cat $WORKSPACE/$NODE_NAME/dateAfter.txt)

if [ $(date +%Y%m%d) -gt $dateActual ]; then
#dateActualInIsoFormat="${dateActual:4:8}-${dateActual:2:2}-${dateActual:0:2}"
#dateAfterInIsoFormat=$(echo "${dateAfter:4:8}-${dateAfter:2:2}-${dateAfter:0:2}")
java -jar $path/VocabularyExtractor.jar -d . -loc iah -vxl $WORKSPACE/$NODE_NAME/Vocabulary.vxl -csv $WORKSPACE/$NODE_NAME/Vocabulary.csv -mth
java -jar $path/TermsCounter.jar -prop ~/Documentos/Vocabulary-Monitor/termsCounter.properties -vxl $WORKSPACE/$NODE_NAME/Vocabulary.vxl -csv $WORKSPACE/$NODE_NAME/csv_result_file.csv -txt $WORKSPACE/$NODE_NAME/txt_result_file.txt -db $WORKSPACE/$NODE_NAME/terms.csv $WORKSPACE/$NODE_NAME/entities.csv $WORKSPACE/$NODE_NAME/termsXentities.csv
$path/WriterDataBase.sh $user $password $database $WORKSPACE/$NODE_NAME/ $dateActual $dateAfter ""
$(date +%Y%m%d> $WORKSPACE/$NODE_NAME/dateActual.txt)
 echo "$dateActual" > $WORKSPACE/$NODE_NAME/dateAfter.txt
  else
     $(date +%Y%m%d > $WORKSPACE/$NODE_NAME/dateActual.txt)
	
 fi

echo "Monitor finished"
echo "Início da execução: $time    Fim da execução: $(date +%H:%M:%S)"




























  


 
 




