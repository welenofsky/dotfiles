syntax on					" syntax highlighting
filetype indent plugin on			" detect spacing based on file type

set modeline					" use modelines in files.
set background=dark				" better color highlighting for dark bg's
set incsearch					" search as term is being typed
set hlsearch					" highlight matches

" Folding
set foldenable					" enable folding
set foldmethod=indent					" fold based on indent level
set foldnestmax=10				" 10 nested fold max
set foldlevelstart=10				" open most folds by default

" Key Bindings
nnoremap <leader><space> :nohlsearch<CR>	" turn off search highlight ( \ + <spacebar> )
nnoremap <space> za				" space opens and closes folds

" Spacing for tabs
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
