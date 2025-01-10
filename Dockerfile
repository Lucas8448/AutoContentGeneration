FROM python:3.10.14-slim

RUN apt update && \
    apt-get install -y ffmpeg && \
    apt install python3-pip -y

RUN mkdir /app
WORKDIR /app

RUN pip install --no-cache-dir "pydantic>=1.9.2,<2.0.0"

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python3", "main.py"]