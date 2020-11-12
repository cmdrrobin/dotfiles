function! bootstrap#before() abort
  call SpaceVim#logger#info("Initializing bootstrap#before")
endfunction

function! bootstrap#after() abort
  call SpaceVim#logger#info("Initializing bootstrap#after")

  let g:indentLine_char_list = ['|']

  " Nerdtree
  let g:NERDTreeIgnore = [ '\.DS_Store$' ]
  let g:NERDTreeMouseMode = 3
  let g:NERDTreeShowLineNumbers = 1
  let g:NERDTreeWinSize = 65
  let g:NERDTreeQuitOnOpen = 1

  " Ansible
  let g:ansible_attribute_highlight = "ab"
  let g:ansible_name_highlight = 'b'
  let g:ansible_extra_keywords_highlight = 1
  let g:ansible_normal_keywords_highlight = 'Constant'
  let g:ansible_with_keywords_highlight = 'Constant'
  let g:ansible_unindent_after_newline = 1
endfunction
