autocmd InsertEnter * call s:fixindentline()
function! s:fixindentline() abort
  if !exists('s:done') && has('conceal')
    " The indentLine plugin need conceal feature
    if exists(':IndentLinesToggle') == 2
      IndentLinesToggle
      IndentLinesToggle
    else
      echohl WarningMsg
      echom 'plugin : indentLines has not been installed,
            \ please use `:call dein#install(["indentLine"])` to install this plugin,'
      echohl None
    endif
    let s:done = 1
  endif
endfunction
