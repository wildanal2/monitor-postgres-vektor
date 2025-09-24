FROM postgres:17

# Install pgvector
RUN apt-get update && \
    apt-get install -y postgresql-17-pgvector && \
    rm -rf /var/lib/apt/lists/*

# Default entrypoint dari postgres tetap dipakai
