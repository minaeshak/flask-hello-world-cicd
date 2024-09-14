# Alpine base image for minimizing image size

FROM python:3.10-alpine

WORKDIR /app

# Run as non root
USER 1000

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

ENV FLASK_APP=app.py

CMD ["flask", "run", "--host=0.0.0.0"]
