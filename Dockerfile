FROM maven:3.6-jdk-8-alpine as builder
COPY . /usr/src/mymaven
WORKDIR /usr/src/mymaven

ARG DB_URL=jdbc:mysql://10.26.34.95:3333/lv378oms
ARG DB_USER=root
ARG DB_PSWD=132465798

RUN echo $DB_URL

RUN mvn clean install -Dhibernate_url=$DB_URL -Dhibernate_username=$DB_USER -Dhibernate_password=$DB_PSWD -f /usr/src/mymaven && mkdir /usr/src/wars/
RUN find /usr/src/mymaven/ -iname '*.war' -exec cp {} /usr/src/wars/ \;

FROM tomcat:8.5.38-jre8-alpine
COPY --from=builder /usr/src/wars/* /usr/local/tomcat/webapps/
EXPOSE 8080
