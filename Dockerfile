FROM vicamo/android-pdk:xenial-openjdk-8

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
