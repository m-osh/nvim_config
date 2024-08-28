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

### Install coc related plugins
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

**Turn on spell check**

`<F5>` or `func-<F5>`

`z=` for suggestions

**Editing / Markdown**

**(normal mode)**
*This is using the vim-sandwich plugin*

`<sa><e>-<">` Surround a word with `"`

`<sa><e>-<'>` Surround a word with `'`

``<sa><e>-<`>`` Surround a word with ``<`>``

`<sa><e>-<*>` Surround a word with `*`

`<sa><e>-<*><.>` Surround a word with `**`, The `<.>` repeates the operation again

**(insert mode)**

`[,` start editing in a `[` block

`{,` start editing in a `{` block

`<alt>-"` start editing in `""`

`<alt>-'` start editing in `''`

`<alt>-(` start editing in `()`

`<alt>-[` start editing in `[]`
