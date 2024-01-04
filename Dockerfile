# Docker image for flask python run

FROM python:3.11

WORKDIR /project

COPY . .

# RUN apt-get update -y

RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee -a /etc/apt/trusted.gpg.d/microsoft.asc

RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | tee -a /etc/apt/sources.list.d/mssql-release.list

RUN chmod +rwx /etc/ssl/openssl.cnf
RUN sed -i 's/TLSv1.2/TLSv1/g' /etc/ssl/openssl.cnf
RUN sed -i 's/SECLEVEL=2/SECLEVEL=1/g' /etc/ssl/openssl.cnf

RUN ACCEPT_EULA=Y apt-get install msodbcsql18 -y
RUN apt-get install unixodbc-dev -y

EXPOSE 80

RUN pip install -r requirements.txt

CMD [ "python","./main.py" ]
