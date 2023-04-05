# Pull base image
FROM ubuntu:20.04 as web

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt update
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt update
RUN apt -y install python3.8 python3-pip libapr1 libapr1-dev libaprutil1-dev libapache2-mod-wsgi apt-utils vim curl apache2 apache2-utils

# Set work directory
WORKDIR /code

# Install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Copy project
COPY . .

ADD ./site-config.conf /etc/apache2/sites-available/000-default.conf
EXPOSE 80 3500 
CMD ["apache2ctl", "-D", "FOREGROUND"]


#RUN apt-get install -y apt-utils vim curl apache2 apache2-utils RUN apt-get -y install python3 libapache2-mod-wsgi-py3 
#RUN ln /usr/bin/python3 /usr/bin/python 
#ADD ./site-config.conf /etc/apache2/sites-available/000-default.conf ADD ./requirements.txt /var/www/html 
#WORKDIR /var/www/html 
#RUN chmod 664 /var/www/html/{ your-site-name }/db.sqlite3 
#RUN chmod 775 /var/www/html/{ your-site-name }/{ your-site-name } RUN chmod 775 /var/www/html/{ your-site-name }/logs 
#RUN chown :www-data /var/www/html/{ your-site-name }/db.sqlite3 
#RUN chown :www-data /var/www/html/{ your-site-name }/{ your-site-name } 
#RUN chown :www-data /var/www/html/{ your-site-name }/logs 
