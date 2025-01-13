FROM python:3.13.1-slim-bookworm

RUN apt update && \
    apt-get install -y ffmpeg && \
    apt install python3-pip -y

RUN mkdir /app
WORKDIR /app

RUN pip install --no-cache-dir "pydantic>=1.9.2,<2.0.0"

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

COPY . .

CMD ["python3", "main.py"]