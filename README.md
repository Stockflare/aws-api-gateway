# Stockflare AWS API Gateway

This project contains a http://swagger.io/ description of the Stockflare AWS API Gateway implementation.

The base API description is found in the template file `etc/confd/templates/swagger.yaml.tmpl`.  This contains a number of environment variable substitutions made prior to the upload to AWS.  https://github.com/kelseyhightower/confd is used to make the substitutions.

The configured YAML file is uploaded to AWS using https://github.com/Stockflare/aws-apigateway-importer

A `Dockerfile` creates a container that includes `confd` and `aws-apigateway-importer`.

## Required Environment Variables
| Variable      | Example      | Purpose                                                                 |
|:--------------|:-------------|:------------------------------------------------------------------------|
| HOSTED_ZONE   | stocktio.com | The Hosted zone to which http backend integration requests will be sent |
| HTTP_PROTOCOL | http / https | The protocol used for back end integration requests                     |

## Developing and uploading an API
* All api development is coded in `etc/confd/templates/swagger.yaml.tmpl`
* use `aws configure` to set up authentication to the correct AWS account
* replace the .env file with the values required for the target environment
* Build the Docker container with `compose build importer`
* upload the API with `compose run importer`

## Updating an existing API

```
compose run importer --update --app-id=<app_id>
```

When in the API Gateway console you can find the APP_ID in the URL

```
https://console.aws.amazon.com/apigateway/home?region=us-east-1#/restapis/xwivffe5jh/resources/vcy1o1/methods/PUT
```

The APP_ID in the case is `xwivffe5jh`
