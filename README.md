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

### Setup fuzzy search
```bash
# Install fuzzy search
$ brew install fzf

# fzf uses this grep tool
$ brew install ripgrep
```

### Instasll coc related plugins
```bash
# Install node
$ brew install node
```
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

### Commonly used shortcuts
**FZF fuzzy search keys**

`crtl-t` file search

`,/` string search ignore case

`,*` search for the string the cursor is on

**Open sidebar tree**

`,nt` Open browser

`crtl-w <left> or <right>` navigate panes

