mkdir  $NODE_NAME
java -jar ~/Documentos/Vocabulary-Monitor/VocabularyExtractor.jar -d . -loc iah -vxl $WORKSPACE/$NODE_NAME/Vocabulary.vxl -csv $WORKSPACE/$NODE_NAME/Vocabulary.csv -mth
java -jar ~/Documentos/Vocabulary-Monitor/TermsCounter.jar -prop ~/Documentos/Vocabulary-Monitor/termsCounter.properties -vxl $WORKSPACE/$NODE_NAME/Vocabulary.vxl -csv $WORKSPACE/$NODE_NAME/csv_result_file.csv -txt $WORKSPACE/$NODE_NAME/txt_result_file.txt -db $WORKSPACE/$NODE_NAME/terms.csv $WORKSPACE/$NODE_NAME/entities.csv $WORKSPACE/$NODE_NAME/termsXentities.csv

if [ -e $WORKSPACE/date.txt ]; then
 echo "existe"
 $(touch $WORKSPACE/date.txt)
else
 echo "não existe"
 $(touch $WORKSPACE/date.txt)
fi 

~/Documentos/Vocabulary-Monitor/script.sh anderson metallica history_db $WORKSPACE/$NODE_NAME/ $(date +%Y/%m/%d) $GIT_COMMIT































  


 
 




