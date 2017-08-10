FROM vicamo/android-pdk:xenial-openjdk-8

ARG USERNAME
ARG USERID

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
	&& adduser ${USERNAME} sudo \
	&& (echo "${USERNAME} ALL=NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}) \
	&& chmod 0440 /etc/sudoers.d/${USERNAME}

WORKDIR /home/${USERNAME}
User ${USERNAME}
ENV USER=${USERNAME}
