
FROM python:3.10

ARG version

RUN pip install flask
RUN pip install requests

COPY generator-v${version}.py /generator.py

CMD ["python3", "generator.py"]
