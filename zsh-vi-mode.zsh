# vi-mode.zsh -- vi mode for Zsh
# Copyright © 2020 Jeffrey Tse
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# All Settings
# Set these variables before sourcing this file.
#
# ZVM_VI_NORMAL_MODE_CURSOR:
# the prompt cursor in vi normal mode
#
# ZVM_VI_INSERT_MODE_CURSOR:
# the prompt cursor in vi insert mode
#
# ZVM_VI_INSERT_MODE_LEGACY_UNDO:
# using legacy undo behavior in vi insert mode
#


# Reduce ESC delay
# Set to 0.1 second delay between switching modes (default is 0.4 seconds)
export KEYTIMEOUT=1

# Plugin initial status
ZVM_INIT_DONE=false

# Default cursor styles
ZVM_CURSOR_BLOCK='\e[2 q'
ZVM_CURSOR_BEAM='\e[6 q'
ZVM_CURSOR_BLINKING_BLOCK='\e[1 q'
ZVM_CURSOR_BLINKING_BEAM='\e[5 q'
ZVM_CURSOR_XTERM_BLOCK='\e]50;CursorShape=0\x7'
ZVM_CURSOR_XTERM_BEAM='\e]50;CursorShape=1\x7'

# Default settings
if [[ ${TERM:0:5} == 'xterm' ]]; then
  ZVM_VI_NORMAL_MODE_CURSOR=$ZVM_CURSOR_XTERM_BLOCK
  ZVM_VI_INSERT_MODE_CURSOR=$ZVM_CURSOR_XTERM_BEAM
else
  ZVM_VI_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VI_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
fi

ZVM_VI_INSERT_MODE_LEGACY_UNDO=false


# Define widget function
function zvm_define_widget() {
  local widget=$1
  local func=$2 || $1
  local result=$(zle -l | grep "^${widget}")
  local rawfunc=$(grep -oP '(?<=\().*(?=\))' <<< "$result")
  if [[ $rawfunc ]]; then
    local wrapper="zvm_${widget}-wrapper"
    eval "$wrapper() { $rawfunc; $func; }"
    func=$wrapper
  fi
  zle -N $widget $func
}

# Change cursor with support for inside/outside tmux
function zvm_set_cursor() {
    if [[ $TMUX == '' ]]; then
      echo -ne $1
    else
      echo -ne "\ePtmux;\e\e$1\e\\"
    fi
}

# Change to normal cursor
function zvm_set_normal_mode_cursor() {
  zvm_set_cursor $ZVM_VI_NORMAL_MODE_CURSOR
}

# Change to beam/pipe cursor
function zvm_set_insert_mode_cursor() {
  zvm_set_cursor $ZVM_VI_INSERT_MODE_CURSOR
}

# Change cursor style
function zvm_change_cursor_style() {
  case $1 in
    # normal mode cursor in normal and visual mode
    vicmd) zvm_set_normal_mode_cursor;;
    # insert mode cursor in insert mode
    main|viins) zvm_set_insert_mode_cursor;;
    # Else normal cursor
    *) zvm_set_normal_mode_cursor;;
  esac
}

# Remove all characters between the cursor position and the
# beginning of the line.
function zvm_backward_kill_line() {
  BUFFER=${BUFFER:$CURSOR:$#BUFFER}
  CURSOR=0
}

# Remove all characters between the cursor position and the
# end of the line.
function zvm_forward_kill_line() {
  BUFFER=${BUFFER:0:$CURSOR}
}

# Remove all characters of the line.
function zvm_kill_line() {
  BUFFER=
}

# Undo action in vi insert mode
#
# CTRL-U  Remove all characters between the cursor position and
#         the beginning of the line.  Previous versions of vim
#         deleted all characters on the line.
function zvm_viins_undo() {
  if [[ $ZVM_VI_INS_LEGACY_UNDO ]]; then
    zvm_kill_line
  else
    zvm_backward_kill_line
  fi
}

# Updates editor information when the keymap changes
function zvm_zle-keymap-select() {
  zvm_change_cursor_style $KEYMAP
}

# Updates editor information when line pre redraw
function zvm_zle-line-pre-redraw() {
  # Change cursor style
  zvm_change_cursor_style $KEYMAP
}

# Start every prompt in insert mode
function zvm_zle-line-init() {
  zle -K viins
  zvm_set_insert_mode_cursor
}

# Initialize vi mode
function zvm_init() {
  # Create User-defined widgets
  zvm_define_widget zvm_backward_kill_line
  zvm_define_widget zvm_forward_kill_line
  zvm_define_widget zvm_kill_line
  zvm_define_widget zvm_viins_undo

  # Override standard widgets
  zvm_define_widget zle-keymap-select zvm_zle-keymap-select
  zvm_define_widget zle-line-pre-redraw zvm_zle-line-pre-redraw

  # Ensure insert mode cursor when exiting vim
  zvm_define_widget zle-line-init zvm_zle-line-init

  # All Key bindings
  # Emacs-like bindings
  # Normal editing
  bindkey -M viins '^A' beginning-of-line
  bindkey -M viins '^E' end-of-line
  bindkey -M viins '^B' backward-char
  bindkey -M viins '^F' forward-char
  bindkey -M viins '^K' zvm_forward_kill_line
  bindkey -M viins '^U' zvm_viins_undo
  bindkey -M viins '^W' backward-kill-word
  bindkey -M viins '^Y' yank
  bindkey -M viins '^_' undo

  # History search
  bindkey -M viins '^R' history-incremental-search-backward
  bindkey -M viins '^S' history-incremental-search-forward
  bindkey -M viins '^P' up-line-or-history
  bindkey -M viins '^N' down-line-or-history

  # Fix BACKSPACE was stuck in zsh
  # Since normally '^?' (backspace) is bound to vi-backward-delete-char
  bindkey -v '^?' backward-delete-char

  # Enable vi keymap
  bindkey -v
}

# Precmd function
function zvm_precmd_function() {
  # Init zsh vi mode  when starting new command line at first time
  if ! $ZVM_INIT_DONE; then
    ZVM_INIT_DONE=true; zvm_init
  fi
  # Set insert mode cursor when starting new command line
  zvm_set_insert_mode_cursor
}

# Init plugin starting new command line
precmd_functions+=( zvm_precmd_function )

