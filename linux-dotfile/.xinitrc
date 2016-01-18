#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
export XMODIFIERS="@im=xim"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

exec i3
