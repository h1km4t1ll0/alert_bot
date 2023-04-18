#!/bin/bash

service nginx start
# database postgresql start
poetry run python3 manage.py collectstatic --noinput
sleep 1
chmod -R u+w /srv/
poetry run python3 manage.py migrate
sleep 1
# chown www-data:www-data /srv/db.sqlite3
poetry run python3 manage.py makemigrations
sleep 1
poetry run python3 manage.py migrate
sleep 1
poetry run python3 manage.py initadmin
sleep 1
/bin/gunicorn3 wsgi:application -b 127.0.0.1:8000 --env DJANGO_SETTINGS_MODULE=settings --user www-data --group www-data
# poetry run python3 manage.py runserver
