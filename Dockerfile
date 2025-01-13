FROM python:3.13.1-slim-bookworm

# Update and install necessary packages
RUN apt update && \
    apt-get install -y ffmpeg && \
    apt-get install -y python3-pip && \
    apt-get clean

# Create and set the working directory
RUN mkdir /app
WORKDIR /app

# Install specific Python package
RUN pip install --no-cache-dir "pydantic>=1.9.2,<2.0.0"

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Set the entry point for the container
CMD ["python3", "main.py"]