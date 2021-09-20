FROM debian:buster
LABEL maintainer="Razvan Crainea <razvan@opensips.org>"

USER root

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

#install basic components
RUN apt-get -y update -qq && apt-get -y install gnupg2 ca-certificates

#add keyserver, repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 049AD65B
RUN echo "deb https://apt.opensips.org buster cli-nightly" >/etc/apt/sources.list.d/opensips-cli.list \
    && apt-get -y update -qq && apt-get -y install opensips-cli
    
ENTRYPOINT ["/usr/sbin/opensips-cli", "-o", "communication_type=http"]
