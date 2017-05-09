# Vocabulary Monitor

Vocabulary Monitor é um conjunto de Shell Scripts e blibliotecas java para extrair o vocabulário do software através de duas abordagens: Uma contínua através do servidor de integração Jenkins e uma histórica através do histórico de commits de projetos que usam o Git como controle de versão.

O Vocabulary Monitor surgiu através de um trabalho de conclusão de curso que será disponibilizado no futuro.

# Componentes Do Vocabulary Monitor

  - **Initializer:** Componente que cria o banco de dados, tabelas e procedures necessários para armazenar o vocabulário extraído;
 - **VocabularyExtractor:** Varre o código fonte de projetos Java extraíndo seu vocabulário;
 - **TermsCounter:** Gera uma matriz de frequência de termos por entidades;
 - **ReviewingHistory:** Um Shell Script responsável por acessar todos os snapshots contidos
em um projeto e permitido a extração do vocabulário pelo VocabularyExtractor.
Usamos apenas o último snapshot de um dia para a extração;
 - **Monitor:** Possibilita a extração do vocabulário em repositórios monitorados pelo Jenkins
utilizando o mesmo critério de extração apresentado no ReviewingHistory;
 - **WriterDataBase:** Sua função é salvar o vocabulário extraído pelo VocabularyExtractor
dentro de uma banco de dados e referenciar esses dados a uma data (a data
que ocorreu a extração) e executar stored procedures.



# Requisitos Para Uso do Vocabulary Monitor

É necessário possuir o Mysql ou MariaDB instalado e de preferência um usuário com acesso ao banco. O Vocabulary Monitor usa uma base de dados para guardar o vocabulário extraído.

É preciso a JVM para que seja possível executar as bibliotecas java.

É preciso possuir o Git instalado.

É necessário executar Initializer antes de executar Vocabulary Monitor para a criação da base de dados, tabelas e stored procedures.


# Executando Monitor.sh

Monitor irá ser executado pelo Jenkins no processo de build de projetos, para isso é necessário inserí-lo como um passo de build no Jenkins. Sua forma de execução é:

```sh
$ Monitor.sh database path
```
| Argumento | Significado |
| ------ | ------ |
| database | Base de dados que será alimentada com o vocabulário extraído; |
| repositorypath | Caminho para o Vocabulary Monitor no seu computador.|

Antes de inserir Monitor ao Jenkins é necessário preencher um arquivo chamado Monitor.txt que se encontra dentro da pasta do Vocabulary MOnitor. Dentro do arquivo existe instruções de como preenchê-lo.

# Executando ReviewingHistory.sh
ReviewingHistory é executado via linha de comando e sua sintaxe de execução comando é:

```sh
$ ./ReviewingHistory name password database repositorypath"
```
| Argumento | Significado |
| ------ | ------ |
| name |  Nome do usuário com acesso ao banco de dados; |
| password | Senha do usuário (ReviewingHistory não armazenará sua senha); |
| database | Base de dados que será alimentada com o vocabulário extraído; |
| repositorypath | Caminho para o diretório do projeto alvo da extração.|


# Contato

Dúvidas ou sugestões são bem vindas =), estou a disposição para conversar sobre outros projetos e novas tecnologias =).
Email para contato : anderson.allan.sobral@gmail.com



 


