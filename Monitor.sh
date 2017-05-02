time=$(date +%H:%M:%S)
path=$2
if [ -e "$NODE_NAME" ] ; then
rm -rf  $NODE_NAME
fi
mkdir $NODE_NAME
user=$(sed -n '5p' $path/Monitor.txt | awk -F ":" '{print $2}')
password=$(sed -n '6p' $path/Monitor.txt | awk -F ":" '{print $2}')
database=$1

java -jar $path/VocabularyExtractor.jar -d . -loc iah -vxl $WORKSPACE/$NODE_NAME/Vocabulary.vxl -csv $WORKSPACE/$NODE_NAME/Vocabulary.csv -mth
java -jar $path/TermsCounter.jar -prop ~/Documentos/Vocabulary-Monitor/termsCounter.properties -vxl $WORKSPACE/$NODE_NAME/Vocabulary.vxl -csv $WORKSPACE/$NODE_NAME/csv_result_file.csv -txt $WORKSPACE/$NODE_NAME/txt_result_file.txt -db $WORKSPACE/$NODE_NAME/terms.csv $WORKSPACE/$NODE_NAME/entities.csv $WORKSPACE/$NODE_NAME/termsXentities.csv

if [ -e $WORKSPACE/date.txt ]; then
 $(touch $WORKSPACE/date.txt)
else
 $(touch $WORKSPACE/date.txt)
fi 

$path/WriterDataBase.sh $user $password $database $WORKSPACE/$NODE_NAME/ $(date +%Y/%m/%d) $GIT_COMMIT
echo "Monitor finished"


echo "Início da execução: $time    Fim da execução: $(date +%H:%M:%S)"


























  


 
 




