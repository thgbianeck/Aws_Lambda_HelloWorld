@echo off
REM echo ### Configurando profile localstack
REM aws configure
REM aws configure --profile localstack
echo ### Criando IAM Role para execucao da Lambda no LocalStack...
aws --endpoint http://localhost:4566 --profile localstack iam create-role --role-name lambda-execution --assume-role-policy-document "{\"Version\": \"2012-10-17\",\"Statement\": [{ \"Effect\": \"Allow\", \"Principal\": {\"Service\": \"lambda.amazonaws.com\"}, \"Action\": \"sts:AssumeRole\"}]}"

echo ### Criando Policy de execucao da Lambda no LocalStack...
aws --endpoint http://localhost:4566 --profile localstack iam attach-role-policy --role-name lambda-execution --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

echo ### mvn clean package
cd ..
mvn clean install -DskipTests

echo ### Implantando Lambda no LocalStack...
REM  cd target
REM  aws --endpoint http://localhost:4566 --profile localstack lambda create-function --function-name HelloWorld --zip-file fileb://HelloWorld-1.0.jar --handler helloworld.App --runtime java11 --role arn:aws:iam::000000000000:role/lambda-execution

echo ### Executando Lambda no LocalStack...
REM  aws --endpoint http://localhost:4566 --profile localstack lambda invoke --function-name HelloWorld out.txt --log-type Tail
