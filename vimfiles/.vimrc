"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

let mapleader =","
" Open Vim config file.
map <leader>ev :vsp $MYVIMRC<CR>
" Source Vim config file.
map <leader>sv :source $MYVIMRC<CR>

call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
" Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
" Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/AutoComplPop'
Plug 'dense-analysis/ale'
Plug 'jceb/vim-hier'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim'
Plug 'vim-scripts/perl-support.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'gruvbox-community/gruvbox'
" Plug 'mg979/vim-visual-multi'
call plug#end()

" Some basics:
	set nocompatible
	set autoindent
	set autochdir
	set hlsearch
	set incsearch
	set showmatch
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	colorscheme gruvbox
	set background=dark
	"set showcmd
	set nrformats+=alpha
	nnoremap * *<C-O>:s///gn<CR>
	vnoremap <leader>p "_dP
" Enable autocompletion:
	set wildmode=longest,list,full
	let g:acp_behaviorPerlOmniLength = 10
	inoremap jk <ESC>
	nnoremap <SPACE> /
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow

" Shortcutting split navigation, saving a keypress:
	map <C-h> :wincmd h<CR>
	map <C-j> :wincmd j<CR>
	map <C-k> :wincmd k<CR>
	map <C-l> :wincmd l<CR>

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
"	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR><CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Readmes autowrap text:
	autocmd BufRead,BufNewFile *.md set tw=79

" Use urlscan to choose and open a url:
	:noremap <leader>u :w<Home> !urlscan -r 'linkhandler {}'<CR>
	:noremap ,, !urlscan -r 'linkhandler {}'<CR>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost ~/.bm* !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Highlight while searching only
	augroup vimrc-incsearch-highlight
	  autocmd!
	  autocmd CmdlineEnter /,\? :set hlsearch
	  autocmd CmdlineLeave /,\? :set nohlsearch
	augroup END

"=====[ Configure % key (via matchit plugin) ]==============================

" Match angle brackets...
set matchpairs+=<:>,«:»,｢:｣


"=====[ Adjust keyword characters to match Perlish identifiers ]===============

set iskeyword+=$
set iskeyword+=%
set iskeyword+=@-@
set iskeyword+=:

"=====[ Configure Hier for error highlighting ]===================
" You also need to install the following:  h"ttps://github.com/jceb/vim-hier

highlight HierError    ctermfg=red     cterm=bold
highlight HierWarning  ctermfg=magenta cterm=bold

let g:hier_highlight_group_qf  = 'HierError'
let g:hier_highlight_group_qfw = 'HierWarning'

let g:hier_highlight_group_loc  = 'Normal'
let g:hier_highlight_group_locw = 'HierWarning'
let g:hier_highlight_group_loci = 'Normal'

"=====[ Configure ALE for error tracking ]==================
" You also need to install the following:  https://github.com/w0rp/ale

highlight AleError    ctermfg=red     cterm=bold
highlight AleWarning  ctermfg=magenta cterm=bold

augroup ALE_Autoconfig
    au!
    autocmd User GVI_Start  silent call Stop_ALE()
    autocmd User PV_Start   silent call Stop_ALE()
    autocmd User PV_End     silent call Start_ALE()
    autocmd User ALELint    silent HierUpdate
augroup END

let g:ale_set_loclist          = 0
let g:ale_set_quickfix         = 1
let g:ale_set_signs            = 0
let g:ale_linters              = { 'perl': ['perl'] }
let g:ale_perl_perl_executable = 'polyperl'
let g:ale_perl_perl_options    = '-cw -Ilib'

nmap <silent> ;m [Toggle automake on Perl files] :call Toggle_ALE()<CR>

function! Start_ALE ()
    ALEEnable
    HierStart
endfunction

function! Stop_ALE ()
    silent call s:ChangeProfile(&filetype)
    ALEDisable
    HierStop
    call setqflist([])
    redraw!
endfunction

function! Toggle_ALE ()
    if g:ale_enabled
        call Stop_ALE()
    else
        call Start_ALE()
    endif
    echo 'Error highlighting ' . (g:ale_enabled ? 'on' : 'off')
endfunction
" =====[ Smart completion via <TAB> and <S-TAB> ]=============

runtime plugin/smartcom.vim

" Add extra completions (mainly for Perl programming)...

let ANYTHING = ""
let NOTHING  = ""
let EOL      = '\s*$'

                " Left     Right      Insert                             Reset cursor
                " =====    =====      ===============================    ============
call SmartcomAdd( '<<',    ANYTHING,  "\<BS>\<BS>«"                                    )
call SmartcomAdd( '>>',    ANYTHING,  "\<BS>\<BS>»"                                    )
call SmartcomAdd( '?',     ANYTHING,  '?',                               {'restore':1} )
call SmartcomAdd( '?',     '?',       "\<CR>\<ESC>O\<TAB>"                             )
call SmartcomAdd( '{{',    ANYTHING,  '}}',                              {'restore':1} )
call SmartcomAdd( '{{',    '}}',      NOTHING,                                         )
call SmartcomAdd( 'qr{',   ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'qr{',   '}xms',    "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>"                 )
call SmartcomAdd( 'm{',    ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'm{',    '}xms',    "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>",                )
call SmartcomAdd( 's{',    ANYTHING,  '}{}xms',                          {'restore':1} )
call SmartcomAdd( 's{',    '}{}xms',  "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>",                )
call SmartcomAdd( '\*\*',  ANYTHING,  '**',                              {'restore':1} )
call SmartcomAdd( '\*\*',  '\*\*',    NOTHING,                                         )

" Handle single : correctly...
call SmartcomAdd( '^:\|[^:]:',  EOL,  "\<TAB>" )

" In the middle of a keyword: delete the rest of the keyword before completing...
                " Left     Right                    Insert
                " =====    =====                    =======================
"call SmartcomAdd( '\k',    '\k\+\%(\k\|\n\)\@!',    "\<C-O>cw\<C-X>\<C-N>",           )
"call SmartcomAdd( '\k',    '\k\+\_$',               "\<C-O>cw\<C-X>\<C-N>",           )

"After an alignable, align...
function! AlignOnPat (pat)
    return "\<ESC>:call EQAS_Align('nmap',{'pattern':'" . a:pat . "'})\<CR>A"
endfunction
                " Left         Right        Insert
                " ==========   =====        =============================
call SmartcomAdd( '=',         ANYTHING,    "\<ESC>:call EQAS_Align('nmap')\<CR>A")
call SmartcomAdd( '=>',        ANYTHING,    AlignOnPat('=>') )
call SmartcomAdd( '\s#',       ANYTHING,    AlignOnPat('\%(\S\s*\)\@<= #') )
call SmartcomAdd( '[''"]\s*:', ANYTHING,    AlignOnPat(':'),                   {'filetype':'vim'} )
call SmartcomAdd( ':',         ANYTHING,    "\<TAB>",                          {'filetype':'vim'} )


                " Left         Right   Insert                                  Where
                " ==========   =====   =============================           ===================
" Perl keywords...
call SmartcomAdd( '^\s*for',   EOL,    " my $___ (___) {\n___\n}\n___",        {'filetype':'perl'} )
call SmartcomAdd( '^\s*if',    EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*while', EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*given', EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*when',  EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*sub',   EOL,    " ___ (___) {\n___\n}\n___",            {'filetype':'perl'} )


" Convert between single- and double-quoted string endings...
call SmartcomAdd(      '''[^"]*"',  NOTHING,  "\<ESC>?'\<CR>:nohlsearch\<CR>r\"a",        {'restore':1+1} )
call SmartcomAdd( 'q\@<!q{[^"]*"',  NOTHING,  "\<BS>}\<ESC>?q{\<CR>:nohlsearch\<CR>sqq",  {'restore':1+2} )
call SmartcomAdd(     '"[^'']*''',  NOTHING,  "\<ESC>?\"\<CR>:nohlsearch\<CR>r'a",        {'restore':1+1} )
call SmartcomAdd(   'qq{[^'']*''',  NOTHING,  "\<BS>}\<ESC>?qq{\<CR>:nohlsearch\<CR>2sq", {'restore':1+1} )



"=====[ Correct common mistypings in-the-fly ]=======================

iab    retrun  return
iab     pritn  print
iab      Pelr  Perl
iab      pelr  perl




"=====[ Add or subtract comments ]===============================

" Work out what the comment character is, by filetype...
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType             vim                               let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *.vim,.vimrc                      let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd BufNewFile,BufRead   *.p[lm],.t                        let b:cmt = exists('b:cmt') ? b:cmt : '#'

" Work out whether the line has a comment then reverse that condition...
function! ToggleComment ()
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Grab the line and work out whether it's commented...
    let currline = getline(".")

    " If so, remove it and rewrite the line...
    if currline =~ '^' . comment_char
        let repline = substitute(currline, '^' . comment_char, "", "")
        call setline(".", repline)

    " Otherwise, insert it...
    else
        let repline = substitute(currline, '^', comment_char, "")
        call setline(".", repline)
    endif
endfunction

" Toggle comments down an entire visual selection of lines...
function! ToggleBlock () range
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Start at the first line...
    let linenum = a:firstline

    " Get all the lines, and decide their comment state by examining the first...
    let currline = getline(a:firstline, a:lastline)
    if currline[0] =~ '^' . comment_char
        " If the first line is commented, decomment all...
        for line in currline
            let repline = substitute(line, '^' . comment_char, "", "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    else
        " Otherwise, encomment all...
        for line in currline
            let repline = substitute(line, '^\('. comment_char . '\)\?', comment_char, "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    endif
endfunction

" Set up the relevant mappings
nmap     <silent> # :call ToggleComment()<CR>j0
vnoremap <silent> # :call ToggleBlock()<CR>



"=====[ Search folding ]=====================

" Don't start new buffers folded
set foldlevelstart=99

" Highlight folds
highlight Folded  ctermfg=cyan ctermbg=black

" Toggle on and off...
nmap <silent> <expr>  zz  FS_ToggleFoldAroundSearch({'context':1})

" Show only sub defns (and maybe comments)...
let perl_sub_pat = '^\s*\%(sub\|func\|method\|package\)\s\+\k\+'
let vim_sub_pat  = '^\s*fu\%[nction!]\s\+\k\+'
augroup FoldSub
    autocmd!
    autocmd BufEnter * nmap <silent> <expr>  zp  FS_FoldAroundTarget(perl_sub_pat,{'context':1})
    autocmd BufEnter * nmap <silent> <expr>  za  FS_FoldAroundTarget(perl_sub_pat.'\zs\\|^\s*#.*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  zp  FS_FoldAroundTarget(vim_sub_pat,{'context':1})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  za  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter * nmap <silent> <expr>             zv  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
augroup END

" Show only 'use' statements
nmap <silent> <expr>  zu  FS_FoldAroundTarget('^\s*use\s\+\S.*;',{'context':1})



"=====[ Smarter interstitial completions of identifiers ]=============
"
" When autocompleting within an identifier, prevent duplications...

augroup Undouble_Completions
    autocmd!
    autocmd CompleteDone *  call Undouble_Completions()
augroup END

function! Undouble_Completions ()
    let col  = getpos('.')[2]
    let line = getline('.')
    call setline('.', substitute(line, '\(\.\?\k\+\)\%'.col.'c\zs\1', '', ''))
endfunction



"=====[ ,, as => without delays ]===================

inoremap <expr><silent>  ,  Smartcomma()

function! Smartcomma ()
    let [bufnum, lnum, col, off, curswant] = getcurpos()
    if getline('.') =~ (',\%' . (col+off) . 'c')
        return "\<C-H>=>"
    else
        return ','
    endif
endfunction


"======[ Breakindenting ]========

set breakindentopt=shift:2,sbr
set showbreak=↪
set breakindent

"nnoremap <Esc>[1;3D <C-w>h
 "let g:VM_maps = {}
 "let g:VM_maps["Select Cursor Down"] = '<S-Down>'
 "let g:VM_maps["Select Cursor Up"]   = '<A-Up>'

"======[ vimfiler plugin settings]========
let g:vimfiler_as_default_explorer = 1

"	tabopen		Open the file in a new tab.
"	choose		Open the file in a selected window.
"	split		Open the file, splitting horizontally.
"	vsplit		Open the file, splitting vertically.
"	left		Open the file in the left, splitting vertically.
"	right		Open the file in the right, splitting vertically.
"	above		Open the file in the top, splitting horizontally.
"	below		Open the file in the bottom, splitting horizontally.
"	persist_open	Open the file in alternate window.  unite window
"			isn't closed.
"	tabsplit	Open the files and vsplit in a new tab.
"	switch		Open the file in current window or jump to existing
"			window/tabpage.
"	tabswitch	Open the file in new tab or jump to existing
"			window/tabpage.
"	splitswitch	Open the file in split window or jump to existing
"			window/tabpage.
"	vsplitswitch	Open the file in vertical split window or jump to
"			existing window/tabpage.
call vimfiler#custom#profile('default', 'context', {
      \ 'buffer_name' : 'explorer',
      \ 'winwidth' : 50,
      \ 'columns' : 'size:time',
      \ 'safe' : 1,
      \ 'edit_action' : 'open',
      \ 'quit' : 1
      \ })
map <F8> :VimFilerExplore -toggle <CR>
" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '✩'
" autocmd VimEnter * if !argc() | VimFilerExplore | endif

"======[ unit.vim plugin settings]========
let g:unite_prompt = "➤ "
"let g:airline_section_b = '%{strlen(@")}'

"set tabline=%!MyTabLine()
"function MyTabLine()
"  let s = ''
"  for i in range(tabpagenr('$'))
"    " select the highlighting
"    if i + 1 == tabpagenr()
"      let s .= '%#TabLineSel#'
"    else
"      let s .= '%#TabLine#'
"    endif
"
"    " set the tab page number (for mouse clicks)
"    let s .= '%' . (i + 1) . 'T'
"
"    " the label is made by MyTabLabel()
"    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
"  endfor
"
"  " after the last tab fill with TabLineFill and reset tab page nr
"  let s .= '%#TabLineFill#%T'
"
"  return s
"endfunction
"function MyTabLabel(n)
"  let buflist = tabpagebuflist(a:n)
"  let winnr = tabpagewinnr(a:n)
"  return bufname(buflist[winnr - 1])
"endfunction
nnoremap <C-f> :FZF --reverse<CR>
if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%1*' : '%2*')
             let s .= ' '
             let s .= i
             let s .= ' %*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
"         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set showtabline=1
     set tabline=%!MyTabLine()
endif
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline']}, <bang>0)
