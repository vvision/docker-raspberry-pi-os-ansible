# Raspberry Pi OS Ansible Test Image

[![CI](https://github.com/vvision/docker-raspberry-pi-os-ansible/workflows/Build/badge.svg?branch=master&event=push)](https://github.com/vvision/docker-raspberry-pi-os-ansible/actions?query=workflow%3ABuild)
[![Docker pulls](https://img.shields.io/docker/pulls/vv1s10n/docker-raspberry-pi-os-ansible)](https://hub.docker.com/r/vv1s10n/docker-raspberry-pi-os-ansible/)

Raspberry Pi OS Docker container for Ansible playbook and role testing.

Inspired by [geerlingguy/docker-debian10-ansible](https://github.com/geerlingguy/docker-debian10-ansible).

## Tags

- `latest`: Latest stable version of Ansible, with Python 3.x.

## How to Build

This image is built on Docker Hub automatically any time the upstream OS container is rebuilt,
and any time a commit is made or merged to the `master` branch.
But if you need to build the image on your own locally, do the following:

1. [Install Docker](https://docs.docker.com/engine/installation/).
2. `cd` into this directory.
3. Read and execute `sudo ./img_to_tar.sh`.
4. Run `docker build -t raspberrypi-os-ansible .`

> Note:
> Switch between `master` and `testing` depending on whether you want the extra testing tools present in the resulting image.

## How to Use

1. [Install Docker](https://docs.docker.com/engine/installation/).
2. Install ``qemu-user-static``, when not running from docker on a Raspberry Pi.
3. Pull this image from Docker Hub: `docker pull vv1s10n/docker-raspberry-pi-os-ansible:latest` (or use the image you built earlier, e.g. `raspberrypi-os-ansible`).
4. Run a container from the image: `docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro vv1s10n/docker-raspberry-pi-os-ansible:latest`
(to test my Ansible roles, I add in a volume mounted from the current working directory with ``--volume=`pwd`:/etc/ansible/roles/role_under_test:ro``).
5. Use Ansible inside the container:
   a. `docker exec --tty [container_id] env TERM=xterm ansible --version`
   b. `docker exec --tty [container_id] env TERM=xterm ansible-playbook /path/to/ansible/playbook.yml --syntax-check`

## Notes

I use Docker to test my Ansible roles and playbooks on multiple OSes using CI tools like GitHub Actions.
This container allows me to test roles and playbooks using Ansible running locally inside the container.

> **Important Note**:
> I use this image for testing in an isolated environment —not for production—
> and the settings and configuration used may not be suitable for a secure and performant production environment.
> Use on production servers/in the wild at your own risk!

## Author

Created in 2021 by Victor Voisin.
