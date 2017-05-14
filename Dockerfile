FROM node:7.10-alpine

MAINTAINER Eric Maicon

RUN apk update
RUN apk add --no-cache ca-certificates build-base wget zlib python curl openssl
RUN update-ca-certificates
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install awscli

ENV DOCKER_SHA256_x86_64 340e0b5a009ba70e1b644136b94d13824db0aeb52e09071410f35a95d94316d9
ENV DOCKER_SHA256_armel 59bf474090b4b095d19e70bb76305ebfbdb0f18f33aed2fccd16003e500ed1b7

RUN set -ex; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64) dockerArch=x86_64 ;; \
		armhf) dockerArch=armel ;; \
		*) echo >&2 "error: unknown Docker static binary arch $apkArch"; exit 1 ;; \
	esac; \
	curl -fSL "https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz" -o docker.tgz; \
	sha256="DOCKER_SHA256_x86_64"; sha256="$(eval "echo \$${sha256}")"; \
	echo "${sha256} *docker.tgz" | sha256sum -c -; \
	tar -xzvf docker.tgz; \
	mv docker/* /usr/local/bin/; \
	rmdir docker; \
	rm docker.tgz; \
	docker -v

CMD ["aws"]