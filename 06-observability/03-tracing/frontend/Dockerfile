# === Build stage ===
FROM gradle:8.8-jdk21 AS build
WORKDIR /src
COPY gradlew ./
COPY gradle ./gradle
COPY settings.gradle ./
COPY app ./app
RUN chmod +x gradlew && ./gradlew --no-daemon clean bootJar

# === Runtime stage ===
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /src/app/build/libs/app.jar /app/app.jar
EXPOSE 8080
RUN addgroup -S spring && adduser -S spring -G spring
USER spring
ENTRYPOINT ["sh","-c","java -jar app.jar"]

