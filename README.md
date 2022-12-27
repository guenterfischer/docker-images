
### Image 'base'

This acts as base container with all basic tools, settings, etc.

The image can be built with following command:

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

If set-up correctly, the ssh keys can be initialized with `ssh_init` from within the container. \
*Hint: This function is defined in the `bashrc` file*

If no keys are provided, the docker build will fail.
In this case, the related lines has to be commented out in the Dockerfile.

#### nvim

This directory contains the configuration for neovim.

One of the used plugins is [lualine](https://github.com/nvim-lualine/lualine.nvim). \
In order to use all symbols, the appropriate [nerd font](https://www.nerdfonts.com/) has to be installed.

This can be done as follows:

```bash
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.0/UbuntuMono.zip \
  && unzip UbuntuMono.zip -d ~/.fonts \
  && fc-cache -fv \
  && rm -rf UbuntuMono.zip
```


### Image 'avr'

This image contains tools for the programming of AVR µControllers. \
It uses the 'base' image as parent and thus has all common tools installed as well.

The image can be built with following command:

```bash
docker build --network=host -t avr ./avr
```


### Image 'zephyr'

This image contains tools regarding [Zephyr](https://github.com/zephyrproject-rtos/zephyr). \
It uses the 'base' image as parent and thus has all common tools installed as well.

The installation is done according to this guideline: \
<https://docs.zephyrproject.org/latest/develop/getting_started/index.html>

The image can be built with following command:

```bash
docker build --network=host -t zephyr ./zephyr
```


### Support

If you appreciate this repository you can buy me a coffee

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/guenterfischer)
