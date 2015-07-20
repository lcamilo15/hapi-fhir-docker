FROM tomcat
MAINTAINER Luis Camilo <lcamilo15@gmail.com>

LABEL DESCRIPTION="TOMCAT HAPI-FHIR Test server"

#UPDATE PMS AND INSTALL NEEDED APPS
RUN apt-get update -y \
    && apt-get install -y vim \
    && apt-get install -y curl

RUN mkdir -p /usr/local/tomcat/conf/Catalina/localhost \
    && mkdir -p /var/lib/hapi \
    && curl -o /var/lib/hapi/hapi-fhir-jpaserver.war https://lcamilo15.github.io/releases/hapi-fhir/v1.0/hapi-fhir-jpaserver-v1.0.war \
    && rm -r /usr/local/tomcat/webapps

ADD hapi-fhir-jpaserver.xml  /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml

EXPOSE 8080

