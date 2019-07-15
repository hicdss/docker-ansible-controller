FROM alpine:latest

ARG ANSIBLE_VERSION=2.8.1-r0
ARG ANSIBLE_LINT_VERSION=4.1.0

ARG ANSIBLE_INVENTORY=/etc/ansible/hosts
ARG ANSIBLE_HOST_KEY_CHECKING=False
ARG ANSIBLE_DIFF_ALWAYS=True
ARG ANSIBLE_SSH_ARGS='-C -o ControlMaster=auto -o ControlPersist=60s'

ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ENV ANSIBLE_LINT_VERSION=${ANSIBLE_LINT_VERSION}

ENV ANSIBLE_HOST_KEY_CHECKING=${ANSIBLE_HOST_KEY_CHECKING}
ENV ANSIBLE_DIFF_ALWAYS=${ANSIBLE_DIFF_ALWAYS}
ENV ANSIBLE_SSH_ARGS=${ANSIBLE_SSH_ARGS}
ENV ANSIBLE_INVENTORY=${ANSIBLE_INVENTORY}

RUN apk add --update --no-cache \
		ansible==${ANSIBLE_VERSION} \
		bash \
		openssh \
		make \
		py-pip \
		git \
	&& apk add --no-cache --virtual .build-deps \
	    gcc \
	    libc-dev \
	    openssl-dev \
	    python-dev \
            libffi-dev \
	&& pip install --no-cache-dir ansible-lint==${ANSIBLE_LINT_VERSION} \
	&& apk del .build-deps \
	&& rm -rf ~/.cache/

CMD ["/bin/bash"]
