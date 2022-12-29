FROM ubuntu:22.04

# Set environment variable with image name
ENV DOCKER_IMAGE=base


###############################################################################
# UPDATE PACKET LISTS AND UPGRADE SYSTEM
###############################################################################

RUN apt-get update && apt-get upgrade -y


###############################################################################
# CONFIGURE LOCALES
###############################################################################

RUN apt-get install -y locales \
  && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en  \
  LC_ALL=en_US.UTF-8


###############################################################################
# INSTALL COMMON TOOLS
###############################################################################

RUN apt-get install -y \
  sudo                 \
  tree                 \
  tar                  \
  curl                 \
  wget                 \
  git                  \
  python3              \
  python3-pip          \
  python3-venv         \
  ruby                 \
  ruby-dev             \
  clangd               \
  keychain             \
  bash-completion      \
  iproute2

RUN apt-get autoremove -y && apt-get clean


###############################################################################
# INSTALL PIP MODULES
###############################################################################

RUN pip3 install --upgrade \
  flake8                   \
  uvicorn                  \
  fastapi                  \
  gunicorn                 \
  cryptography             \
  termcolor


###############################################################################
# INSTALL RUBY GEMS
###############################################################################

RUN gem install \
  nokogiri      \
  rake          \
  highline      \
  colorize      \
  net           \
  net-ssh       \
  net-telnet    \
  net-ping      \
  net-scp


###############################################################################
# INSTALL Node.js
###############################################################################

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get -y install \
  nodejs               \
  yarn


###############################################################################
# ADD A NEW USER NAMED 'docker'
###############################################################################

RUN useradd -ms /bin/bash docker \
  && echo "docker:docker" | chpasswd \
  && adduser docker sudo

# Set bash as default shell
RUN chsh -s /bin/bash docker

# Enable that all sudo commands can be run w/o password query
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker
WORKDIR /home/docker


###############################################################################
# INSTALL AND CONFIGURE NEOVIM
###############################################################################

# Installation has to be done as 'root'
USER root

# Install prerequisites for neovim itself
#   Some might be redundant, but I want to have
#   a complete list regarding neovim here
RUN apt-get install -y   \
  git                    \
  make                   \
  cmake                  \
  pkg-config             \
  libtool                \
  libtool-bin            \
  gcc                    \
  g++                    \
  ninja-build            \
  unzip                  \
  curl                   \
  gettext

# Install prerequisites for neovim plugins
#   Again, some might be redundant
RUN apt-get install -y   \
  fonts-powerline        \
  clangd                 \
  clang-format

RUN pip3 install         \
  autopep8               \
  cmakelang              \
  cmake-language-server  \
  shfmt-py               \
  pyaml

RUN gem install          \
  rubocop

RUN npm install -g       \
  prettier

# Build and install neovim from scratch
RUN cd /tmp \
  && git clone https://github.com/neovim/neovim \
  && cd ./neovim \
  && git checkout stable \
  && make CMAKE_BUILD_TYPE=Release \
  && make install
RUN rm -rf /tmp/neovim

# Configuration has to be done as 'docker'
USER docker

# Configure neovim
#   The configuration has to be done in two steps,
#   at first the plugins itself, then the plugin specific part
COPY --chown=docker:docker nvim/init.lua /home/docker/.config/nvim/
COPY --chown=docker:docker nvim/lua/.    /home/docker/.config/nvim/lua

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  /home/docker/.local/share/nvim/site/pack/packer/start/packer.nvim

RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

COPY --chown=docker:docker nvim/after/.  /home/docker/.config/nvim/after

RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
RUN nvim --headless -c 'LspZeroSetupServers' -c 'sleep 30' -c 'quitall'


###############################################################################
# ADAPT BASH
###############################################################################

# Add custom functions to .bashrc
COPY bash/bashrc .
RUN cat bashrc >> /home/docker/.bashrc && rm bashrc

# Add custom bash prompt
COPY --chown=docker:docker bash/bash_prompt /home/docker/.bash_prompt


###############################################################################
# CONFIGURGE GIT (BOTH GITHUB AND BITBUCKET)
###############################################################################

COPY --chown=docker:docker git/. /home/docker/
RUN chmod 600 /home/docker/.ssh/*.key

RUN  ssh-keyscan bitbucket.org >> /home/docker/.ssh/known_hosts \
  && ssh-keyscan github.com    >> /home/docker/.ssh/known_hosts


# Finally switch to user 'docker'
USER docker
