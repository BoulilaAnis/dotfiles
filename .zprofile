export EDITOR="vim"
export TERMINAL="st"
export BROWSER="brave"
export MANPAGER="nvim +Man!"
export PATH="$HOME/.local/bin:$PATH"

# export VISUAL=ewrap

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"


# Created by `pipx` on 2024-09-13 13:55:32
export PATH="$PATH:/home/anis/.local/bin"
