FROM maven:3-jdk-8

LABEL Description="Tools to work with Amazon API Gateway, Swagger, and RAML"

COPY docker-entrypoint.sh /
COPY pom.xml /app/
COPY src /app/src/
COPY tst /app/tst/

ADD etc/confd /etc/confd

ADD bin/confd-0.10.0-linux-amd64 /bin/confd

WORKDIR /app

RUN mvn assembly:assembly \
    && mv build/maven/aws-apigateway-*-jar-with-dependencies.jar /aws-apigateway-importer.jar \
    && mvn clean

VOLUME ["/root/.aws"]
VOLUME ["/data"]
VOLUME ["/etc/confd/templates"]

WORKDIR /data

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--help"]
