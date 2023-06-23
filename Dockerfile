# Use an image that already has Python and pip installed, reducing the need for extra installations
FROM python:3.9-alpine

# Update and install only the necessary dependencies, and then clean up to save space
RUN apk add --no-cache openssl ca-certificates openssh-client \
    && apk add --no-cache --virtual build-deps gcc musl-dev libffi-dev openssl-dev make

# Install Python libraries and Ansible, and then remove unnecessary build dependencies
RUN pip install --upgrade pip python-keyczar docker-py ansible \
    && apk del build-deps

# Create a directory for Ansible playbook and set it as the working directory
WORKDIR /ansible

# Creating a non-root user and switch to it
RUN adduser -D ansible
USER ansible

ENTRYPOINT ["ansible-playbook"]
