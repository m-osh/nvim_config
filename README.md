# My nVim Config

### Add nvim config to your home dir
You may need to backup your exiting `~/.config/nvim` dir
```bash
cp -r nvim ~/.config
```

### Install the plugins defined in Plug
```vim
:PlugInstall
```
### Update plugins from git
```vim
:PlugUpdate
```

### nVim plugins healthcheck
```vim
:checkhealth
```

### Instasll coc related plugins
```vim
# Install ansible support
:CocInstall @yaegassy/coc-ansible

# Install snippets support
:CocInstall coc-snippets
```

### Setup python support
```bash
# Python syntax check
$ pip<nvim python ver> install jedi
```
```vim
# Install python support
:CocInstall coc-python

# Set python version for coc plugins
:CocCommand python.setInterpreter
```

### Install terraform language server for systax supprt
```bash
$ brew install terrafrom-ls
```
