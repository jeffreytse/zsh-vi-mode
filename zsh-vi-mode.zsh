# zsh-vi-mode.zsh -- better vi mode for Zsh
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
# ZVM_VI_REGION_HIGHLIGHT:
# the behavior of region (surround objects) in vi mode
#
# For example:
#   ZVM_VI_REGION_HIGHLIGHT=red      # Color name
#   ZVM_VI_REGION_HIGHLIGHT=#ff0000  # Hex value
#

# Plugin information
declare -gr ZVM_NAME='zsh-vi-mode'
declare -gr ZVM_DESCRIPTION='💻 A better and friendly vi(vim) mode plugin for ZSH.'
declare -gr ZVM_REPOSITORY='https://github.com/jeffreytse/zsh-vi-mode'
declare -gr ZVM_VERSION='0.2.0'

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
ZVM_CURSOR_XTERM_BLOCK='\x1b[\x32 q'
ZVM_CURSOR_XTERM_BEAM='\x1b[\x36 q'

# Default settings
if [[ ${TERM:0:5} == 'xterm' ]]; then
  ZVM_VI_NORMAL_MODE_CURSOR=$ZVM_CURSOR_XTERM_BLOCK
  ZVM_VI_INSERT_MODE_CURSOR=$ZVM_CURSOR_XTERM_BEAM
else
  ZVM_VI_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VI_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
fi

ZVM_VI_INSERT_MODE_LEGACY_UNDO=false
ZVM_VI_REGION_HIGHLIGHT='#cc0000'


# Display version information
function zvm_version() {
  echo -e "$ZVM_NAME $ZVM_VERSION"
  echo -e "\e[4m$ZVM_REPOSITORY\e[0m"
  echo -e "$ZVM_DESCRIPTION"
}

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

# Get the character position in a string
function zvm_charpos() {
  local pos=-1
  local len=${#1}
  local i=${3:-0}
  local forward=${4:-true}
  local init=${i:-$($forward && echo "$i" || echo "i=$len-1")}
  local condition=$($forward && echo "i<$len" || echo "i>=0")
  local step=$($forward && echo 'i++' || echo 'i--')
  for (($init;$condition;$step)); do
    if [[ ${1:$i:1} == "$2" ]]; then
      pos=$i
      break
    fi
  done
  echo $pos
}

# Match the surround pair from the part
function zvm_match_surround() {
  local bchar=$1
  local echar=$1
  case $bchar in
    '(') echar=')';;
    '[') echar=']';;
    '{') echar='}';;
    '<') echar='>';;
    ')') bchar='(';echar=')';;
    ']') bchar='[';echar=']';;
    '}') bchar='{';echar='}';;
    '>') bchar='<';echar='>';;
  esac
  echo $bchar $echar
}

# Search surround from the string
function zvm_search_surround() {
  local ret=($(zvm_match_surround "$1"))
  local bchar=${ret[1]:- }
  local echar=${ret[2]:- }
  local bpos=$(zvm_charpos $BUFFER $bchar $CURSOR false)
  local epos=$(zvm_charpos $BUFFER $echar $CURSOR true)
  if [[ $bpos == -1 ]] || [[ $epos == -1 ]]; then
    return 1
  fi
  echo $bpos $epos
}

# Select surround and highlight it in visual mode
function zvm_select_surround() {
  local ret=($(zvm_search_surround ${KEYS:1:1}))
  if [[ ${#ret[@]} == 0 ]]; then
    # Exit visual-mode
    zle visual-mode
    return 1
  fi
  local bpos=${ret[1]}
  local epos=${ret[2]}
  if [[ ${KEYS:0:1} == 'i' ]]; then
    ((bpos++))
  else
    ((epos++))
  fi
  region_highlight+=("$bpos $epos bg=$ZVM_VI_REGION_HIGHLIGHT")
  zle -R
  local key=
  read -k 1 key
  # Prepare handle
  case $key in
    d|c|y) CUTBUFFER=${BUFFER:$bpos:$(($epos-$bpos))};;
  esac
  case $key in
    d|c)
      BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
      CURSOR=$bpos
      ;;
    p)
      local cutbuffer=${BUFFER:$bpos:$(($epos-$bpos))}
      BUFFER="${BUFFER:0:$bpos}${CUTBUFFER}${BUFFER:$epos}";
      CUTBUFFER=$cutbuffer
      CURSOR=$bpos
      ;;
    s)
      local action= surround=
      read -k 1 action; read -k 1 surround
      if [[ $action == 'a' ]]; then
        zvm_change_surround $action $surround $bpos $epos
        zle visual-mode
      fi
      ;;
  esac
  # Post handle
  zle visual-mode
  region_highlight=()
  case $key in
    c) zle vi-insert;;
  esac
}

# Change surround in vicmd or visual mode
function zvm_change_surround() {
  local action=${1:-${KEYS:1:1}}
  local surround=${2:-${KEYS:2:1}}
  local bpos=${3} epos=${4}
  if [[ $action == 'a' ]]; then
    if [[ $bpos == '' ]] && [[ $epos == '' ]]; then
      if (( MARK > CURSOR )) ; then
        bpos=$CURSOR+1 epos=$MARK+1
      else
        bpos=$MARK epos=$CURSOR+1
      fi
    fi
  else
    local ret=($(zvm_search_surround $surround))
    (( ${#ret[@]} )) || return 1
    bpos=${ret[1]}
    epos=${ret[2]}
    region_highlight+=("$bpos $(($bpos+1)) bg=$ZVM_VI_REGION_HIGHLIGHT")
    region_highlight+=("$epos $(($epos+1)) bg=$ZVM_VI_REGION_HIGHLIGHT")
    zle -R
  fi
  local key=
  case $action in
    r) read -k 1 key;;
    a) key=$surround;;
  esac
  local ret=($(zvm_match_surround $key))
  local bchar=${ret[1]:-$key}
  local echar=${ret[2]:-$key}
  local value=$([[ $action == a ]] && echo 0 || echo 1 )
  local head=${BUFFER:0:$bpos}
  local body=${BUFFER:$((bpos+value)):$((epos-(bpos+value)))}
  local foot=${BUFFER:$((epos+value))}
  BUFFER="${head}${bchar}${body}${echar}${foot}"
  zle visual-mode;
  region_highlight=()
}

# Exit the mode in vi insert mode
# Fix the curosr backward when exiting insert mode
function zvm_exit_insert_mode() {
  zle vi-cmd-mode
  CURSOR=$CURSOR+1
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

# Initialize vi-mode for widgets, keybindings, etc.
function zvm_init() {
  # Create User-defined widgets
  zvm_define_widget zvm_backward_kill_line
  zvm_define_widget zvm_forward_kill_line
  zvm_define_widget zvm_kill_line
  zvm_define_widget zvm_viins_undo
  zvm_define_widget zvm_exit_insert_mode
  zvm_define_widget zvm_select_surround
  zvm_define_widget zvm_change_surround

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
  bindkey -M viins '^[' zvm_exit_insert_mode

  # History search
  bindkey -M viins '^R' history-incremental-search-backward
  bindkey -M viins '^S' history-incremental-search-forward
  bindkey -M viins '^P' up-line-or-history
  bindkey -M viins '^N' down-line-or-history

  # Surround text-object
  # Enable surround text-objects (quotes, brackets)
  # Remove default key bindings of 's' in vicmd mode
  bindkey -M vicmd -r 's'

  # Keybindings for brackets
  for s in ${(s..)^:-'()[]{}<>bB'}; do
    for c in {a,i}${s}; do
      bindkey -M visual "$c" zvm_select_surround
    done
    for c in s{d,r}${s}; do
      bindkey -M vicmd "$c" zvm_change_surround
    done
    for c in sa${s}; do
      bindkey -M visual "$c" zvm_change_surround
      bindkey -M vicmd "$c" zvm_change_surround
    done
  done

  # Keybindings for quotes
  for s in {\',\",\`,\ }; do
    for c in {a,i}${s}; do
      bindkey -M visual "$c" zvm_select_surround
    done
    for c in s{d,r}${s}; do
      bindkey -M vicmd "$c" zvm_change_surround
    done
    for c in sa${s}; do
      bindkey -M visual "$c" zvm_change_surround
      bindkey -M vicmd "$c" zvm_change_surround
    done
  done

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

