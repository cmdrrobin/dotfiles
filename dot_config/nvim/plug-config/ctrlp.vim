" Set up CTRL P {{{
" " First set up patterns to ignore
set wildignore+=*/tmp/*,*.so,*/node_modules,*/.git/*,.DS_Store,*.swp,*.zip,*.jpg,*.png,*.gif "patterns to ignore
let g:ctrlp_map = '<c-p>'                           "Open with CTRL+P
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$' "default ignores
let g:ctrlp_by_filename = '1'                       "only look for filenames
