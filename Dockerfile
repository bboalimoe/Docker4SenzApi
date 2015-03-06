FROM texastribune/supervisor
MAINTAINER tech@texastribune.org

RUN apt-get -yq install nginx
# There's a known harmless warning generated here:
# See https://github.com/benoitc/gunicorn/issues/788
RUN pip install gunicorn==19.1.1
RUN pip install Django

####TODO
# 1.every service should add the dependency to the requirements.txt
# 2.ADD /SERVICE_PROJECT/ /IMAGE/app/
# 3.link the gunicorn to the wsgi
# 4.run the gunicorn
# the parent image creates this directory (along with /app/logs)
# 5.ADD spider.supervisor.conf /etc/supervisor/conf.d

####TODO

WORKDIR /app
RUN echo 1

# TOOD: move this to ancestor image?
RUN mkdir /app/run

ADD gunicorn_conf.py /app/
ADD gunicorn.supervisor.conf /etc/supervisor/conf.d/

ADD nginx.conf /app/
ADD nginx.supervisor.conf /etc/supervisor/conf.d/

VOLUME ["/app/logs"]
EXPOSE 8000
