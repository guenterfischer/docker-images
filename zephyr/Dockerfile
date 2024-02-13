# Use 'base' as parent image
#  This can be overwritten by adding '--build-arg DOCKER_PARENT_IMAGE=parentimage' to the docker build command
ARG DOCKER_PARENT_IMAGE=base

# Specify parent image
FROM ${DOCKER_PARENT_IMAGE}:latest

# Set environment variable with image name
ENV DOCKER_IMAGE=zephyr


###############################################################################
# INSTALL ZEPHYR
###############################################################################

USER root

# Install dependencies
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -y --no-install-recommends git cmake ninja-build gperf \
    ccache dfu-util device-tree-compiler wget \
    python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file \
    make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1

USER docker

# Get Zephyr and install Python dependencies
RUN pip3 install --user -U 'west==0.13.0'

ENV PATH="/home/docker/.local/bin:${PATH}"
RUN west init --mr v2.6.0 ~/zephyrproject
RUN cd ~/zephyrproject \
  && west update
RUN cd ~/zephyrproject \
  && west zephyr-export

RUN pip3 install -r ~/zephyrproject/zephyr/scripts/requirements.txt

# Install Zephyr SDK
RUN cd /tmp \
  && wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.13.0/zephyr-sdk-0.13.0-linux-x86_64-setup.run \
  && chmod +x zephyr-sdk-0.13.0-linux-x86_64-setup.run \
  && ./zephyr-sdk-0.13.0-linux-x86_64-setup.run -- -d ~/zephyr-sdk-0.13.0


###############################################################################
# INSTALL OPENOCD
###############################################################################

USER root

# Install dependencies
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -y automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-dev

# Clone repository and build openocd
RUN cd /opt \
  && git clone https://github.com/raspberrypi/openocd.git --branch rp2040-v0.12.0 --depth=1 --no-single-branch
RUN cd /opt/openocd \
  && ./bootstrap    \
  && ./configure    \
  && make -j        \
  && make install

# Switch back to user 'docker'
USER docker
