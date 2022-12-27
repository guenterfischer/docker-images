# Use 'base' as parent image
#  This can be overwritten by adding '--build-arg DOCKER_PARENT_IMAGE=parentimage' to the docker build command
ARG DOCKER_PARENT_IMAGE=base

# Specify parent image
FROM ${DOCKER_PARENT_IMAGE}:latest

# Set environment variable with image name
ENV DOCKER_IMAGE=avr


###############################################################################
# INSTALL AVR TOOLS
###############################################################################

USER root

RUN apt-get -y update && apt-get -y install \
  avr-libc \
  avrdude \
  avrdude-doc \
  avrp \
  binutils-avr \
  gcc-avr \
  gdb-avr

COPY avrdude.conf /etc/avrdude.conf


# Switch back to user 'docker'
USER docker
