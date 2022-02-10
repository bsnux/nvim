# NeoVim +0.5 configuration

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
$ ln -s nvim/init.lua ~/.config/nvim/init.lua
$ ln -s nvim/snippets ~/.config/nvim/snippets
```

Open *NeoVim* and install plugins executing `:PackerInstall` *Neovim* command.

You're set!
