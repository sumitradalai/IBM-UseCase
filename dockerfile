FROM openjdk:17-jdk-slim
WORKDIR /app
COPY pom.xml .
COPY target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
