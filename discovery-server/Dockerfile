# Use OpenJDK 17 base image
FROM openjdk:17-jdk-slim

# Add a label (optional)
LABEL maintainer="Naresh"

# Set the working directory
WORKDIR /app

# Copy the JAR file from target directory to the container
COPY target/discovery-server-*.jar discovery-server.jar

# Expose the Eureka server default port
EXPOSE 8761

# Run the application
ENTRYPOINT ["java", "-jar", "discovery-server.jar"]
