# Start from Alpine Base Image 
FROM alpine:latest

# Add New User to Run App from Him
RUN adduser -D paymentuser

# Create & Change Current Working Directory to "/app"
WORKDIR /app

# Copy All Files to Current Working Directory 
COPY ./ ./

# Give User Permissions on Working Directory
RUN chown -R paymentuser:paymentuser /app

# Change User from Root to New User
USER paymentuser

# The Command Run in the Startup of Application
CMD ["sh" , "process.sh"]
