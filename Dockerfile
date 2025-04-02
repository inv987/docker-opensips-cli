FROM ubuntu:24.04
LABEL maintainer="inv987"

# Set Environment Variables
#ENV DEBIAN_FRONTEND noninteractive

#install basic components
RUN apt-get -y update -qq && \
    apt-get -y dist-upgrade && \
    apt-get -y install git default-libmysqlclient-dev gcc python3-full python3-setuptools python3-distutils-extra python3-pip python3-mysqldb python3-psycopg2

#add keyserver, repository
RUN git clone https://github.com/OpenSIPS/opensips-cli.git /usr/src/opensips-cli && \
    cd /usr/src/opensips-cli && \
    pip install --break-system-packages . && \
    cd / && rm -rf /usr/src/opensips-cli

RUN apt-get purge -y git gcc rpcsvc-proto python3-setuptools curl && \
    apt-get autoremove -y && \
    apt-get clean

ADD "run.sh" "/run.sh"

ENV PYTHONPATH /usr/lib/python3/dist-packages

ENTRYPOINT ["/run.sh", "-o", "communication_type=http"]
