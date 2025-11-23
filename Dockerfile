# Etapa 1: Build
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copiar todo el código fuente
COPY . .

# Compilar sin ejecutar tests
RUN mvn -q -DskipTests package

# Etapa 2: Runtime
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copiar el JAR compilado
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# Comando de inicio
ENTRYPOINT ["java", "-jar", "app.jar"]
