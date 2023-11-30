FROM python:3.9-alpine

RUN apk add --no-cache openssl ca-certificates openssh-client \
    && apk add --no-cache --virtual build-deps gcc musl-dev libffi-dev openssl-dev make bash \
    && pip install --upgrade pip python-keyczar docker-py ansible && apk del build-deps

WORKDIR /ansible

COPY ansible/ansible.cfg /ansible/ansible.cfg
COPY ansible/playbook.yml /ansible/playbook.yml
COPY ansible/inventory.ini /ansible/inventory.ini

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
