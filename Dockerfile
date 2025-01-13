# Use the official slim Python base image
FROM python:3.13-slim-bookworm

# Update and install only the necessary build tools and dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        libffi-dev \
        libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Switch to the non-root user
USER appuser

# Upgrade pip and install dependencies with precompiled wheels only
COPY requirements.txt ./
RUN pip install --no-cache-dir spacy[transformers]==3.6.0 && \
    python -m spacy download en_core_web_sm
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --only-binary :all: -r requirements.txt

# Copy the application code
COPY . .

# Set the entry point for the container
CMD ["python3", "main.py"]