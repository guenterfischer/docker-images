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
  invoke                   \
  flake8                   \
  uvicorn                  \
  fastapi                  \
  typer[all]               \
  gunicorn                 \
  cryptography             \
  termcolor                \
  numpy                    \
  conan


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
# INSTALL clang
###############################################################################

RUN apt-get update
RUN apt-get -y install \
  clang --install-suggests    \
  clang-tidy                  \
  clang-14 --install-suggests \
  clang-tidy-14


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
# INSTALL POETRY
###############################################################################

RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="${PATH}:/home/docker/.local/bin"


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
  clang-format           \
  ripgrep                \
  gdu

RUN pip3 install         \
  autopep8               \
  cmakelang              \
  cmake-language-server  \
  shfmt-py               \
  pyaml

RUN gem install          \
  rubocop

RUN npm install -g       \
  prettier               \
  tree-sitter-cli

RUN cd /tmp \
  && LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') \
  && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
  && tar xf lazygit.tar.gz lazygit \
  && install lazygit /usr/local/bin

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

# Install AstroNvim
RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
RUN nvim --headless "+Lazy! sync" +qa
RUN nvim --headless "+Lazy! install" +qa

# Add own config
RUN git clone https://github.com/guenterfischer/astronvim.git ~/.config/nvim/lua/user
RUN nvim --headless "+Lazy! sync" +qa
RUN nvim --headless "+Lazy! install" +qa


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

RUN ssh-keyscan bitbucket.org >> /home/docker/.ssh/known_hosts \
 && ssh-keyscan github.com    >> /home/docker/.ssh/known_hosts

# Finally switch to user 'docker'
USER docker
