call pathogen#infect()

syntax on

set t_Co=256                        " 256 Colors
set nocompatible                    " Use Vim settings, rather then Vi settings (much better!).

filetype plugin on
set ofu=syntaxcomplete#Complete

" ================ General Config ====================
set title                           " Update terminal window title
set visualbell                      " Turn off sounds
set showmode                        " Show the current mode
set showcmd                         " Show incomplete commands
set autoread                        " Reload files changed outside of vim
set ttyfast                         " Use a fast terminal connection
set ruler                           " Show the line and column number of the cursor position
set backspace=indent,eol,start      " Allow backspace in insert mode
set laststatus=2                    " Always show a status line
set encoding=utf-8                  " Default character encoding
set scrolloff=3                     " Start scrolling 3 lines from the bottom
set showtabline=2                   " Always Show Tab Line
set hidden
set number                          " Show line number
" ================ Indentation =======================
set autoindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set wrap                            " Wrap lines
set textwidth=79                    " Width of text strings
set formatoptions=qrn1              " Set format options

" ================ Completion ========================
set wildmode=list:longest
set wildmenu                        " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~         "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif,*.pdf,*.psd

" ================ Searching =========================
set ignorecase                      " Ignore case when searching
set smartcase                       " Don't ignore case if search contains upper-case characters
set gdefault                        " Substitude command (:s) always does global search
set incsearch                       " Find the next match as we type the search
set hlsearch                        " Highlight searches by default

" ================ Colors ============================
colorscheme peachpuff

autocmd VimEnter * SpaceHi          " Tab Highlighting

highlight LineNr ctermfg=235
highlight Comment ctermfg=236
highlight Pmenu ctermfg=lightgrey ctermbg=234
highlight PmenuSel ctermfg=white ctermbg=darkgrey
highlight clear SpellBad

" Remember Last Position
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" ================ Remapping =========================
" Navigate rows rather than lines
nnoremap <down> gj
nnoremap <up> gk

" Map short cut to easy input current date
nnoremap <F5> "=strftime("%Y-%m-%d %H:%M:%S")"<CR>P

" Map leader from \ to ,
 let mapleader=","

" diff current vi buffer edits against original file
nmap <silent> <leader>d :w !diff -u % -<CR>

" Switch between split screens
map <leader>, <C-W>w

" Resize Split Windows
map + <c-w>+
map _ <c-w>-
map \| <c-w><
map \ <c-w>>

" Write/quit fixes
:command WQ wq
:command Wq wq
:command W w
:command Q q

" tabs
map <silent> <c-n> :tabnew<cr>
noremap <c-h> gt
noremap <c-l> gT

" Reselect visual block after indenting
vmap > > gv
vmap < < gv

" ================ Plugins ===========================
" markdown
let g:vim_markdown_frontmatter=1

" SuperTab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabClosePreviewOnPopupClose = 1

" NerdTree
map <silent> <leader>n :NERDTreeTabsToggle<CR>
let NERDTreeDirArrows=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '\.os$', '\.dylib$', '\.a$', 'DS_STORE', '\.jpg$', '\.png$', '\.gif$', '\.pdf' ]
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" delimitMate
au FileType php let delimitMate_matchpairs = "(:),[:],{:}"

" CloseTag
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" CTags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_width=26
let g:tagbar_compact = 1
noremap <silent> <leader>/ :TagbarToggle<cr>
let g:tagbar_type_php  = {'ctagstype' : 'php', 'kinds'     : [ 'i:interfaces', 'c:classes', 'd:constant definitions', 'f:functions' ] }
autocmd FileType php nested :TagbarOpen

" utils snips
" let g:UltiSnipsSnippetDirectories=["UltiSnips","snippets"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split you window.
let g:UltiSnipsEditSplit="vertical"

" Indent Line
" vertical line Indentation
let g:indentLine_color_term=239
let g:indentLine_colr_gui='#09AA08'
let g:indentLine_char="|"


" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=0

" Super tab settings - uncomment the next 4 lines
" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
" let g:SuperTabClosePreviewOnPopupClose = 1

" don't autoselect first item in omnicomplete, show if only one item (for preview)
" remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

" Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
" You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

augroup omnisharp_commands
    autocmd!

	" Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

	" Synchronous build (blocks Vim)
	" autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
	" Builds can also run asynchronously with vim-dispatch installed
	autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
	" automatic syntax check on events (TextChanged requires Vim 7.4)
	autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

	" Automatically add new cs files to the nearest project on save
	autocmd BufWritePost *.cs call OmniSharp#AddToProject()

	"show type information automatically when the cursor stops moving
	autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

	"The following commands are contextual, based on the current cursor position.

	autocmd FileType cs nnoremap <leader>gd :OmniSharpGotoDefinition<cr>
	autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
	autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
	autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
	autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr> "finds members in the current buffer
	" cursor can be anywhere on the line containing an issue
	autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
	autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
	autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
	autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
	autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr> "navigate up by method/property/field
	autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr> "navigate down by method/property/field

augroup END

" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>rn :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>

" OmniSharp end

" NEO Complete start
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 0
let g:neocomplete#enable_auto_close_preview = 0

" Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
     \ 'default' : '',
     \ 'vimshell' : $HOME.'/.vimshell_hist',
     \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

" Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"   let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>	neocomplete#undo_completion()
inoremap <expr><C-l>	neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR>	<C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h>	neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>		neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>	neocomplete#close_popup()
inoremap <expr><C-e>	neocomplete#cancel_popup()

let g:neocomplete#enable_auto_select = 0
let g:neocomplete#disable_auto_complete = 0

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" Enable heavy omni completion.

call neocomplete#custom#source('_','sorters',[])

if !exists('g:neocomplete#sources')
	let g:neocomplete#sources={}
endif

if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
let g:neocomplete#sources#cs = ['omni']
let g:neocomplete#enable_refresh_always = 0
let g:echodoc_enable_at_startup = 1
let g:neocomplete#enable_insert_char_pre =1

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'")

" NEO Complete end
