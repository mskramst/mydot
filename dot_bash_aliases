# ------------------------------ aliases -----------------------------

# linux cmds
alias ls='ls -h --color=auto'
alias mkdir='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias used="du -sh"
alias chmox='chmod +x'
alias aptup='sudo apt-get update'
alias aptupg="sudo apt-get update && sudo apt-get upgrade"
alias src='exec bash -l'     #reloads shell with all values (best)
alias info="sed -n '2p'"

# setup for syncing dot files to and from multiple computers
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME' 

# search
alias gs="goog"   
alias ws="websearch" 
alias ol="ollama run llama3"

# mods charmbracelet - open ai
alias modsls='mods --list'
alias modsh='mods --show'
alias lang="source ~/.lang_aliases"

# commonly used directories
alias start='cd $STARTANEW'
alias scripts='cd $SCRIPTS'
alias pscripts='cd $PSCRIPTS'
alias snippets='cd $SNIPPETS'
alias gith='cd $GHREPOS'
alias gitrv='git remote -v'
alias saved='cd $STARTANEW/saved'
alias notes='cd $STARTANEW/writing/notes'

# gist related
alias gistc='gh gist create -'
alias newgist='gh gist create $STARTANEW/saved/gist'
alias gistls='gh gist ls'
alias gisthelp='cat $STARTANEW/docs/gists-help.txt'
alias cloneins='git clone -c http.sslVerify=false'

# editing config files
alias hl='highlight -O ansi'

# git
alias status="git status"
alias gita="git add -A ."
alias gitc="git commit -m"
alias gitac="git add -A . & git commit -m"
alias gitp="git push origin main && echo 'pushing main to origin'"

#tmux
alias tls="tmux list-windows"
alias tnot="tmux new -s work -d && tmux rename-window -t 1 'code' && tmux new-window && tmux rename-window -t 2 'run'"
alias tdev="tmux new-window -t 3 && tmux rename-window -t 3 'dev';"
alias tcode="tmux new -s work -d && && tmux rename-window"
alias dev="tmux new -s dev -d"
alias play="tmux new -s play -d"
alias attach="tmux a -t"

#useful
alias yt3="yt-dlp -x --audio-format mp3" # mp3
alias yt="ytfzf -L"
alias ytlist="mpv -fs --playlist=current"
alias yt4='yt-dlp -f best' # mp4
alias entrgo='ls *.go | entr -r go run main.go'
alias oll='ollama run llama3.2:latest'

# open the last modified file in a directory
alias nv='nvim'
alias vlast="vim $(ls -t | head -n1)"

# save last cli cmd to file
alias savelast='history -p !! > $STARTANEW/lastcmd'

# cat the last saved buffer
alias catbuf='cat $STARTANEW/saved/buf'

