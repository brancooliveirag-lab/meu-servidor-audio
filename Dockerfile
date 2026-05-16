FROM maven:3.8.6-openjdk-17-slim
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests
CMD ["java", "-jar", "target/meuaudioapp-1.0.0.jar"]