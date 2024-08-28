if has('win32') || has('win64')
  let g:plugged_home = '~/AppData/Local/nvim/plugged'
else
  let g:plugged_home = '~/.vim/plugged'
endif
" Plugins List
call plug#begin(g:plugged_home)
  " UI related
  Plug 'chriskempson/base16-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " syntax check inline
  Plug 'dense-analysis/ale'
  " Autocomplete and syntax check
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
  " Snippets
  Plug 'rafamadriz/friendly-snippets'
  " Formater
  Plug 'Chiel92/vim-autoformat'
  Plug 'hashivim/vim-terraform'
  Plug 'vim-syntastic/syntastic'
  Plug 'juliosueiras/vim-terraform-completion'
  Plug 'neomake/neomake'
  Plug 'kassio/neoterm'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Editing
  Plug 'machakann/vim-sandwich'
call plug#end()

" Show trailing spaces
set list
set listchars=tab:▸\ ,trail:␣,precedes:←,extends:→,nbsp:•

" Enables mouse highlight in visual mode
" set mouse=a

" colors myevening
colors kolor

" Map spellcheck to F5 in normal and insert mode
set spelllang=en_au
nnoremap <silent> <F5> :set spell!<cr>
inoremap <silent> <F5> <C-O>:set spell!<cr>

" nnoremap <leader>% :set spell!<cr>
" inoremap <leader>% <C-O>:set spell!<cr>

" ]s – Jump to the next misspelled word
" [s – Jump to the previous misspelled word
" z= – Bring up the suggested replacements
" zg – Good word: Add the word under the cursor to the dictionary
" zw – Woops! Undo and remove the word from the dictionary

" Copy to clipboard in mac
vnoremap <C-c> :w !pbcopy<CR><CR>

" Copy to clipboard in Linux
" vnoremap <C-c> "+y <CR><CR>

" Word end characters
set iskeyword-=_

" Show hidden files in NerdTree
let NERDTreeShowHidden=1
"autopen NERDTree and focus cursor in new document
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
let mapleader = ","
nmap <leader>nt :NERDTree<cr>
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" When providing 2 files, opens in split window
if argc() == 2
  silent vertical all
endif

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

augroup CursorColumn
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorcolumn
augroup END

" Configurations Part
" UI configuration
if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif

filetype plugin indent on  " required
" As seen here: https://dougblack.io/words/a-good-vimrc.html
filetype indent on         " load filetype-specific indent files

syntax enable           " enable syntax processing
set tabstop=4           " number of visual spaces per TAB
set shiftwidth=4        " Autoindent by 4 spaces when >> << ==
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " replaces a tab charecter with spaces
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " ignore case when searching
noremap <F3> :Autoformat<CR>

" Don't select first option in complete popup
autocmd FileType * set completeopt=longest,menuone,preview

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent nofoldenable
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Airline
 let g:airline_left_sep  = ''
 let g:airline_right_sep = ''

"Terraform Autocomplete
let g:terraform_fmt_on_save=1
let g:terraform_align=1

" Sandwich - Helps surrounding text with characters
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" Open a [,} block
inoremap {, {<CR>},<C-c>O
inoremap [, [<CR>],<C-c>O

" Insert a word into "", '', () or []
inoremap <M-"> ""<C-c>i
inoremap <M-'> ''<C-c>i
inoremap <M-(> ()<C-c>i
inoremap <M-[> []<C-c>i

"" CoC
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"

" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"" Snippet Expension
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

"" FZF Fuzzy search {{{
" <C-p> or <C-t> to search files
nnoremap <silent> <C-t> :Files<cr>
nnoremap <silent> <C-p> :FZF -m<cr>

" <M-p> for open buffers
nnoremap <silent> <M-p> :Buffers<cr>

" <M-S-p> for MRU
nnoremap <silent> <M-S-p> :History<cr>

" Open the fuzzy finder just for the directory containing the currently edited file.
nnoremap <silent> <Space>. :Files <C-r>=expand("%:h")<CR>/<CR>

" Use fuzzy completion relative filepaths across directory
imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

" Better command history with q:
command! CmdHist call fzf#vim#command_history({'right': '40'})
nnoremap q: :CmdHist<CR>

" Better search history
command! QHist call fzf#vim#search_history({'right': '40'})
nnoremap q/ :QHist<CR>

command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
" }}}
"
" ### RG
"nnoremap <Space>/ :Rg<Space>
""
let g:rg_command = 'rg --hidden --follow --column --line-number --no-heading --color "always" -g "!(.git)/*"'

" concatenate together all the necessary options for the final call to the rg command
fun! BuildRgCommand(opts, qargs)
  let l:list = [g:rg_command] + a:opts + ['--', shellescape(a:qargs)]
  return join(l:list, ' ')
endfun

" construct the rg command and pass it to the fzf grep command with all necessary options
fun! Fzf_grep(opts, qargs, bang) abort
  let l:rg = BuildRgCommand(a:opts, a:qargs)
  call fzf#vim#grep(l:rg, 1, {}, a:bang)
endfun

" custom commands

" Search literal string recursive ignoring case
command! -bang -nargs=* RG call Fzf_grep(['--ignore-case', '--fixed-strings'], <q-args>, <bang>0)

" Search literal string recursive case sensitive
command! -bang -nargs=* RGS call Fzf_grep(['--fixed-strings'], <q-args>, <bang>0)

" Search recursive case sensitive as RegExp (using ripgrep RegExp engine, _not_ vim RegExp engine)
command! -bang -nargs=* RGX call Fzf_grep([], <q-args>, <bang>0)

" Seach literal string recursive case sensitive with word boundaries
command! -bang -nargs=* RGSW call Fzf_grep(['-w', '--fixed-strings'], <q-args>, <bang>0)

" Search files for word under cursor
nnoremap <leader>* "zyiw :let cmd = 'RGSW ' . @z <bar> call histadd("cmd", cmd) <bar> execute cmd<cr>
" Search files for visually selected text
xnoremap <leader>* "zy :let cmd = 'RGS ' . @z <bar> call histadd("cmd", cmd) <bar> execute cmd <cr>
" Search for a string in local dir, ignore case
nnoremap <leader>./ :let cmd = 'RGS ' <bar> call histadd("cmd", cmd) <bar> execute cmd<cr>
" Search for a string in local dir, ignore case
nnoremap <leader>/ :let cmd = 'RG ' <bar> call histadd("cmd", cmd) <bar> execute cmd<cr>
