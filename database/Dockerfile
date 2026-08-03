# Start From Postgres Base Image
FROM postgres:9.6

# Copy Init & Config Files into Image 
COPY ./docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/
COPY ./postgresql.conf /usr/share/postgresql/9.6/
COPY ./pg_hba.conf /usr/share/postgresql/9.6/

# Default Values for Passwords and Database Name. Can be Overridden on "docker run"
ENV POSTGRES_USER gordonuser
ENV POSTGRES_DB atsea
