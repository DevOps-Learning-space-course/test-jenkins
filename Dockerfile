FROM openjdk:8u111-jdk-alpine
ADD ./target/*.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
