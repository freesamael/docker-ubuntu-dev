FROM ubuntu:bionic

ARG USERNAME
ARG USERID
ARG KVMGID

RUN apt-get update --quiet --quiet \
	&& apt-get install --no-install-recommends --yes \
		build-essential \
		bash-completion \
		python2.7-dev \
		python-pip \
		python3-dev \
		python3-pip \
		sudo \
		time \
		git

RUN useradd --comment 'Development Account' \
		--home /home/${USERNAME} --no-create-home \
		--shell /bin/bash \
		--uid ${USERID} \
		${USERNAME} \
	&& (echo "${USERNAME}:${USERNAME}" | chpasswd) \
	&& adduser ${USERNAME} audio \
	&& adduser ${USERNAME} video \
	&& (if [ -n "${KVMGID}" -a "${KVMGID}" != "0" ]; then \
		addgroup --system --gid ${KVMGID} kvm \
			&& adduser ${USERNAME} kvm; \
	fi) \
	&& adduser ${USERNAME} sudo \
	&& (echo "${USERNAME} ALL=NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}) \
	&& chmod 0440 /etc/sudoers.d/${USERNAME}

WORKDIR /home/${USERNAME}
User ${USERNAME}
ENV USER=${USERNAME}

