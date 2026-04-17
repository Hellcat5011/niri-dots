set -U fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end

alias in="sudo pacman -S"
alias pin="paru -S"
alias ss="sudo pacman -Ss"
alias sp="paru -Ss"
alias update="sudo pacman -Syyu"
alias remove="sudo pacman -Rns"

alias ls="eza --icons --color=always"
alias ll="eza -al --icons --color=always"
#alias la "eza -al --icons --color=always"

#niri-specific
alias nir="cd ~/.config/niri"
alias usr="cd ~/.config/niri/user/"
alias way="cd ~/.config/waybar/"
alias rof="cd ~/.config/rofi/themes/"

alias gdu="gdu --no-delete"
