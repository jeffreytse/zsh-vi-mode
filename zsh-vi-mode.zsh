# zsh-vi-mode.zsh -- A better and friendly vi(vim) mode for Zsh
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
#
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
# ZVM_VI_SURROUND_BINDKEY
# the key binding mode for surround operating (default is 'classic')
#
# 1. 'classic' mode (verb->s->surround):
#   S"    Add " for visual selection
#   ys"   Add " for visual selection
#   cs"'  Change " to '
#   ds"   Delete "
#
# 2. 's-prefix' mode (s->verb->surround):
#   sa"   Add " for visual selection
#   sd"   Delete "
#   sr"'  Change " to '
#
# How to select surround text object?
#   vi"   Select the text object inside the quotes
#   va(   Select the text object including the brackets
#
# Then you can do any operation for the selection:
#
# 1. Add surrounds for text object
#   vi" -> S[ or sa[ => "object" -> "[object]"
#
# 2. Delete/Yank/Change text object
#   di( or vi( -> d
#   ca( or va( -> c
#   yi( or vi( -> y
#
# ZVM_KEYTIMEOUT:
# the key input timeout for waiting for next key (default is 0.3 seconds)
#

# Plugin information
typeset -gr ZVM_NAME='zsh-vi-mode'
typeset -gr ZVM_DESCRIPTION='💻 A better and friendly vi(vim) mode plugin for ZSH.'
typeset -gr ZVM_REPOSITORY='https://github.com/jeffreytse/zsh-vi-mode'
typeset -gr ZVM_VERSION='0.4.0'

# Reduce ESC delay (zle)
# Set to 0.1 second delay between switching modes (default is 0.4 seconds)
export KEYTIMEOUT=1

# Set key input timeout (default is 0.3 seconds)
export ZVM_KEYTIMEOUT=0.3

# Plugin initial status
export ZVM_INIT_DONE=false

# Insert mode could be `i` (insert) or `a` (append)
export ZVM_INSERT_MODE='i'

# The keys typed to invoke this widget, as a literal string
export ZVM_KEYS=''

# Default alternative character for escape space character
ZVM_ESCAPE_SPACE='\s'

# Default cursor styles
ZVM_CURSOR_BLOCK='\e[2 q'
ZVM_CURSOR_BEAM='\e[6 q'
ZVM_CURSOR_BLINKING_BLOCK='\e[1 q'
ZVM_CURSOR_BLINKING_BEAM='\e[5 q'
ZVM_CURSOR_XTERM_BLOCK='\x1b[\x32 q'
ZVM_CURSOR_XTERM_BEAM='\x1b[\x36 q'

# Default settings
if [[ ${TERM:0:5} == 'xterm' ]]; then
  ZVM_VI_NORMAL_MODE_CURSOR=${ZVM_VI_NORMAL_MODE_CURSOR:-$ZVM_CURSOR_XTERM_BLOCK}
  ZVM_VI_INSERT_MODE_CURSOR=${ZVM_VI_INSERT_MODE_CURSOR:-$ZVM_CURSOR_XTERM_BEAM}
else
  ZVM_VI_NORMAL_MODE_CURSOR=${ZVM_VI_NORMAL_MODE_CURSOR:-$ZVM_CURSOR_BLOCK}
  ZVM_VI_INSERT_MODE_CURSOR=${ZVM_VI_INSERT_MODE_CURSOR:-$ZVM_CURSOR_BEAM}
fi

ZVM_VI_INSERT_MODE_LEGACY_UNDO=${ZVM_VI_INSERT_MODE_LEGACY_UNDO:-false}
ZVM_VI_REGION_HIGHLIGHT=${ZVM_VI_REGION_HIGHLIGHT:-'#cc0000'}
ZVM_VI_SURROUND_BINDKEY=${ZVM_VI_SURROUND_BINDKEY:-classic}

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
  local result=$(zle -l "${widget}"; echo $?)
  # Check if the same existing name
  if [[ $result == 0 ]]; then
    local rawfunc=
    result=($(zle -l))
    for ((i=$#result;i>=0;i--)); do
      if [[ ${result[i]} == $widget &&
        ${result[i+1]:0:1} == '(' ]]; then
        rawfunc=${result[i+1]:1:-1}
        break
      fi
    done
    # Wrap raw function
    if [[ $rawfunc ]]; then
      local wrapper="zvm_${widget}-wrapper"
      eval "$wrapper() { $rawfunc; $func; }"
      func=$wrapper
    fi
  fi
  zle -N $widget $func
}

# Default handler for unhandled key events
function zvm_default_handler() {
  local keys=$(zvm_keys)
  case "$KEYMAP" in
    vicmd)
      case "$keys" in
        y*) zvm_range_handler "$keys" true;;
        c*) zvm_range_handler "$keys" true true; zvm_select_vi_mode 'viins';;
        d*) zvm_range_handler "$keys" true true; zvm_select_vi_mode 'viins';;
      esac
      ;;
  esac
}

# Get the keys typed to invoke this widget, as a literal string
function zvm_keys() {
  local keys=${ZVM_KEYS:-$KEYS}
  if [[ $KEYMAP == visual ]]; then
    keys="v${keys}"
  fi
  echo ${keys// /$ZVM_ESCAPE_SPACE}
}

# Find the widget on a specified bindkey
function zvm_find_bindkey_widget() {
  local keymap=$1
  local keys=$2
  local prefix_mode=$3
  local result=
  if [[ -z $prefix_mode ]]; then
    result=$(bindkey -M ${keymap} "$keys")
    if [[ "${result: -14}" == ' undefined-key' ]]; then
      return
    fi
    # Escape spaces in key bindings (space -> $ZVM_ESCAPE_SPACE)
    for ((i=$#result;i>=0;i--)); do
      if [[ "${result:$i:1}" == ' ' ]]; then
        local k=${result:1:$i-2}
        k=${k// /$ZVM_ESCAPE_SPACE}
        result="$k ${result:$i+1}"
        break
      fi
    done
    echo $result
  else
    local widgets=()
    local pos=0
    result=$(bindkey -M ${keymap})
    # Split string to array by newline
    for ((i=0;i<$#result;i++)); do
      if [[ "${result:$i:1}" == $'\n' ]]; then
        local data=${result:$pos:$((i-pos))}
        # Save as new position
        pos=$i+1
        # Check if it has the same prefix keys
        if [[ "${data:1:$#keys}" != "$keys" ]]; then
          continue
        fi
        # Retrieve the widgets
        for ((j=$#data;j>=0;j--)); do
          if [[ "${data:$j:1}" == ' ' ]]; then
            local k=${data:1:$j-2}
            # Escape spaces in key bindings (space -> $ZVM_ESCAPE_SPACE)
            k=${k// /$ZVM_ESCAPE_SPACE}
            widgets+=("$k ${data:$j+1}")
            break
          fi
        done
      fi
    done
    echo $widgets
  fi
}

# Read keys for retrieving widget
function zvm_readkeys() {
  local keymap=$1
  local keys=${2:-$(zvm_keys)}
  local key=
  local widget=
  local result=
  local pattern=
  while :; do
    # Escape space in pattern
    pattern=${keys//$ZVM_ESCAPE_SPACE/ }
    # Find out widgets that match this key pattern
    result=($(zvm_find_bindkey_widget $keymap "$pattern" true))
    # Exit key input if no any more widgets matched
    if [[ -z $result ]]; then
      break
    fi
    # Wait for reading next key
    key=
    if [[ "${result[1]}" == "${keys}" ]]; then
      read -t $ZVM_KEYTIMEOUT -k 1 key
    else
      read -k 1 key
    fi
    # Transform the non-printed characters
    key=$(zvm_escape_non_printed_characters "${key}")
    key=${key// /$ZVM_ESCAPE_SPACE}

    # Escape keys
    # " -> \" It's a special character in bash syntax
    # ` -> \` It's a special character in bash syntax
    key=${key//\"/\\\"}
    key=${key//\`/\\\`}

    keys="${keys}${key}"
    # Get current widget as final one when keytimeout
    if [[ -z "$key" ]]; then
      widget=${result[2]}
      break
    fi
  done
  # Remove escape slash character
  keys=${keys//\\\"/\"}
  keys=${keys//\\\`/\`}
  echo ${keys} $widget
}

# Add key bindings
function zvm_bindkey() {
  local keymap=$1
  local keys=$2
  local widget=$3
  local key=
  # Get the first key (especially check if ctrl characters)
  if [[ $#keys -gt 1 && "${keys:0:1}" == '^' ]]; then
    key=${keys:0:2}
  else
    key=${keys:0:1}
  fi
  local result=($(zvm_find_bindkey_widget $keymap "$key"))
  local rawfunc=${result[2]}
  local wrapper="zvm_${rawfunc}-wrapper"
  # Check if we need to wrap the original widget
  if [[ ! -z $rawfunc && "$rawfunc" != zvm_*-wrapper ]]; then
    eval "$wrapper() { \
      local result=(\$(zvm_readkeys $keymap '${keys:0:1}')); \
      ZVM_KEYS=\${result[1]//${ZVM_ESCAPE_SPACE//\\/\\\\}/ }; \
      if [[ \${#ZVM_KEYS} == 1 ]]; then \
        local widget=$rawfunc; \
      else \
        local widget=\${result[2]}; \
      fi; \
      if [[ -z \${widget} ]]; then \
        zle zvm_default_handler; \
      else \
        zle \$widget; \
        case \${ZVM_KEYS} in \
          c|d|s|y) zle reset-prompt;; \
        esac \
      fi; \
      ZVM_KEYS=; \
    }"
    zle -N $wrapper
    bindkey -M $keymap "${keys:0:1}" $wrapper
  fi
  # We should bind keys with a existing widget
  if [[ $widget ]]; then
    bindkey -M $keymap "${keys}" $widget
  fi
}

# Escape non-printed characters
function zvm_escape_non_printed_characters() {
  local str=
  for ((i=0;i<$#1;i++)); do
    local c=${1:$i:1}
    if [[ "$c" < ' ' ]]; then
      local ord=$(($(printf '%d' "'$c")+64))
      c=$(printf \\$(printf '%03o' $ord))
      str="${str}^${c}"
    elif [[ "$c" == '' ]]; then
      str="${str}^?"
    else
      str="${str}${c}"
    fi
  done
  echo $str
}

# Change cursor with support for inside/outside tmux
function zvm_set_cursor() {
    if [[ -z $TMUX ]]; then
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

# Substitute characters of selection
function zvm_vi_substitue() {
  zle vi-substitute
  zvm_select_vi_mode 'viins'
}

# Yank characters of selection
function zvm_vi_yank() {
  local bpos= epos=
  if (( MARK > CURSOR )) ; then
    bpos=$((CURSOR+1)) epos=$((MARK+1))
  else
    bpos=$MARK epos=$((CURSOR+1))
  fi
  CUTBUFFER=${BUFFER:$bpos:$(($epos-$bpos))}
  zle visual-mode
}

# Handle a range of characters
function zvm_range_handler() {
  local keys=${1}
  local is_yank=${2:-false}
  local is_delete=${3:-false}
  local cursor=$CURSOR
  MARK=$CURSOR
  case "${keys:1}" in
    '^') zle vi-first-non-blank;;
    '$') zle vi-end-of-line;;
    '0') zle vi-digit-or-beginning-of-line;;
    ' ') zle vi-forward-char;;
    'h') zle vi-backward-char;;
    'j') zle down-line-or-history;;
    'k') zle up-line-or-history;;
    'l') zle vi-forward-char;;
    'w') zle vi-forward-word;;
    'e') zle vi-forward-word-end;;
    'b') zle vi-backward-word; cursor=$CURSOR;;
    'f') zle vi-find-next-char;;
    'F') zle vi-find-prev-char; cursor=$CURSOR;;
    't') zle vi-find-next-char-skip;;
    'T') zle vi-find-prev-char-skip; cursor=$CURSOR;;
    'iw') zle select-in-word; cursor=$MARK;;
    'aw') zle select-a-word; cursor=$MARK;;
    *)
      if [[ ${keys:0:1} == ${keys:1:1} ]]; then
        case "${keys:0:1}" in
          y) zle vi-yank-whole-line; is_yank=false;;
          *) MARK=0; CURSOR=$#BUFFER;;
        esac
      fi
      ;;
  esac
  local bpos= epos=
  if (( MARK > CURSOR )) ; then
    bpos=$CURSOR epos=$((MARK+1))
  else
    bpos=$MARK epos=$((CURSOR+1))
  fi
  if [[ $is_yank == true ]]; then
    CUTBUFFER=${BUFFER:$bpos:$(($epos-$bpos))}
  fi
  if [[ $is_delete == true ]]; then
    BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
    CURSOR=$bpos
  fi
  CURSOR=$cursor
}

# Get the substr position in a string
function zvm_substr_pos() {
  local pos=-1
  local len=${#1}
  local slen=${#2}
  local i=${3:-0}
  local forward=${4:-true}
  local init=${i:-$($forward && echo "$i" || echo "i=$len-1")}
  local condition=$($forward && echo "i<$len" || echo "i>=0")
  local step=$($forward && echo 'i++' || echo 'i--')
  for (($init;$condition;$step)); do
    if [[ ${1:$i:$slen} == "$2" ]]; then
      pos=$i
      break
    fi
  done
  echo $pos
}

# Parse surround from keys
function zvm_parse_surround_keys() {
  local keys=${1:-${$(zvm_keys)//$ZVM_ESCAPE_SPACE/ }}
  local action=
  local surround=
  case "${keys}" in
    S*) action=S; surround=${keys:1:1};;
    s[adr]*) action=${keys:1:1}; surround=${keys:2:1};;
    [acdy]s*) action=${keys:0:1}; surround=${keys:2:1};;
    [cdvy][ia]*) action=${keys:0:2}; surround=${keys:2:1};;
  esac
  echo $action ${surround// /$ZVM_ESCAPE_SPACE}
}

# Move around code structure (e.g. (..), {..})
function zvm_move_around_surround() {
  local slen=
  local bpos=-1
  local epos=-1
  for ((i=$CURSOR;i>=0;i--)); do
    # Check if it's one of the surrounds
    for s in {\',\",\`,\(,\[,\{,\<}; do
      slen=${#s}
      if [[ ${BUFFER:$i:$slen} == "$s" ]]; then
        bpos=$i
        break
      fi
    done
    if (($bpos == -1)); then
      continue
    fi
    # Search the nearest surround
    local ret=($(zvm_search_surround "$s"))
    if [[ -z ${ret[@]} ]]; then
      continue
    fi
    bpos=${ret[1]}
    epos=${ret[2]}
    # Move between the openning and close surrounds
    if (( $CURSOR > $((bpos-1)) )) && (( $CURSOR < $((bpos+slen)) )); then
      CURSOR=$epos
    else
      CURSOR=$bpos
    fi
    break
  done
}

# Match the surround pair from the part
function zvm_match_surround() {
  local bchar=${1// /$ZVM_ESCAPE_SPACE}
  local echar=$bchar
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
  local bchar=${${ret[1]//$ZVM_ESCAPE_SPACE/ }:- }
  local echar=${${ret[2]//$ZVM_ESCAPE_SPACE/ }:- }
  local bpos=$(zvm_substr_pos $BUFFER $bchar $CURSOR false)
  local epos=$(zvm_substr_pos $BUFFER $echar $CURSOR true)
  if [[ $bpos == $epos ]]; then
      epos=$(zvm_substr_pos $BUFFER $echar $((CURSOR+1)) true)
      if [[ $epos == -1 ]]; then
        epos=$(zvm_substr_pos $BUFFER $echar $((CURSOR-1)) false)
        if [[ $epos != -1 ]]; then
          local tmp=$epos; epos=$bpos; bpos=$tmp
        fi
      fi
  fi
  if [[ $bpos == -1 ]] || [[ $epos == -1 ]]; then
    return
  fi
  echo $bpos $epos $bchar $echar
}

# Select surround and highlight it in visual mode
function zvm_select_surround() {
  zvm_select_vi_mode 'visual'
  local ret=($(zvm_parse_surround_keys))
  local action=${ret[1]}
  local surround=${ret[2]//$ZVM_ESCAPE_SPACE/ }
  ret=($(zvm_search_surround ${surround}))
  if [[ ${#ret[@]} == 0 ]]; then
    zvm_select_vi_mode 'vicmd'
    return
  fi
  local bpos=${ret[1]}
  local epos=${ret[2]}
  if [[ ${action:1:1} == 'i' ]]; then
    ((bpos++))
  else
    ((epos++))
  fi
  MARK=$bpos; CURSOR=$epos-1
  region_highlight+=("$bpos $epos bg=$ZVM_VI_REGION_HIGHLIGHT")
  zle -R
  local key=
  read -k 1 key
  # Prepare handle
  case $key in
    d|c|s)
      CUTBUFFER=${BUFFER:$bpos:$(($epos-$bpos))}
      BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
      CURSOR=$bpos
      ;;
    p)
      local cutbuffer=${BUFFER:$bpos:$(($epos-$bpos))}
      BUFFER="${BUFFER:0:$bpos}${CUTBUFFER}${BUFFER:$epos}"
      CUTBUFFER=$cutbuffer
      CURSOR=$bpos
      ;;
    S)
      read -k 1 surround
      zvm_change_surround $key $surround $bpos $epos
      ;;
    y)
      read -t $ZVM_KEYTIMEOUT -k 1 key
      case "$key" in
        '') CUTBUFFER=${BUFFER:$bpos:$(($epos-$bpos))};;
        s)
          read -k 1 surround
          zvm_change_surround y $surround $bpos $epos
          ;;
      esac
      ;;
    s)
      read -k 1 key
      case "$key" in
        a)
          read -k 1 surround
          zvm_change_surround y $surround $bpos $epos
          ;;
      esac
      ;;
    u) zle vi-down-case;;
    U) zle vi-up-case;;
  esac
  # Post handle
  region_highlight=("${region_highlight[@]:0:-1}")
  case $key in
    c) zvm_select_vi_mode 'viins';;
    *) zvm_select_vi_mode 'vicmd';;
  esac
}

# Change surround in vicmd or visual mode
function zvm_change_surround() {
  local ret=($(zvm_parse_surround_keys))
  local action=${1:-${ret[1]}}
  local surround=${2:-${ret[2]//$ZVM_ESCAPE_SPACE/ }}
  local bpos=${3} epos=${4}
  local is_appending=
  case $action in
    S|y|a) is_appending=1;;
  esac
  if [[ $is_appending ]]; then
    if [[ -z $bpos && -z $epos ]]; then
      if (( MARK > CURSOR )) ; then
        bpos=$CURSOR+1 epos=$MARK+1
      else
        bpos=$MARK epos=$CURSOR+1
      fi
    fi
  else
    ret=($(zvm_search_surround "$surround"))
    (( ${#ret[@]} )) || return
    bpos=${ret[1]}
    epos=${ret[2]}
    region_highlight+=("$bpos $(($bpos+1)) bg=$ZVM_VI_REGION_HIGHLIGHT")
    region_highlight+=("$epos $(($epos+1)) bg=$ZVM_VI_REGION_HIGHLIGHT")
    zle -R
  fi
  local key=
  case $action in
    c|r) read -k 1 key;;
    S|y|a)
      key=$surround
      [[ -z $@ ]] && zle visual-mode
      zvm_select_vi_mode 'vicmd'
      ;;
  esac
  if [[ -z $is_appending ]]; then
    region_highlight=("${region_highlight[@]:0:-2}")
  fi
  # Check if canceling changing surround
  [[ $key == '' ]] && return
  # Start changing surround
  ret=($(zvm_match_surround "$key"))
  local bchar=${${ret[1]//$ZVM_ESCAPE_SPACE/ }:-$key}
  local echar=${${ret[2]//$ZVM_ESCAPE_SPACE/ }:-$key}
  local value=$([[ $is_appending ]] && echo 0 || echo 1 )
  local head=${BUFFER:0:$bpos}
  local body=${BUFFER:$((bpos+value)):$((epos-(bpos+value)))}
  local foot=${BUFFER:$((epos+value))}
  BUFFER="${head}${bchar}${body}${echar}${foot}"
}

# Change surround text object
function zvm_change_surround_text_object() {
  local ret=($(zvm_parse_surround_keys))
  local action=${ret[1]}
  local surround=${ret[2]//$ZVM_ESCAPE_SPACE/ }
  ret=($(zvm_search_surround "${surround}"))
  if [[ ${#ret[@]} == 0 ]]; then
    zvm_select_vi_mode 'vicmd'
    return
  fi
  local bpos=${ret[1]}
  local epos=${ret[2]}
  if [[ ${action:1:1} == 'i' ]]; then
    ((bpos++))
  else
    ((epos++))
  fi
  CUTBUFFER=${BUFFER:$bpos:$(($epos-$bpos))}
  case ${action:0:1} in
    c)
      BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
      CURSOR=$bpos
      zvm_select_vi_mode 'viins'
      ;;
    d)
      BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
      CURSOR=$bpos
      ;;
  esac
}

# Enter the visual mode
function zvm_enter_visual_mode() {
  zvm_select_vi_mode 'visual'
  zle -K vicmd
}

# Exit the visual mode
function zvm_exit_visual_mode() {
  zle visual-mode
  zvm_select_vi_mode 'vicmd'
}

# Enter the vi insert mode
function zvm_enter_insert_mode() {
  zvm_select_vi_mode 'viins'
  if [[ $(zvm_keys) == 'i' ]]; then
    ZVM_INSERT_MODE='i'
  else
    CURSOR=$CURSOR+1
    ZVM_INSERT_MODE='a'
  fi
}

# Exit the vi insert mode
function zvm_exit_insert_mode() {
  zvm_select_vi_mode 'vicmd'
  CURSOR=$CURSOR-1
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

# Select vi mode
function zvm_select_vi_mode() {
  case $1 in
    vicmd) zle -K vicmd; zle vi-cmd-mode;;
    viins) zle -K viins; zle vi-insert;;
    visual) zle -K visual; zle visual-mode;;
  esac
  zle reset-prompt
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
  zvm_define_widget zvm_default_handler
  zvm_define_widget zvm_backward_kill_line
  zvm_define_widget zvm_forward_kill_line
  zvm_define_widget zvm_kill_line
  zvm_define_widget zvm_viins_undo
  zvm_define_widget zvm_select_surround
  zvm_define_widget zvm_change_surround
  zvm_define_widget zvm_move_around_surround
  zvm_define_widget zvm_change_surround_text_object
  zvm_define_widget zvm_enter_insert_mode
  zvm_define_widget zvm_exit_insert_mode
  zvm_define_widget zvm_enter_visual_mode
  zvm_define_widget zvm_exit_visual_mode
  zvm_define_widget zvm_vi_substitue
  zvm_define_widget zvm_vi_yank

  # Override standard widgets
  zvm_define_widget zle-keymap-select zvm_zle-keymap-select
  zvm_define_widget zle-line-pre-redraw zvm_zle-line-pre-redraw

  # Ensure insert mode cursor when exiting vim
  zvm_define_widget zle-line-init zvm_zle-line-init

  # All Key bindings
  # Emacs-like bindings
  # Normal editing
  zvm_bindkey viins '^A' beginning-of-line
  zvm_bindkey viins '^E' end-of-line
  zvm_bindkey viins '^B' backward-char
  zvm_bindkey viins '^F' forward-char
  zvm_bindkey viins '^K' zvm_forward_kill_line
  zvm_bindkey viins '^U' zvm_viins_undo
  zvm_bindkey viins '^W' backward-kill-word
  zvm_bindkey viins '^Y' yank
  zvm_bindkey viins '^_' undo

  # History search
  zvm_bindkey viins '^R' history-incremental-search-backward
  zvm_bindkey viins '^S' history-incremental-search-forward
  zvm_bindkey viins '^P' up-line-or-history
  zvm_bindkey viins '^N' down-line-or-history

  # Fix the cursor position when exiting insert mode
  zvm_bindkey vicmd 'i'  zvm_enter_insert_mode
  zvm_bindkey vicmd 'a'  zvm_enter_insert_mode
  zvm_bindkey viins '^[' zvm_exit_insert_mode

  # Other key bindings
  zvm_bindkey vicmd  's'  zvm_vi_substitue
  zvm_bindkey vicmd  'v'  zvm_enter_visual_mode
  zvm_bindkey visual '^[' zvm_exit_visual_mode
  zvm_bindkey visual 'y'  zvm_vi_yank

  for c in {y,d,c}{i,a}w; do
    zvm_bindkey vicmd "$c" zvm_default_handler
  done

  # Surround text-object
  # Enable surround text-objects (quotes, brackets)

  local surrounds=()
  # Append brackets
  for s in ${(s..)^:-'()[]{}<>'}; do
    surrounds+=($s)
  done
  # Append quotes
  for s in {\',\",\`,\ ,'^['}; do
    surrounds+=($s)
  done

  # Surround key bindings
  for s in $surrounds; do
    for c in {a,i}${s}; do
      zvm_bindkey visual "$c" zvm_select_surround
    done
    for c in {c,d,y}{a,i}${s}; do
      zvm_bindkey vicmd "$c" zvm_change_surround_text_object
    done
    if [[ $ZVM_VI_SURROUND_BINDKEY == 's-prefix' ]]; then
      for c in s{d,r}${s}; do
        zvm_bindkey vicmd "$c" zvm_change_surround
      done
      for c in sa${s}; do
        zvm_bindkey visual "$c" zvm_change_surround
      done
    else
      for c in {d,c}s${s}; do
        zvm_bindkey vicmd "$c" zvm_change_surround
      done
      for c in {S,ys}${s}; do
        zvm_bindkey visual "$c" zvm_change_surround
      done
    fi
  done

  # Moving around surrounds
  zvm_bindkey vicmd "%" zvm_move_around_surround

  # Fix BACKSPACE was stuck in zsh
  # Since normally '^?' (backspace) is bound to vi-backward-delete-char
  zvm_bindkey viins "^?" backward-delete-char

  # Enable vi keymap
  bindkey -v
}

# Precmd function
function zvm_precmd_function() {
  # Init zsh vi mode  when starting new command line at first time
  if ! $ZVM_INIT_DONE; then
    ZVM_INIT_DONE=true
    zvm_init
  fi
  # Set insert mode cursor when starting new command line
  zvm_set_insert_mode_cursor
}

# Initialize the plugin when starting new command line
precmd_functions+=(zvm_precmd_function)

