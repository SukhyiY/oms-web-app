FROM maven:3.6-jdk-8-alpine as builder
COPY . /usr/src/maven
WORKDIR /usr/src/maven

RUN mvn clean install -Dhibernate_url=$DB_URL -Dhibernate_username=$DB_USER -Dhibernate_password=$DB_PSWD -f /usr/src/maven && mkdir /usr/src/wars/
RUN find /usr/src/maven/ -iname '*.war' -exec cp {} /usr/src/wars/ \;

FROM tomcat:8.5.38-jre8-alpine
COPY --from=builder /usr/src/wars/* /usr/local/tomcat/webapps/
EXPOSE 8080
