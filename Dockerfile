FROM rassaifred/screenly-ose-baseimage
MAINTAINER rassaifred


# Install Python requirements
ADD requirements.txt /tmp/requirements.txt

RUN [ "cross-build-start" ]

RUN curl -s https://bootstrap.pypa.io/get-pip.py | python && \
    pip install --upgrade -r /tmp/requirements.txt

# Setup nginx
RUN rm /etc/nginx/sites-enabled/default

RUN [ "cross-build-end" ]

COPY ansible/roles/ssl/files/nginx_resin.conf /etc/nginx/sites-enabled/screenly.conf

COPY ansible/roles/screenly/files/gtkrc-2.0 /data/.gtkrc-2.0

COPY . /tmp/screenly

CMD ["bash", "chmod 777 /dev/vchiq"]
CMD ["bash", "/tmp/screenly/bin/start_balena.sh"]