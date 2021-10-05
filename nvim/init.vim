set runtimepath+=/usr/share/vim/vimfiles

call plug#begin('~/.vim/plugged')
  Plug 'andrejlevkovitch/vim-lua-format'
  Plug 'andweeb/presence.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'mhinz/vim-startify'
  Plug 'itchyny/lightline.vim'
  Plug 'mattn/emmet-vim'
  Plug 'alvan/vim-closetag'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/vim-easy-align'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'preservim/nerdcommenter'
  Plug 'sainnhe/gruvbox-material'
call plug#end()


syntax on
set nu     
set noswapfile
set tabstop=4 softtabstop=4
set smartindent
set smartcase
set shiftwidth=4
set expandtab
set autoindent
set incsearch	
set termguicolors
set encoding=utf-8
set hidden
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set lines=40


" Indenting for vim, html and css
autocmd FileType vim,html,css set shiftwidth=2


" neovim theme
let g:gruvbox_termcolors=256
let g:lightline = { 'colorscheme': 'wombat' }
let g:gruvbox_material_palette='mix'
colorscheme gruvbox-material


" Build and Run file
autocmd FileType python nnoremap <F5> :term python %<enter>
autocmd FileType c,cpp nnoremap <F5> :term g++ % && ./a.out<enter>
autocmd FileType lua nnoremap <F5> :term luajit %<enter>
autocmd FileType javascript nnoremap <F5> :term node %<enter>
    

" lua formatting 
autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()<cr>
autocmd BufWrite *.lua call LuaFormat()


" colorizer
lua require'colorizer'.setup()

" Closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'


" LSP
luafile /home/soul/.config/nvim/lua/lsp-config.lua
luafile /home/soul/.config/nvim/lua/lls.lua
lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { 'python', 'javascript', 'html', 'css', 'cpp', 'lua', 'vim'},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
EOF

" lsp Keybindings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR> 
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR> 
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR> 
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR> 
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR> 
nnoremap <silent> <C-s> <cmd>lua vim.lsp.buf.signature_help()<CR> 

" Autoformatting
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100) 
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100) 
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)


" NERDTree 
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" Align 
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
