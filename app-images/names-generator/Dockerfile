
FROM python:3.10

ARG version

RUN pip install flask
RUN pip install requests

COPY names_generator_v${version}.py /names_generator.py

CMD ["python3", "/names_generator.py"]
