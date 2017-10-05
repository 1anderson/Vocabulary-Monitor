#Declaration of variables#

user=$1
password=$2
myDb=$3
repositoryPath=$4
repositoryAtual=$(pwd)
dateAfter='' 
#Declaration of variables#

#Declaration of functions#
function extractVocabularyFromThisVersion(){
java -jar ./VocabularyExtractor.jar -d $1 -loc iah -vxl ./temporaryFolder/filesGeneratedAfterExtraction/Vocabulary.vxl -csv temporaryFolder/filesGeneratedAfterExtraction/Vocabulary.csv -mth
java -jar ./TermsCounter.jar -prop ./termsCounter.properties -vxl ./temporaryFolder/filesGeneratedAfterExtraction/Vocabulary.vxl -csv ./temporaryFolder/filesGeneratedAfterExtraction/csv_result_file.csv -txt ./temporaryFolder/filesGeneratedAfterExtraction/txt_result_file.txt -db ./temporaryFolder/filesGeneratedAfterExtraction/terms.csv ./temporaryFolder/filesGeneratedAfterExtraction/entities.csv ./temporaryFolder/filesGeneratedAfterExtraction/termsXentities.csv
}
function saveVocabularyWithinTheDatabase(){
         ./WriterDataBase.sh $1 $2 $3 './temporaryFolder/filesGeneratedAfterExtraction' $4 $5 $6
}

#Declaration of Functions#

mkdir -p temporaryFolder/filesGeneratedAfterExtraction

echo $(pwd)
cp -r $repositoryPath/. $repositoryAtual/temporaryFolder; 

cd $repositoryAtual/temporaryFolder/ && $(git log --reverse --format="%H %ci" > historyCommits.txt)
echo $(pwd)

hashCommit=$(head -n 1 historyCommits.txt | awk '{print $1}')
dateCommit=$(head -n 1 historyCommits.txt | awk '{print $2}')
dateAfter=$dateCommit
$(mv historyCommits.txt ../) && cd ../

while read f1 f2
 do
  if [[ $dateCommit < $(echo $f2 | awk '{print $1}') ]]; then
   cd temporaryFolder/
   $(git checkout $hashCommit)
   cd ../
   extractVocabularyFromThisVersion ./temporaryFolder
   saveVocabularyWithinTheDatabase $user $password $myDb $dateCommit $dateAfter $hashCommit
   dateAfter=$dateCommit
  fi
hashCommit=$f1
dateCommit=$(echo $f2 | awk '{print $1}') 
done < historyCommits.txt
rm -rf ./temporaryFolder/










