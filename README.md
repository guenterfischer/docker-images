# Docker Images based on Ubuntu 22.04

## Docker Image 'base'

This acts as base container with all basic tools, settings, etc.

It can be built with following command:

```bash
docker build --network=host -t base ./base
```

#### bash

This directory contains custom adaptions for bash.

#### git

This directory is intended for the .gitconfig as well as for the ssh keys.

For obvious reasons, I haven't committed my config and keys to this repository.
This has to be done by everyone himself.

The resulting directory structure should look like this:

```bash
./base/git/
├── .gitconfig
└── .ssh
    ├── bitbucket.key
    ├── bitbucket.key.pub
    ├── github.key
    └── github.key.pub
```

If set-up correctly, the ssh keys can be initialized with `ssh_init` from within the container.
This function is defined in the `bashrc` file.

If no keys are provided, the docker build will fail.
In this case, the related lines 190-194 has to be commented out in the Dockerfile.

#### nvim

This directory contains the configuration for neovim.
