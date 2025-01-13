FROM python:3.13.1-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        build-essential \
        python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir "pydantic>=1.9.2,<2.0.0" && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python3", "main.py"]