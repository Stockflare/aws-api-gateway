#!/bin/bash

for i in "$@"
do
  case $i in
      -a=*|--app-id=*)
      APP_ID="${i#*=}"
      shift # past argument=value
      ;;
      -u|--update)
      UPDATE=YES
      shift # past argument with no value
      ;;
      *)
              # unknown option
      ;;
  esac
done
echo "UDPATE  = ${UPDATE}"
echo "APP ID     = ${APP_ID}"

SEP="==================="

confd -onetime -backend env

echo "Wrote swagger config..."
echo $SEP
cat /data/swagger.yaml
echo $SEP



if [ ${UPDATE} = "YES" ]; then
  java -jar /aws-apigateway-importer.jar --update ${APP_ID} /data/swagger.yaml
else
  java -jar /aws-apigateway-importer.jar --create /data/swagger.yaml
fi
