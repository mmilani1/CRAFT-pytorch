FROM continuumio/miniconda3:latest

ARG FLASK_ENV='production'
ENV FLASK_ENV $FLASK_ENV
ENV FLASK_APP '/app/app.py'

WORKDIR /app

ADD . /app

RUN conda env create -f /app/requirements-cpu.yml

CMD ["conda", "run", "--no-capture-output", "-n", "craft-detector", "flask", "run", "--host=0.0.0.0", "--port=$PORT"]
