FROM vicamo/android-pdk:trusty-openjdk-8

ARG USERNAME
ARG USERID
ARG KVMGID

RUN apt-get update --quiet --quiet \
	&& apt-get install --no-install-recommends --yes \
		uuid uuid-dev \
		zlib1g-dev liblz-dev \
		liblzo2-2 liblzo2-dev \
		lzop \
		git-core curl \
		u-boot-tools \
		mtd-utils \
		android-tools-fsutils \
		openjdk-8-jdk \
	&& apt-get install --no-install-recommends --yes \
		bc \
		kmod \
		rsync

RUN apt-get update --quiet --quiet \
	&& apt-get install --no-install-recommends --yes \
		bash-completion \
		sudo \
		time

RUN useradd --comment 'Android Development Account' \
		--home /home/${USERNAME} --no-create-home \
		--shell /bin/bash \
		--uid ${USERID} \
		${USERNAME} \
	&& (echo "${USERNAME}:${USERNAME}" | chpasswd) \
	&& adduser ${USERNAME} audio \
	&& adduser ${USERNAME} video \
	&& (if [ -n "${KVMGID}" ]; then \
		addgroup --system --gid ${KVMGID} kvm \
			&& adduser ${USERNAME} kvm; \
	fi) \
	&& adduser ${USERNAME} sudo \
	&& (echo "${USERNAME} ALL=NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}) \
	&& chmod 0440 /etc/sudoers.d/${USERNAME}

WORKDIR /home/${USERNAME}
User ${USERNAME}
ENV USER=${USERNAME}
