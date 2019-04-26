FROM python:3.6.7


# Set PYTHONUNBUFFERED so the output is displayed in the Docker log
ENV PYTHONUNBUFFERED=1


COPY /ChatApp/ /usr/src/chatapp
# Copy the rest of the applicaion's code
COPY /ChatApp/requirements.txt /usr/src/chatapp/


WORKDIR /usr/src/chatapp/


# Install dependencies
RUN apt-get update
RUN pip3 install -r requirements.txt
RUN pip3 install Django==2.1.3
RUN pip3 install django-widget-tweaks==1.4.1
RUN pip3 install djangorestframework==3.7.3
RUN pip3 install pytz==2017.3
RUN pip3 install python3-memcached
RUN pip3 install django bcrypt django-extensions
RUN apt-get install python3-dev -y
RUN apt-get install python-dev default-libmysqlclient-dev -y
RUN pip install mysqlclient


# Run the app
COPY start.sh /usr/src/chatapp/
CMD ["./start.sh"]


EXPOSE 8000
