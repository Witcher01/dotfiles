### Global user variables ###
## global system variables are now in /etc/profile
export EDITOR=nvim
export BROWSER=firefox
export BROWSERCLI=lynx
export _JAVA_AWT_WM_NONREPARENTING=1
export LYNX_LSS=$XDG_CONFIG_HOME/lynx/stylesheets/solarized_dark.lss
export PATH=$PATH:$HOME/.local/bin

#### ZSH completion ###
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/thomas/.zshrc'
# include new packages in the completion
zstyle ':completion:*' rehash true

autoload -Uz compinit
compinit

HISTFILE=$HOME/.histfile
HISTSIZE=10000
SAVEHIST=10000

#### Plugins ####
source "$XDG_CONFIG_HOME/zsh/plugins/forgit.plugin.zsh"

# fzf colorscheme
_gen_fzf_default_opts() {
	local base03="234"
	local base02="235"
	local base01="240"
	local base00="241"
	local base0="244"
	local base1="245"
	local base2="254"
	local base3="230"
	local yellow="136"
	local orange="166"
	local red="160"
	local magenta="125"
	local violet="61"
	local blue="33"
	local cyan="37"
	local green="64"

	# Comment and uncomment below for the light theme.

	# Solarized Dark color scheme for fzf
	export FZF_DEFAULT_OPTS="
	  --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
	  --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
	"
	## Solarized Light color scheme for fzf
	#export FZF_DEFAULT_OPTS="
	#  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
	#  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
	#"
}
_gen_fzf_default_opts

#### Options ####
bindkey -v
setopt appendhistory
setopt notify
# type 'dir' instead of 'cd dir'
setopt AUTO_CD
# share histroy between shells
setopt SHARE_HISTORY

# disable annoying beep
unsetopt beep
unsetopt nomatch

# allows to change prompt themes
autoload -Uz promptinit
promptinit
# changes prompt theme to redhat
prompt redhat

# no need to restart terminal after exiting a program
ttyctl -f

# enable history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ctrl-r search history
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

#### Aliases ####
### configurations ###
alias cfg-zshrc='$EDITOR $HOME/.zshrc'
alias cfg-zprofile='$EDITOR $HOME/.zprofile'
alias cfg-gpg='$EDITOR $HOME/.gnupg/gpg.conf'
alias cfg-gpg-agent='$EDITOR $HOME/.gnupg/gpg-agent.conf'
alias cfg-vimrc='$EDITOR $HOME/.vimrc'
alias cfg-nvimrc='$EDITOR $XDG_CONFIG_HOME/nvim/init.vim'
alias cfg-xinitrc='$EDITOR $HOME/.xinitrc'
alias cfg-xinputrc='$EDITOR $HOME/.xinputrc'
alias cfg-xresources='$EDITOR $HOME/.Xresources'
alias cfg-i3='$EDITOR $XDG_CONFIG_HOME/i3/config'
alias cfg-neomutt='$EDITOR $XDG_CONFIG_HOME/neomutt/neomuttrc'
alias cfg-ranger='$EDITOR $XDG_CONFIG_HOME/ranger/rc.conf'
alias cfg-ranger-rifle='$EDITOR $XDG_CONFIG_HOME/ranger/rifle.conf'
alias cfg-grub='$EDITOR /boot/grub/grub.cfg'
alias cfg-tmux='$EDITOR $HOME/.tmux.conf'
alias cfg-polybar='$EDITOR $XDG_CONFIG_HOME/polybar/config'
alias cfg-compton='$EDITOR $XDG_CONFIG_HOME/compton.conf'
alias cfg-dwm='$EDITOR $XDG_CONFIG_HOME/suckless/dwm/config.h'
alias cfg-st='$EDITOR $XDG_CONFIG_HOME/suckless/st/config.h'
alias cfg-newsboat='$EDITOR $HOME/.newsboat/config'
alias cfg-newsboat-urls='$EDITOR $HOME/.newsboat/urls'

### configurations reload ###
alias rld-zshrc='source $HOME/.zshrc'
alias rld-tmux='tmux source-file $HOME/.tmux.conf'
#alias rld-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias rld-xresources='source $HOME/.Xresources'
alias rld-gpg-agent='gpg-connect-agent reloadagent /bye'
alias rld-systemd-daemon='systemctl --user daemon-reload'

### other aliases ###
alias ll='ls -alF'
alias prev="fzf --preview 'bat --color \"always\" {}'" # fuzzy-finder with preview
alias sxiv='sxiv -b -q -a -s f 2>/dev/null' # don't show infobar, be quiet, fit picture to window
alias bc='bc -q -l' # don't show opening message, use math library
alias yt2mp3='youtube-dl -c --restrict-filenames -x --audio-format mp3 -o "%(title)s.%(ext)s"'
alias yup='yay -Syu'
alias pacup='sudo pacman -Syu'
alias pacins='sudo pacman -S'
alias pacrem='sudo pacman -Rs'
# copy with a progress bar.
alias cpv='rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --'
alias rs='rsync -avru --progress'
alias rc='redshift -l 51.165691:10.451526 -r -t 6500K:1500K -b 0.4:1.0'
alias git-branches='git log --graph --decorate --oneline --all'
# previous dotfile management
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias search-files='grep --line-buffered --color=never -r "" * | fzf -e'
alias dl-pdfs='wget -np -nd -A pdf -m -K'
alias mirrorlist-new="curl -s 'https://www.archlinux.org/mirrorlist/?country=AT&country=BE&country=DK&country=FR&country=DE&country=LU&country=NL&country=RO&country=CH&protocol=https&ip_version=4' | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 -"
alias mirrorlist-newest="sudo reflector --country Germany --country France --country Denmark --country Luxembourg --country Romania --country Switzerland --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias toxic-tor='toxic --force-tcp --SOCKS5-proxy 127.0.0.1 9050'
alias wiki='$EDITOR $HOME/Documents/vimwiki/index.md'
alias wiki-git='$EDITOR $HOME/Documents/vimwiki/witcher01.github.io/index.md'
alias compton='compton -b --config $XDG_CONFIG_HOME/compton.conf'
alias eclim='$HOME/.eclipse/org.eclipse.platform_4.15.0_155965261_linux_gtk_x86_64/eclimd'
alias sr='sr -browser=$BROWSERCLI'
alias surfraw='surfraw -browser=$BROWSER'
alias check-mail='new_mail $HOME/mail $XDG_CONFIG_HOME/neomutt/.mailsynclast'
# don't leave mpdas running all the time as listening to something else like spotify messes up scrobbling and what is currently playing
alias mpdas-start='systemctl --user start mpdas'
alias mpdas-stop='systemctl --user stop mpdas'

#### Functions ####
## fzf functions ##
# search history with fzf
fzf_history() {
	zle -I
	RBUFFER=$(cat $HISTFILE | fzf --tac +s | sed 's/ *[0-9]* *//')

	CURSOR=$#BUFFER
}
zle -N fzf_history
bindkey '^F' fzf_history

# append a filename to the buffer, searching through a tree
fzf_prev() {
	zle -I
	# search whole tree, root being $PWD
	RBUFFER=$(find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune -o -type f -print 2> /dev/null | sed 1d | cut -b3- | fzf --preview 'bat --color \"always\" {}')

	# set cursor to the end of the buffer
	CURSOR=$#BUFFER
}
zle -N fzf_prev
bindkey '^P' fzf_prev

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() (
	IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
	[[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
)

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi
	
	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
	fi
}

## general functions ##
# connect to nordvpn vpn server via openvpn udp
vpn() {
	cd /etc/openvpn/nordvpn/
	sudo openvpn "$1.nordvpn.com.udp1194.ovpn"
}

# DESC: cli calculator (Ctrl+D to exit)
# DEMO: http://www.youtube.com/watch?v=JkyodHenTuc
# LINK: http://docs.python.org/library/math.html
calc() {
	if which python3 &>/dev/null; then
		python3 -ic "from math import *; import cmath; from fractions import Fraction"
	elif which python2 &>/dev/null; then
		python2 -ic "from __future__ import division; from math import *; from random import *"
	elif which bc &>/dev/null; then
		bc -q -l
	else
		echo "Requires python2, python3 or bc for calculator features"
	fi
}

# convert video to webm
convert-to-video-webm() {
	if [ $# -lt 1 ]; then
		echo -e "Usage: $0 <filename>"
		echo -e "\nExample:\n$0 file.mp4"
		echo -e "$0 file1.mp4 file2.mp4 file3.mp4"
		echo -e "$0 *.mp4"
		return 1
	fi

	myArray=( "$@" )


	for arg in "${myArray[@]}"; do
		while [ ! -f "${arg%.*}".webm ]; do
			ffmpeg -i "$arg" -codec:v libvpx -crf 10 -b:v 1M -codec:a libvorbis "${arg%.*}".webm
		done
	done
}

# open and mount a luks volume and create folder with volume name in /mnt
luks-open() {
	sudo cryptsetup open "$1" "$2"
	mountpoint="/mnt/$2"
	sudo mkdir "${mountpoint}"
	sudo mount "/dev/mapper/$2" "${mountpoint}"
}

# close and unmount luks volume and delete folder with volume name in /mnt
luks-close() {
	mountpoint="/mnt/$1"
	sudo umount "${mountpoint}"
	sudo rm -r "${mountpoint}"
	sudo cryptsetup close "$1"
}

start-bt() {
	sudo pulseaudio --check || sudo pulseaudio --start --daemonize
	sudo systemctl start bluetooth.service
	bluetoothctl
}

osu() {
	WINEPREFIX="$HOME/.wine-osu" WINEARCH=win32 /opt/wine-osu/bin/wine $HOME/Games/osu\!/osu\!.exe "$@"
}

get_pw() {
	head /dev/urandom | tr -dc A-Za-z0-9 | head -c $1 ; echo ''
}

get_special_pw() {
	#head /dev/urandom | tr -dc '!"§$%&/()=?A-Za-z0-9' | head -c $1 ; echo ''
	gpg --armor --gen-random 2 $1
}

# link by first argument
# video name by second argument
download_m3u8() {
	ffmpeg -protocol_whitelist file,http,https,tcp,tls,cryptio -i "$1" -c copy "$2"
}

# merge multiple pdfs to one
# first argument is the output file name
# second argument are all the pdfs to be merged
merge_pdfs() {
	output_file="$1"
	shift
	gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="$output_file" "$@"
}

unzip_all() {
	for file in ./*
	do
		unzip "${file%%.zip}" -d "${file%%.zip}"
	done
}

# https://github.com/gotbletu/dotfiles_v2/blob/master/normal_user/function/.config/function/functionrc#L1670-L1675
ffcast-fullscreen-videotrack() {
	ffmpeg -f x11grab -r 30 \
		-s $(xwininfo -root | grep 'geometry' |awk '{print $2;}' | cut -d\+ -f1) \
		-i :0.0 -vcodec libx264 -pix_fmt yuv444p -preset ultrafast -crf 0 \
		-threads 0 -y "$1"
}

