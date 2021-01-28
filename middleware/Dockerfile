FROM python:3.6-slim
COPY ./app.py /deploy/
COPY ./requirements.txt /deploy/
COPY ./foresight_trained.h5 /deploy/
WORKDIR /deploy/
RUN pip install --no-cache-dir tensorflow tensorflow==2.4.1
RUN pip install -r requirements.txt
EXPOSE 80
ENTRYPOINT ["python", "app.py"]
