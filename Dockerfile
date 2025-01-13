FROM python:3.13.1-slim-bookworm

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        g++ \
        libffi-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        ffmpeg \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create and set the working directory
WORKDIR /app

# Upgrade pip
RUN pip install --upgrade pip

# Install specific Python package
RUN pip install --no-cache-dir "pydantic>=1.9.2,<2.0.0"

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Set the entry point for the container
CMD ["python3", "main.py"]