function TurnOffCaps()
    let capsState = matchstr(system('xset -q'),
      \'00: Caps Lock:\s\+\zs\(on\|off\)\ze')
    if capsState == 'on'
        silent! execute ':!xdotool key Caps_Lock'
    endif
endfunction

function! Printline()
  return "System.out.println("
endfunction
" Displays all the syntax rules for current position, useful
" When writing Vimscript syntax plugins

if has("syntax")
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
endif

"{{Theming}}
function! Gruvbox()
  colorscheme gruvbox
  let g:lightline = { 'colorscheme': 'gruvbox' }
  let g:airline_theme='gruvbox'
  let g:airline#extensions#tabline#enabled = 1
  let g:gruvbox_contrast_dark = 'dark'
  set background=dark
endfunc

command! Gruv call Gruvbox()

call Gruvbox()

function! Github()
  colorscheme github
  let g:lightline = { 'colorscheme': 'murmur' }
  let g:airline_theme='murmur'
  let g:airline#extensions#tabline#enabled = 1
  "let g:github_colors_soft = 1
  set background=light
endfunc

function! Ayu()
  colorscheme ayu 
  let g:lightline = { 'colorscheme': 'minimalist' }
  let g:airline_theme='minimalist'
  let g:airline#extensions#tabline#enabled = 1
  set background=dark
endfunc

function! Quiet()
  colorscheme quietlight
  let g:lightline = { 'colorscheme': 'murmur' }
  let g:airline_theme='murmur'
  let g:airline#extensions#tabline#enabled = 1
  set background=light
endfunc

command! Gruv call Gruvbox()
command! Github call Github()
command! Ayu call Ayu()
command! Quiet call Quiet()

