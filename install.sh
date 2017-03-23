#echo $(pwd)
#mkdir  $NODE_NAME
#java -jar ~/Documentos/VocabularyMonitor/VocabularyExtractor.jar -d . -loc iah -vxl $WORKSPACE/$NODE_NAME/Vocabulary.vxl -csv $WORKSPACE/$NODE_NAME/Vocabulary.csv -mth
#java -jar ~/Documentos/VocabularyMonitor/TermsCounter.jar -prop ~/Documentos/VocabularyMonitor/termsCounter.properties -vxl $WORKSPACE/$NODE_NAME/Vocabulary.vxl -csv $WORKSPACE/#$NODE_NAME/csv_result_file.csv -txt $WORKSPACE/$NODE_NAME/txt_result_file.txt -db $WORKSPACE/$NODE_NAME/terms.csv $WORKSPACE/$NODE_NAME/entities.csv $WORKSPACE/$NODE_NAME/termsXentities.csv

if [ -e $WORKSPACE/date.txt ]; then
 echo "existe"
 $(touch $WORKSPACE/date.txt)
else
 echo "não existe"
 $(touch $WORKSPACE/date.txt)
fi 

#$(date +%Y/%m/%d)
#~/Documentos/VocabularyMonitor/script.sh anderson metallica mydb $WORKSPACE/$NODE_NAME/ $(date +%Y/%m/%d) $GIT_COMMIT































  


 
 




