FROM python:3.9-alpine

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt

RUN pip3 install gunicorn

RUN pip3 install psycopg2-binary

EXPOSE 8000

RUN chmod +x /app/app-entrypoint.sh
