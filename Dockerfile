# Passo 1: Usa uma imagem oficial do Maven com Java 17 para compilar o projeto
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Passo 2: Cria uma imagem ultra leve que contém apenas o Java 17 para rodar o sistema
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]