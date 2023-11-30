# Ansible Docker Container

This repository contains a Dockerfile that sets up a lightweight container with Ansible installed. It is based on the python:3.9-alpine image.

The Dockerfile creates a non-root user named ansible, and sets /ansible as the working directory. This is where you should mount your Ansible playbook when you run the container.

# Usage

To run your Ansible playbook in the container, you should mount your ansible directory to /ansible in the container. Here's an example of how to do it using your ssh user and key:

```bash
docker run -it --rm -v $(pwd)/ansible:/ansible -e "TARGET_HOSTS=01.02.03.04" ansible-container /ansible/playbook.yml
```

This one would run the container using your ssh user and key

```bash
docker run -it --rm -v $(pwd)/ansible:/ansible -e "TARGET_HOSTS=01.02.03.04,02.03.04.05" ansible-container /ansible/playbook.yml --extra-vars "ansible_ssh_user=scr1ba ansible_ssh_private_key_file=./.ssh/ed25519"
```

# Directory Structure

The repository is structured as follows, feel free to adapt to your needs. As for the .ssh you can symlink it to your local user

```
ansible/
|-- .ssh/
|   |-- <private ssh key>
|   |-- <public ssh key>
|-- ansible.cfg
|-- inventory.ini
|-- playbook.yml
docker-compose.yml
Dockerfile
README.md
```
