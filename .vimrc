set paste
set ruler
set laststatus=2        " always show filename/status bar
set scrolloff=4         " always show 3 lines above or below cursor
set titlestring=%<%F\ %M%=%l/%L\ -\ %p%% titlelen=70
set ts=4
filetype plugin indent on
syntax on
set backupdir=~/.backup/
set backspace=indent,eol,start
hi Search ctermbg=LightGreen
map <F1> :set hlsearch!<CR>
set spelllang=en_us
map <F8> :set spell!<CR>
set nobackup
set nowritebackup
set nofixendofline	"tph github wierdos
"alt to nofixedeol above
"autocmd FileType php setlocal noeol binary fileformat=dos
"set fileformats+=dos


set runtimepath^=~/.vim/bundle/neatstatus.vim

command -nargs=+ SReplace call StepReplace(<f-args>)
"makes use of register y
function StepReplace(...)
  if a:0 == 1
    let @y = input("Replace with: ", @y)
    let y = @y
    if @y =~ "\\d\\+$"
      let n = substitute(@y, ".\\{-}\\(\\d\\+\\)$", "\\1", "") + a:1
      let @y = substitute(@y, "\\(.\\{-}\\)\\d\\+$", "\\1".n, "")
    endif
    return y
  elseif a:0 == 3
    let @y = a:2
    execute "%s/".a:1."/\\=StepReplace(".a:3.")/".(&gdefault ? "" : "g")
  else
    echo "Usage: SReplace <search> <substitute> <increment>"
  endif
endfunction

let @A = "$time_start = microtime(true);\n"
let @S = 'error_log( "\n\n".__FUNCTION__." -- ". "Total execution time in seconds: " . sprintf("%f", microtime(true) - $time_start)."\n\n");'."\n"
