#!/bin/bash

# Create a directory to store the generated SSL certificates
mkdir -p certs

# Generate a self-signed RSA-4096 SSL certificate and private key valid for 365 days
openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 365 -out certs/domain.crt

# Create a Docker secret for the SSL certificate
docker secret create revprox_cert certs/domain.crt

# Create a Docker secret for the SSL private key
docker secret create revprox_key certs/domain.key

# Create a Docker secret for the PostgreSQL database password
echo -n "gordonpass" | docker secret create postgres_password -

# Create a Docker secret for the staging token using inline text input
echo -n "staging" | docker secret create staging_token -
