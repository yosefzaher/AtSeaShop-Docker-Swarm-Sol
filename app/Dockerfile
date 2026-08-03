################################################################
# First Stage : Build React Front-End
################################################################
# Start From Node.JS Base Image
FROM node:alpine AS front-artifacts

# Create & Change Working Directory to "react-app" 
WORKDIR /react-app

# Copy (package.json ,package-lock.json) to the Working Directory to Install Dependencies
COPY ./react-app/package*.json ./

# Install Project Dependencies
RUN npm install --legacy-peer-deps

# Copy Front-End React Files to Working Directory
COPY ./react-app/ ./

# Build React Project -> The Outputs is in "build" Directory
RUN npm run build
################################################################


################################################################
# Second Stage : Build Java Back-End Project Using Maven 
################################################################
# Start From Maven Base Image
FROM maven:3.9.6-eclipse-temurin-8 AS back-artifacts

# Create & Change Working Directory to "app"
WORKDIR /app

# Copy "pom.xml" File to Working Directory to Install Dependencies Using it
COPY ./pom.xml ./

# Install Project Dependencies
RUN mvn -B -f pom.xml dependency:resolve

# Copy All Project Files to Working Directory
COPY ./ ./

# Clean Harmonies and Build directly (without 'clean' phase)
RUN rm -rf /root/.m2/repository/org/aspectj/aspectjweaver && mvn -B -U package -DskipTests
################################################################


################################################################
# Third Stage : Run Full-Stack Project 
################################################################
# Start From Java 8 Base Image
FROM eclipse-temurin:8-jdk-alpine

# Create New User to Run App from it
RUN adduser -D urunapp 

# Create & Change Working Directory to "static"
WORKDIR /static

# Copy the Output Artifacts from First Stage to the Working Directory
COPY --from=front-artifacts /react-app/build/ ./

# Create & Change Working Directory to "app"
WORKDIR /app

# Copy the Output Artifacts from Second Stage to the Working Directory
COPY --from=back-artifacts /app/target/AtSea-0.0.1-SNAPSHOT.jar ./

# Give New User Read&Write Permissions on Artifacts
RUN chown -R urunapp:urunapp /app /static

# Change Current User from Root to New User 
USER urunapp

# Command Run on the Startup of Container -> "Run Java App"
ENTRYPOINT ["java" , "-jar" , "/app/AtSea-0.0.1-SNAPSHOT.jar"]
CMD ["--spring.profiles.active=postgres"]
################################################################
