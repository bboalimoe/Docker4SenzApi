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


####TODO

WORKDIR /app
RUN echo 1

# TOOD: move this to ancestor image?
RUN mkdir /app/run
RUN mkdir /app/djangoapp
#add the project to the /app/
ADD djangoapp/ /app/djangoapp
ADD gunicorn_conf.py /app/
ADD gunicorn.supervisor.conf /etc/supervisor/conf.d/

ADD nginx.conf /app/
ADD nginx.supervisor.conf /etc/supervisor/conf.d/


ADD spider.supervisor.conf /etc/supervisor/conf.d/

#Replace the project /app/ with your project name
RUN export PYTHONPATH=/app/djangoapp/
# this setting disappears when the session end

VOLUME ["/app/logs"]
EXPOSE 9010
