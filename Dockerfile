# Use a more stable Python version
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    libpq-dev \
    gcc \
    python3-pip \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install dbt directly (no virtual environment)
RUN pip install --upgrade pip && \
    pip install \
        'protobuf>=3.20.0,<3.21.0' \
        'grpcio>=1.47.0,<1.48.0' \
        'dbt-core==1.5.0' \
        'dbt-postgres==1.5.0'

# Copy project files
COPY . .

# Create profiles directory and add profiles.yml
RUN mkdir -p /root/.dbt && \
    echo "sales_dbt_project:\n\
  target: dev\n\
  outputs:\n\
    dev:\n\
      type: postgres\n\
      host: postgres\n\
      user: dbt\n\
      password: dbt\n\
      port: 5432\n\
      dbname: dbt_database\n\
      schema: public\n\
      threads: 4" > /root/.dbt/profiles.yml

# Verify installation
RUN dbt --version

# Add dbt commands to entrypoint
ENTRYPOINT ["bash", "-c", "\
    dbt debug && \
    dbt run && \
    exec bash \
"]