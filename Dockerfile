FROM python:3.10-buster
# ENV PATH="/root/.local/bin:$PATH"
# ENV POETRY_VERSION="1.3.2"

RUN apt update -y &&  apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y nginx python3 python3-pip gunicorn sudo nano postgresql-contrib libpq-dev
COPY .. /srv/telegram_admin
WORKDIR /srv/telegram_admin
RUN pip3 install -r requirements.txt && cp /srv/telegram_admin/nginx.conf /etc/nginx/sites-available/default
RUN chown -R www-data:www-data /srv && chmod +x /srv/telegram_admin/run.sh && chmod +x /srv

# RUN curl -sSL https://install.python-poetry.org | POETRY_VERSION=$POETRY_VERSION python3 - && \
#     poetry --version && \
#     poetry install --no-root

# EXPOSE 88:88
# ENTRYPOINT /srv/telegram_admin/run.sh
