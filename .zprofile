export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="zen"
export MANPAGER="nvim +Man!"

# export VISUAL=ewrap

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

