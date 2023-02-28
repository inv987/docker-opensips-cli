FROM python:3.9-slim-bullseye
LABEL maintainer="Razvan Crainea <razvan@opensips.org>"

USER root

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

#install basic components
RUN apt-get -y update -qq && apt-get -y install gnupg2 ca-certificates

#add keyserver, repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 049AD65B
RUN echo "deb https://apt.opensips.org bullseye cli-nightly" >/etc/apt/sources.list.d/opensips-cli.list \
    && apt-get -y update -qq && apt-get -y install opensips-cli

ADD "run.sh" "/run.sh"

ENV PYTHONPATH /usr/lib/python3/dist-packages

ENTRYPOINT ["/run.sh", "-o", "communication_type=http"]
