# nvim

Personal [Neovim](https://neovim.io/) configuration

## Installation

We're assuming you have *Neovim* up&running.

First, clone this repo:

```
$ git clone git@github.com:bsnux/nvim.git
```

Create a new directory and symlink for the configuration file:

```
$ mkdir -p ~/.config/nvim/
$ ln -s ~/init.vim ~/.config/nvim/init.vim
```

Install `Plug` from command line:

```
$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Open *NeoVim* and install plugins executing `:PlugInstall` *Neovim* command.

You're set!
