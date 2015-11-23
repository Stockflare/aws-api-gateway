#!/bin/bash
SEP="==================="

confd -onetime -backend env

echo "Wrote swagger config..."
echo $SEP
cat /data/swagger.yaml
echo $SEP
# java -jar /aws-apigateway-importer.jar "$@"
java -jar /aws-apigateway-importer.jar --create /data/swagger.yaml
