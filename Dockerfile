# Use an official Maven image as base
FROM maven:3.8.6-openjdk-11 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build Maven project
RUN mvn clean package

# Use Tomcat as a runtime environment
FROM tomcat:9.0

# Copy built .war file from previous stage
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/app.war

# Expose the port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
