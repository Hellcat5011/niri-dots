set -U fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end

abbr in 'sudo pacman -S'
abbr pin 'paru -S'
abbr ss 'sudo pacman -Ss'
abbr sp 'paru -Ss'
abbr update 'sudo pacman -Syyu'
abbr remove 'sudo pacman -Rns'

abbr ls 'eza --icons --color=always'
abbr ll 'eza -al --icons --color=always'
#abbr la 'eza -al --icons --color=always'

#hyprland-specific
abbr hyp 'cd ~/.config/hypr'
abbr usr 'cd ~/.config/hypr/user/'
abbr way 'cd ~/.config/waybar/'
abbr rof 'cd ~/.config/rofi/themes/'
