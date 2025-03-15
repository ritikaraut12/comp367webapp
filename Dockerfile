 # Use Tomcat as the base image
FROM tomcat:9.0

# Set working directory inside container
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file from the target folder (Ensure `mvn package` is run before this)
COPY target/*.war app.war

# Expose port 8080 for the application
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
