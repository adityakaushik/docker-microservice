FROM maven:3.6.3-jdk-8 AS buildimg
WORKDIR /build
COPY gs-rest-service-master .
RUN mvn clean install

FROM openjdk:8-jre-alpine
WORKDIR /app
VOLUME /app/logs
COPY --from=buildimg /build/target/rest-service-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "rest-service-0.0.1-SNAPSHOT.jar","--logging.file.name=/app/logs/rest-service.log"]
