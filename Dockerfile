# Stage 1: Build
FROM maven:3.9-eclipse-temurin-24 AS builder

WORKDIR /app

# Copy the project files
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:24-jdk

WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/spring-petclinic-*.jar app.jar

# Expose the port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
