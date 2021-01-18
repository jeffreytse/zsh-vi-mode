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
# ZVM_VI_ESCAPE_BINDKEY
# the vi escape key (default is ^[ => <ESC>), you can set it to whatever
# you like, such as `jj`, `jk` and so on.
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
# ZVM_VI_HIGHLIGHT_BACKGROUND:
# the behavior of highlight (surrounds, visual-line, etc) in vi mode
#
# For example:
#   ZVM_VI_HIGHLIGHT_BACKGROUND=red      # Color name
#   ZVM_VI_HIGHLIGHT_BACKGROUND=#ff0000  # Hex value
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
# ZVM_LAZY_KEYBINDINGS:
# the setting for lazy keybindings (default is true), and lazy keybindings
# will postpone the keybindings of vicmd and visual keymaps to the first
# time entering normal mode
#

# Plugin information
typeset -gr ZVM_NAME='zsh-vi-mode'
typeset -gr ZVM_DESCRIPTION='💻 A better and friendly vi(vim) mode plugin for ZSH.'
typeset -gr ZVM_REPOSITORY='https://github.com/jeffreytse/zsh-vi-mode'
typeset -gr ZVM_VERSION='0.5.0'

# Reduce ESC delay (zle)
# Set to 0.1 second delay between switching modes (default is 0.4 seconds)
KEYTIMEOUT=1

# Plugin initial status
ZVM_INIT_DONE=false

# Disable reset prompt (i.e. disable the widget `reset-prompt`)
ZVM_RESET_PROMPT_DISABLED=false

# Insert mode could be `i` (insert) or `a` (append)
ZVM_INSERT_MODE='i'

# The mode could be the below value:
# `n` (normal)
# `i` (insert)
# `v` (visual)
# `vl` (visual-line)
ZVM_MODE=''

# The keys typed to invoke this widget, as a literal string
ZVM_KEYS=''

# The region hilight information
ZVM_REGION_HIGHLIGHT=()

# Default alternative character for escape space character
ZVM_ESCAPE_SPACE='\s'

# Default vi modes
ZVM_MODE_NORMAL='n'
ZVM_MODE_INSERT='i'
ZVM_MODE_VISUAL='v'
ZVM_MODE_VISUAL_LINE='vl'

# Default cursor styles
ZVM_CURSOR_BLOCK='\e[2 q'
ZVM_CURSOR_BEAM='\e[6 q'
ZVM_CURSOR_BLINKING_BLOCK='\e[1 q'
ZVM_CURSOR_BLINKING_BEAM='\e[5 q'
ZVM_CURSOR_XTERM_BLOCK='\x1b[\x32 q'
ZVM_CURSOR_XTERM_BEAM='\x1b[\x36 q'

##########################################
# Initial all default settings

# Set key input timeout (default is 0.3 seconds)
ZVM_KEYTIMEOUT=${ZVM_KEYTIMEOUT:-0.3}

# Set keybindings mode (default is true)
# The lazy keybindings will post the keybindings of vicmd and visual
# keymaps to the first time entering the normal mode
ZVM_LAZY_KEYBINDINGS=${ZVM_LAZY_KEYBINDINGS:-true}

# All keybindings for lazy loading
if $ZVM_LAZY_KEYBINDINGS; then
  ZVM_LAZY_KEYBINDINGS_LIST=()
fi

# Set the sursor stlye of defferent vi modes
if [[ ${TERM:0:5} == 'xterm' ]]; then
  ZVM_VI_NORMAL_MODE_CURSOR=${ZVM_VI_NORMAL_MODE_CURSOR:-$ZVM_CURSOR_XTERM_BLOCK}
  ZVM_VI_INSERT_MODE_CURSOR=${ZVM_VI_INSERT_MODE_CURSOR:-$ZVM_CURSOR_XTERM_BEAM}
else
  ZVM_VI_NORMAL_MODE_CURSOR=${ZVM_VI_NORMAL_MODE_CURSOR:-$ZVM_CURSOR_BLOCK}
  ZVM_VI_INSERT_MODE_CURSOR=${ZVM_VI_INSERT_MODE_CURSOR:-$ZVM_CURSOR_BEAM}
fi

# Set the vi escape key (default is ^[ => <ESC>)
ZVM_VI_ESCAPE_BINDKEY=${ZVM_VI_ESCAPE_BINDKEY:-^[}

ZVM_VI_INSERT_MODE_LEGACY_UNDO=${ZVM_VI_INSERT_MODE_LEGACY_UNDO:-false}
ZVM_VI_SURROUND_BINDKEY=${ZVM_VI_SURROUND_BINDKEY:-classic}
ZVM_VI_HIGHLIGHT_BACKGROUND=${ZVM_VI_HIGHLIGHT_BACKGROUND:-#cc0000}

# All the extra commands
zvm_before_init_commands=()
zvm_after_init_commands=()
zvm_before_select_vi_mode_commands=()
zvm_after_select_vi_mode_commands=()
zvm_before_lazy_keybindings_commands=()
zvm_after_lazy_keybindings_commands=()

# All the handlers for switching keyword
zvm_switch_keyword_handlers=(
  zvm_switch_number
  zvm_switch_boolean
  zvm_switch_weekday
  zvm_switch_month
)

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
  local result=($(zle -l -L "${widget}"))
  # Check if existing the same name
  if [[ ${#result[@]} == 4 ]]; then
    local rawfunc=${result[4]}
    local wrapper="zvm_${widget}-wrapper"
    eval "$wrapper() { $rawfunc; $func; }"
    func=$wrapper
  fi
  zle -N $widget $func
}

# Default handler for unhandled key events
function zvm_default_handler() {
  local keys=$(zvm_keys)
  case "$KEYMAP" in
    vicmd)
      case "$keys" in
        [cdy]*) zvm_range_handler "$keys";;
        *)
          for ((i=0;i<$#keys;i++)) do
            zvm_navigation_handler ${keys:$i:1}
            zvm_highlight
          done
          ;;
      esac
      ;;
    viins|main)
      for ((i=0;i<$#keys;i++)) do
        BUFFER="${BUFFER:0:$CURSOR}${keys:$i:1}${BUFFER:$CURSOR}"
        CURSOR=$((CURSOR+1))
        zle redisplay
      done
      ;;
    visual)
      ;;
  esac
}

# Get the keys typed to invoke this widget, as a literal string
function zvm_keys() {
  local keys=${ZVM_KEYS:-$(zvm_escape_non_printed_characters "$KEYS")}

  # Append the prefix of keys if it is visual or visual-line mode
  case "${ZVM_MODE}" in
    $ZVM_MODE_VISUAL) keys="v${keys}";;
    $ZVM_MODE_VISUAL_LINE) keys="V${keys}";;
  esac

  echo ${keys// /$ZVM_ESCAPE_SPACE}
}

# Find the widget on a specified bindkey
function zvm_find_bindkey_widget() {
  local keymap=$1
  local keys=$2
  local prefix_mode=$3

  if [[ -z $prefix_mode ]]; then
    local result=$(bindkey -M ${keymap} "$keys")
    if [[ "${result: -14}" == ' undefined-key' ]]; then
      return
    fi

    # Escape spaces in key bindings (space -> $ZVM_ESCAPE_SPACE)
    for ((i=$#result;i>=0;i--)); do

      # Backward find the first whitespace character
      [[ "${result:$i:1}" == ' ' ]] || continue

      # Retrieve the keys and widget
      local k=${result:1:$i-2}

      # Escape spaces in key bindings (space -> $ZVM_ESCAPE_SPACE)
      k=${k// /$ZVM_ESCAPE_SPACE}
      result="$k ${result:$i+1}"
      break
    done

    echo $result
  else
    local widgets=()
    local pos=0
    local spos=3
    local result=$(bindkey -M ${keymap})$'\n'

    # Split string to array by newline
    for ((i=$spos;i<$#result;i++)); do

      # Save the last whitespace character of the line
      # and continue continue handling while meeting `\n`
      case "${result:$i:1}" in
        ' ') spos=$i; i=$i+1; continue;;
        [$'\n']);;
        *) continue;;
      esac

      # Check if it has the same prefix keys and retrieve the widgets
      if [[ "${result:$((pos+1)):$#keys}" == "$keys" ]]; then

        # Get the binding keys
        local k=${result:$((pos+1)):$((spos-pos-2))}

        # Escape spaces in key bindings (space -> $ZVM_ESCAPE_SPACE)
        k=${k// /$ZVM_ESCAPE_SPACE}
        widgets+=("$k ${result:$((spos+1)):$((i-spos-1))}")

      fi

      # Save as new position
      pos=$i+1

      # Skip 3 characters
      # One key and quotes at least (i.e \n"_" )
      i=$i+3
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

  # If lazy keybindings is enabled, we need to add to the lazy list
  if [[ ${ZVM_LAZY_KEYBINDINGS_LIST+x} && ${keymap} != viins ]]; then
    keys=${keys//\"/\\\"}
    keys=${keys//\`/\\\`}
    ZVM_LAZY_KEYBINDINGS_LIST+=("${keymap} \"${keys}\" ${widget}")
    return
  fi

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
      local result=(\$(zvm_readkeys $keymap '${key}')); \
      ZVM_KEYS=\${result[1]//${ZVM_ESCAPE_SPACE//\\/\\\\}/ }; \
      if [[ ! -z '$widget' && \${#ZVM_KEYS} == 1 ]]; then \
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
    bindkey -M $keymap "${key}" $wrapper
  fi

  # We should bind keys with an existing widget
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

# Change cursor to support for inside/outside tmux
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
  local ret=($(zvm_calc_selection $ZVM_MODE_VISUAL_LINE))
  local bpos=${ret[1]} epos=${ret[2]}
  CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}$'\n'
  BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
  CURSOR=$bpos
}

# Remove all characters of the whole line.
function zvm_kill_whole_line() {
  local ret=($(zvm_calc_selection $ZVM_MODE_VISUAL_LINE))
  local bpos=$ret[1] epos=$ret[2] cpos=$ret[3]
  CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}$'\n'

  # Adjust region range of deletion
  if (( $epos < $#BUFFER )); then
    epos=$epos+1
  fi

  BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
  CURSOR=$cpos
}

# Exchange the point and mark
function zvm_exchange_point_and_mark() {
  cursor=$MARK
  MARK=$CURSOR CURSOR=$cursor
  zvm_highlight
}

# Open line below
function zvm_open_line_below() {
  ZVM_MODE=$ZVM_MODE_INSERT
  zvm_update_cursor_style
  zle vi-open-line-below
}

# Open line above
function zvm_open_line_above() {
  ZVM_MODE=$ZVM_MODE_INSERT
  zvm_update_cursor_style
  zle vi-open-line-above
}

# Substitute characters of selection
function zvm_vi_substitue() {
  zle vi-substitute
  zvm_select_vi_mode $ZVM_MODE_INSERT
}

# Calculate the region of selection
function zvm_calc_selection() {
  local bpos= epos= cpos=

  # Get the beginning and end position of selection
  if (( MARK > CURSOR )) ; then
    bpos=$((CURSOR+1)) epos=$((MARK+1))
  else
    bpos=$MARK epos=$((CURSOR+1))
  fi

  # Save the current cursor position
  cpos=$bpos

  # Check if it is visual-line mode
  if [[ "${1:-$ZVM_MODE}" == $ZVM_MODE_VISUAL_LINE ]]; then

    # Extend the selection to whole line
    for ((bpos=$bpos-1; $bpos>0; bpos--)); do
      if [[ "${BUFFER:$bpos:1}" == $'\n' ]]; then
        bpos=$((bpos+1))
        break
      fi
    done
    for ((epos=$epos-1; $epos<$#BUFFER; epos++)); do
      if [[ "${BUFFER:$epos:1}" == $'\n' ]]; then
        break
      fi
    done

    # The begin position must not be less than zero
    if (( bpos < 0 )); then
      bpos=0
    fi

    ###########################################
    # Calculate the new cursor position, here we consider that
    # the selection will be delected.

    # Calculate the indent of current cursor line
    for ((cpos=$((CURSOR-1)); $cpos>=0; cpos--)); do
      [[ "${BUFFER:$cpos:1}" == $'\n' ]] && break
    done

    local indent=$((CURSOR-cpos-1))

    # If the selection includes the last line, the cursor
    # will move up to above line. Otherwise the cursor will
    # keep in the same line.

    local hpos= # Line head position
    local rpos= # Reference position

    if (( $epos < $#BUFFER )); then
      # Get the head position of next line
      hpos=$((epos+1))
      rpos=$bpos
    else
      # Get the head position of above line
      for ((hpos=$((bpos-2)); $hpos>0; hpos--)); do
        if [[ "${BUFFER:$hpos:1}" == $'\n' ]]; then
          break
        fi
      done
      if (( $hpos < -1 )); then
        hpos=-1
      fi
      hpos=$((hpos+1))
      rpos=$hpos
    fi

    # Calculate the cursor postion, the indent must be
    # less than the line characters.
    for ((cpos=$hpos; $cpos<$#BUFFER; cpos++)); do
      if [[ "${BUFFER:$cpos:1}" == $'\n' ]]; then
        break
      fi
      if (( $hpos + $indent <= $cpos )); then
        break
      fi
    done

    cpos=$((rpos+cpos-hpos))
  fi

  echo $bpos $epos $cpos
}

# Yank characters of the marked region
function zvm_yank() {
  local ret=($(zvm_calc_selection $1))
  local bpos=$ret[1] epos=$ret[2] cpos=$ret[3]
  CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}
  if [[ ${1:-$ZVM_MODE} == $ZVM_MODE_VISUAL_LINE ]]; then
    CUTBUFFER=${CUTBUFFER}$'\n'
  fi
  MARK=$bpos CURSOR=$epos
}

# Yank characters of the visual selection
function zvm_vi_yank() {
  zvm_yank
  zvm_exit_visual_mode
}

# Put cutbuffer after the cursor
function zvm_vi_put_after() {
  local head= foot=
  local content=${CUTBUFFER}

  if [[ ${content: -1} == $'\n' ]]; then
    local pos=${CURSOR}

    # Find the end of current line
    for ((; $pos<$#BUFFER; pos++)); do
      if [[ ${BUFFER:$pos:1} == $'\n' ]]; then
        pos=$pos+1
        break
      fi
    done

    # Check if it is an empty line
    if [[ ${BUFFER:$CURSOR:1} == $'\n' &&
      ${BUFFER:$((CURSOR-1)):1} == $'\n' ]]; then
      head=${BUFFER:0:$pos}
      foot=${BUFFER:$pos}
    else
      head=${BUFFER:0:$pos}
      foot=${BUFFER:$pos}
      if [[ $pos == $#BUFFER ]]; then
        content=$'\n'${content:0:-1}
        pos=$pos+1
      fi
    fi

    BUFFER="${head}${content}${foot}"
    CURSOR=$pos
  else
    head="${BUFFER:0:$CURSOR}"
    foot="${BUFFER:$((CURSOR+1))}"
    BUFFER="${head}${BUFFER:$CURSOR:1}${content}${foot}"
    CURSOR=$CURSOR+$#content
  fi

  # Reresh display and highlight buffer
  zvm_highlight clear
  zvm_highlight custom $#head $(($#head+$#content))
  zvm_highlight redraw
}

# Put cutbuffer before the cursor
function zvm_vi_put_before() {
  local head= foot=
  local content=${CUTBUFFER}

  if [[ ${content: -1} == $'\n' ]]; then
    local pos=$CURSOR

    # Find the beginning of current line
    for ((; $pos>0; pos--)); do
      if [[ "${BUFFER:$pos:1}" == $'\n' ]]; then
        pos=$pos+1
        break
      fi
    done

    # Check if it is an empty line
    if [[ ${BUFFER:$CURSOR:1} == $'\n' &&
      ${BUFFER:$((CURSOR-1)):1} == $'\n' ]]; then
      head=${BUFFER:0:$((pos-1))}
      foot=$'\n'${BUFFER:$pos}
      pos=$pos-1
    else
      head=${BUFFER:0:$pos}
      foot=${BUFFER:$pos}
    fi

    BUFFER="${head}${content}${foot}"
    CURSOR=$pos
  else
    head="${BUFFER:0:$CURSOR}"
    foot="${BUFFER:$((CURSOR+1))}"
    BUFFER="${head}${content}${BUFFER:$CURSOR:1}${foot}"
    CURSOR=$CURSOR+$#content
  fi

  # Reresh display and highlight buffer
  zvm_highlight clear
  zvm_highlight custom $#head $(($#head+$#content))
  zvm_highlight redraw
}

# Delete characters of the visual selection
function zvm_vi_delete() {
  local ret=($(zvm_calc_selection))
  local bpos=$ret[1] epos=$ret[2] cpos=$ret[3]

  CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}

  # Check if it is visual line mode
  if [[ $ZVM_MODE == $ZVM_MODE_VISUAL_LINE ]]; then
    if (( $epos < $#BUFFER )); then
      epos=$epos+1
    elif (( $bpos > 0 )); then
      bpos=$bpos-1
    fi
    CUTBUFFER=${CUTBUFFER}$'\n'
  fi

  BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
  CURSOR=$cpos

  zvm_exit_visual_mode
}

# Yank characters of the visual selection
function zvm_vi_change() {
  local ret=($(zvm_calc_selection))
  local bpos=$ret[1] epos=$ret[2]

  CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}

  # Check if it is visual line mode
  if [[ $ZVM_MODE == $ZVM_MODE_VISUAL_LINE ]]; then
    CUTBUFFER=${CUTBUFFER}$'\n'
  fi

  BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
  CURSOR=$bpos

  zvm_exit_visual_mode
  zvm_select_vi_mode $ZVM_MODE_INSERT
}

# Handle the navigation action
function zvm_navigation_handler() {
  case "$1" in
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
    'b') zle vi-backward-word; ;;
    'f') zle vi-find-next-char;;
    'F') zle vi-find-prev-char;;
    't') zle vi-find-next-char-skip;;
    'T') zle vi-find-prev-char-skip;;
  esac
}

# Handle a range of characters
function zvm_range_handler() {
  local keys=${1:-$(zvm_keys)}
  local cursor=$CURSOR
  local mode=
  MARK=$CURSOR

  # Enter visual mode or visual line mode
  if [[ $ZVM_MODE != $ZVM_MODE_VISUAL &&
    $ZVM_MODE != $ZVM_MODE_VISUAL_LINE ]]; then
    case "${keys}" in
      [cdy][jk]) mode=$ZVM_MODE_VISUAL_LINE;;
      cc|dd|yy) mode=$ZVM_MODE_VISUAL_LINE;;
      *) mode=$ZVM_MODE_VISUAL;;
    esac
    # Select the mode
    if [[ ! -z $mode ]]; then
      zvm_select_vi_mode $mode
    fi
  fi

  zvm_navigation_handler "${keys:1}"

  # Extra handling
  case "${keys:1}" in
    b|F|T) cursor=$CURSOR;;
    iw) zle select-in-word; cursor=$MARK;;
    aw) zle select-a-word; cursor=$MARK;;
  esac

  case "${keys}" in
    y*) zvm_vi_yank;;
    d*) zvm_vi_delete; cursor=;;
    c*) zvm_vi_change; cursor=;;
  esac

  # Change the cursor position if the cursor is not null
  if [[ ! -z $cursor ]]; then
    CURSOR=$cursor
  fi
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
    vS*) action=S; surround=${keys:2};;
    vys*) action=y; surround=${keys:3};;
    s[adr]*) action=${keys:1:1}; surround=${keys:2};;
    [acd]s*) action=${keys:0:1}; surround=${keys:2};;
    [cdvy][ia]*) action=${keys:0:2}; surround=${keys:2};;
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
  local ret=($(zvm_parse_surround_keys))
  local action=${ret[1]}
  local surround=${ret[2]//$ZVM_ESCAPE_SPACE/ }
  ret=($(zvm_search_surround ${surround}))
  if [[ ${#ret[@]} == 0 ]]; then
    zvm_exit_visual_mode
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
  # refresh current mode for prompt redraw
  zvm_select_vi_mode
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
    zvm_highlight custom $bpos $(($bpos+1))
    zvm_highlight custom $epos $(($epos+1))
    zvm_highlight redraw
  fi
  local key=
  case $action in
    c|r) read -k 1 key;;
    S|y|a)
      key=$surround
      [[ -z $@ ]] && zle visual-mode
      zvm_select_vi_mode $ZVM_MODE_NORMAL
      ;;
  esac
  if [[ -z $is_appending ]]; then
    zvm_highlight clear
  fi

  # Check if canceling changing surround (ZVM_VI_ESCAPE_BINDKEY)
  [[ "$key" == '' ]] && return
  [[ "$key" == "${ZVM_VI_ESCAPE_BINDKEY//\^\[/}" ]] && return

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
    zvm_select_vi_mode $ZVM_MODE_NORMAL
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
      zvm_select_vi_mode $ZVM_MODE_INSERT
      ;;
    d)
      BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
      CURSOR=$bpos
      ;;
  esac
}

# Select a word under the cursor
function zvm_select_in_word() {
  local cursor=${1:-$CURSOR}
  local buffer=${2:-$BUFFER}
  local bpos=$cursor epos=$cursor
  local pattern='[0-9a-zA-Z_]'

  if ! [[ "${buffer:$cursor:1}" =~ $pattern ]]; then
    pattern="[^${pattern:1:-1}]"
  fi

  for ((; $bpos>=0; bpos--)); do
    [[ "${buffer:$bpos:1}" =~ $pattern ]] || break
  done
  for ((; $epos<$#buffer; epos++)); do
    [[ "${buffer:$epos:1}" =~ $pattern ]] || break
  done

  echo $((bpos+1)) $((epos-1))
}

# Switch keyword
function zvm_switch_keyword() {
  local bpos= epos= cpos=$CURSOR

  if [[ ${BUFFER:$cpos:2} =~ -[0-9] ]]; then
    cpos=$((cpos+1))
  fi

  local result=($(zvm_select_in_word $cpos))
  bpos=${result[1]} epos=$((${result[2]}+1))

  # Extend beginning position for special word
  if (( bpos > 0 )) && [[ ${BUFFER:$((bpos-1)):2} =~ -[0-9] ]]; then
    bpos=$((bpos-1))
  fi

  local word=${BUFFER:$bpos:$((epos-bpos))}
  local keys=$(zvm_keys)

  if [[ $keys == '^A' ]]; then
    local increase=true
  else
    local increase=false
  fi

  # Execute extra commands
  for handler in $zvm_switch_keyword_handlers; do
    if ! zvm_exist_command ${handler}; then
      continue
    fi

    result=($($handler $word $increase));

    if (( $#result == 0 )); then
      continue
    fi

    epos=$(( bpos + ${result[3]} ))
    bpos=$(( bpos + ${result[2]} ))

    if (( cpos < bpos )) || (( cpos >= epos )); then
      continue
    fi

    BUFFER="${BUFFER:0:$bpos}${result[1]}${BUFFER:$epos}"
    CURSOR=$((bpos + ${#result[1]} - 1))

    zle reset-prompt
    return
  done
}

# Switch number keyword
function zvm_switch_number {
  local word=$1
  local increase=${2:-true}
  local result= bpos= epos=

  # Hexadecimal
  if [[ $word =~ [^0-9]?(0[xX][0-9a-fA-F]*) ]]; then
    local number=${match[1]}
    local prefix=${number:0:2}
    bpos=$((mbegin-1)) epos=$mend

    # Hexadecimal cases:
    #
    # 1. Increasement:
    # 0xDe => 0xdf
    # 0xdE => 0xDF
    # 0xde0 => 0xddf
    # 0xffffffffffffffff => 0x0000000000000000
    # 0X9 => 0XA
    # 0Xdf => 0Xe0
    #
    # 2. Decreasement:
    # 0xdE0 => 0xDDF
    # 0xffFf0 => 0xfffef
    # 0xfffF0 => 0xFFFEF
    # 0x0 => 0xffffffffffffffff
    # 0X0 => 0XFFFFFFFFFFFFFFFF
    # 0Xf => 0Xe

    local lower=true
    if [[ $number =~ [A-Z][0-9]*$ ]]; then
      lower=false
    fi

    # Fix the number truncated after 15 digits issue
    if (( $#number > 17 )); then
      local d=$(($#number - 15))
      local h=${number:0:$d}
      number="0x${number:$d}"
    fi

    local p=$(($#number - 2))

    if $increase; then
      if (( $number == 0x${(l:15::f:)} )); then
        h=$(([##16]$h+1))
        h=${h: -1}
        number=${(l:15::0:)}
      else
        h=${h:2}
        number=$(([##16]$number + 1))
      fi
    else
      if (( $number == 0 )); then
        if (( ${h:-0} == 0 )); then
          h=f
        else
          h=$(([##16]$h-1))
          h=${h: -1}
        fi
        number=${(l:15::f:)}
      else
        h=${h:2}
        number=$(([##16]$number - 1))
      fi
    fi

    # Padding with zero
    if (( $#number < $p )); then
      number=${(l:$p::0:)number}
    fi

    result="${h}${number}"

    # Transform the case
    if $lower; then
      result="${(L)result}"
    fi

    result="${prefix}${result}"

  # Binary
  elif [[ $word =~ [^0-9]?(0[bB][01]*) ]]; then
    # Binary cases:
    #
    # 1. Increasement:
    # 0b1 => 0b10
    # 0x1111111111111111111111111111111111111111111111111111111111111111 =>
    # 0x0000000000000000000000000000000000000000000000000000000000000000
    # 0B0 => 0B1
    #
    # 2. Decreasement:
    # 0b1 => 0b0
    # 0b100 => 0b011
    # 0B010 => 0B001
    # 0b0 =>
    # 0x1111111111111111111111111111111111111111111111111111111111111111

    local number=${match[1]}
    local prefix=${number:0:2}
    bpos=$((mbegin-1)) epos=$mend

    # Fix the number truncated after 63 digits issue
    if (( $#number > 65 )); then
      local d=$(($#number - 63))
      local h=${number:0:$d}
      number="0b${number:$d}"
    fi

    local p=$(($#number - 2))

    if $increase; then
      if (( $number == 0b${(l:63::1:)} )); then
        h=$(([##2]$h+1))
        h=${h: -1}
        number=${(l:63::0:)}
      else
        h=${h:2}
        number=$(([##2]$number + 1))
      fi
    else
      if (( $number == 0b0 )); then
        if (( ${h:-0} == 0 )); then
          h=1
        else
          h=$(([##2]$h-1))
          h=${h: -1}
        fi
        number=${(l:63::1:)}
      else
        h=${h:2}
        number=$(([##2]$number - 1))
      fi
    fi

    # Padding with zero
    if (( $#number < $p )); then
      number=${(l:$p::0:)number}
    fi

    result="${prefix}${number}"

  # Decimal
  elif [[ $word =~ (-?[0-9]+) ]]; then
    # Decimal cases:
    #
    # 1. Increasement:
    # 0 => 1
    # 99 => 100
    #
    # 2. Decreasement:
    # 0 => -1
    # 10 => 9
    # aa1230xa => aa1231xa
    # aa1230bb => aa1231bb
    # aa123a0bb => aa124a0bb

    local number=${match[1]}
    bpos=$((mbegin-1)) epos=$mend

    if $increase; then
      result=$(($number + 1))
    else
      result=$(($number - 1))
    fi
  fi

  if [[ $result ]]; then
    echo $result $bpos $epos
  fi
}

# Switch boolean keyword
function zvm_switch_boolean() {
  local word=$1
  local increase=$2
  local result=

  case ${(L)word} in
    true) result=false;;
    false) result=true;;
    yes) result=no;;
    no) result=yes;;
    on) result=off;;
    off) result=on;;
    y) result=n;;
    n) result=y;;
    *) return;;
  esac

  # Transform the case
  if [[ $word =~ ^[A-Z]+$ ]]; then
    result=${(U)result}
  elif [[ $word =~ ^[A-Z] ]]; then
    result=${(U)result:0:1}${result:1}
  fi

  echo $result 0 $#word
}
# Switch weekday keyword
function zvm_switch_weekday() {
  local word=$1
  local increase=$2
  local result=${(L)word}
  local weekdays=(
    sunday
    monday
    tuesday
    wednesday
    thursday
    friday
    saturday
  )

  local i=1

  for ((; i<=${#weekdays[@]}; i++)); do
    if [[ ${weekdays[i]:0:$#result} == ${result} ]]; then
      result=${weekdays[i]}
      break
    fi
  done

  # No match
  if (( i > ${#weekdays[@]} )); then
    return
  fi

  if $increase; then
    if (( i == ${#weekdays[@]} )); then
      i=1
    else
      i=$((i+1))
    fi
  else
    if (( i == 1 )); then
      i=${#weekdays[@]}
    else
      i=$((i-1))
    fi
  fi

  # Abbreviation
  if (( $#result == $#word )); then
    result=${weekdays[i]}
  else
    result=${weekdays[i]:0:$#word}
  fi

  # Transform the case
  if [[ $word =~ ^[A-Z]+$ ]]; then
    result=${(U)result}
  elif [[ $word =~ ^[A-Z] ]]; then
    result=${(U)result:0:1}${result:1}
  fi

  echo $result 0 $#word
}

# Switch month keyword
function zvm_switch_month() {
  local word=$1
  local increase=$2
  local result=${(L)word}
  local months=(
    january
    february
    march
    april
    may
    june
    july
    august
    september
    october
    november
    december
  )

  local i=1

  for ((; i<=${#months[@]}; i++)); do
    if [[ ${months[i]:0:$#result} == ${result} ]]; then
      result=${months[i]}
      break
    fi
  done

  # No match
  if (( i > ${#months[@]} )); then
    return
  fi

  if $increase; then
    if (( i == ${#months[@]} )); then
      i=1
    else
      i=$((i+1))
    fi
  else
    if (( i == 1 )); then
      i=${#months[@]}
    else
      i=$((i-1))
    fi
  fi

  # Abbreviation
  if (( $#result == $#word )); then
    result=${months[i]}
  else
    result=${months[i]:0:$#word}
  fi

  # Transform the case
  if [[ $word =~ ^[A-Z]+$ ]]; then
    result=${(U)result}
  elif [[ $word =~ ^[A-Z] ]]; then
    result=${(U)result:0:1}${result:1}
  fi

  echo $result 0 $#word
}

# Highlight content
function zvm_highlight() {
  local opt=${1:-mode}
  local region=()
  local rh_length=${#ZVM_REGION_HIGHLIGHT[@]}
  local redraw=

  # Hanlde region by the option
  case "$opt" in
    mode)
      case "$ZVM_MODE" in
        $ZVM_MODE_VISUAL_LINE)
          local ret=($(zvm_calc_selection))
          local bpos=$ret[1] epos=$ret[2]
          region=("$((bpos)) $((epos)) bg=$ZVM_VI_HIGHLIGHT_BACKGROUND")
          ;;
      esac
      redraw=true
      ;;
    custom)
      region=("${ZVM_REGION_HIGHLIGHT[@]}")
      region+=("$2 $3 bg=${4:-$ZVM_VI_HIGHLIGHT_BACKGROUND}")
      ;;
    clear) redraw=true;;
    redraw) redraw=true;;
  esac

  # Update region highlight
  if (( $#region > 0 )) || [[ "$opt" == 'clear' ]]; then
    zle redisplay
    ZVM_REGION_HIGHLIGHT=("${region[@]}")
    # Remove old region highlight
    if (( $rh_length > 0 && $rh_length <= ${#region_highlight} )); then
      region_highlight=("${region_highlight[@]:0:-$rh_length}")
    fi
    region_highlight+=("${ZVM_REGION_HIGHLIGHT[@]}")
  fi

  # Check if we need to refresh the region highlight
  if [[ $redraw ]]; then
    zle -R
  fi
}

# Down line in visual mode
function zvm_down_line() {
  zle down-line
  zvm_highlight
}

# Up line in visual mode
function zvm_up_line() {
  zle up-line
  zvm_highlight
}

# Backward character in visual mode
function zvm_backward_char() {
  zle vi-backward-char
  zvm_highlight
}

# Forward character in visual mode
function zvm_forward_char() {
  zle vi-forward-char
  zvm_highlight
}

# Enter the visual mode
function zvm_enter_visual_mode() {
  local mode=
  case "$(zvm_keys)" in
    v) mode=$ZVM_MODE_VISUAL;;
    V) mode=$ZVM_MODE_VISUAL_LINE;;
  esac
  zvm_select_vi_mode $mode
  zvm_highlight
}

# Exit the visual mode
function zvm_exit_visual_mode() {
  case "$ZVM_MODE" in
    $ZVM_MODE_VISUAL) zle visual-mode;;
    $ZVM_MODE_VISUAL_LINE) zle visual-line-mode;;
  esac
  zvm_highlight clear
  zvm_select_vi_mode $ZVM_MODE_NORMAL
}

# Enter the vi insert mode
function zvm_enter_insert_mode() {
  zvm_select_vi_mode $ZVM_MODE_INSERT
  if [[ $(zvm_keys) == 'i' ]]; then
    ZVM_INSERT_MODE='i'
  else
    ZVM_INSERT_MODE='a'
    zle vi-forward-char
  fi
}

# Exit the vi insert mode
function zvm_exit_insert_mode() {
  zvm_select_vi_mode $ZVM_MODE_NORMAL
}

# Select vi mode
function zvm_select_vi_mode() {
  # Start the lazy keybindings when the first time entering the normal mode
  if [[ $1 != $ZVM_MODE_INSERT ]] && (($#ZVM_LAZY_KEYBINDINGS_LIST > 0 )); then
    zvm_exec_commands 'before_lazy_keybindings'

    # Here we should unset the list for normal keybindings
    local list=("${ZVM_LAZY_KEYBINDINGS_LIST[@]}")
    unset ZVM_LAZY_KEYBINDINGS_LIST

    for r in "${list[@]}"; do
      eval "zvm_bindkey ${r}"
    done

    zvm_exec_commands 'after_lazy_keybindings'
  fi

  zvm_exec_commands 'before_select_vi_mode'

  # Some plugins would reset the prompt when we select the
  # keymap, so here we disable the reset-prompt temporarily.
  ZVM_RESET_PROMPT_DISABLED=1

  case "$1" in
    $ZVM_MODE_NORMAL)
      ZVM_MODE=$ZVM_MODE_NORMAL
      zvm_update_cursor_style
      zle vi-cmd-mode
      ;;
    $ZVM_MODE_INSERT)
      ZVM_MODE=$ZVM_MODE_INSERT
      zvm_update_cursor_style
      zle vi-insert
      ;;
    $ZVM_MODE_VISUAL)
      ZVM_MODE=$ZVM_MODE_VISUAL
      zvm_update_cursor_style
      zle visual-mode
      ;;
    $ZVM_MODE_VISUAL_LINE)
      ZVM_MODE=$ZVM_MODE_VISUAL_LINE
      zvm_update_cursor_style
      zle visual-line-mode
      ;;
  esac

  # Here restore the reset-prompt
  ZVM_RESET_PROMPT_DISABLED=

  [[ -z $2 ]] && zle reset-prompt

  zvm_exec_commands 'after_select_vi_mode'
}

# Reset prompt
function zvm_reset_prompt() {
  ! (( $ZVM_RESET_PROMPT_DISABLED )) || return
  local -i retval
  zle .reset-prompt -- $@
  return $retval
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

# Update the cursor style by current vi mode
function zvm_update_cursor_style() {
  case "$ZVM_MODE" in
    n) zvm_set_normal_mode_cursor;;
    i) zvm_set_insert_mode_cursor;;
    v) zvm_set_normal_mode_cursor;;
    vl) zvm_set_normal_mode_cursor;;
  esac
}

# Updates editor information when line pre redraw
function zvm_zle-line-pre-redraw() {
  # Fix cursor style is not updated in tmux environment
  # Update cursor style when line pre redraw
  zvm_update_cursor_style
}

# Start every prompt in insert mode
function zvm_zle-line-init() {
  zvm_select_vi_mode $ZVM_MODE_INSERT
}

# Initialize vi-mode for widgets, keybindings, etc.
function zvm_init() {
  zvm_exec_commands 'before_init'

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
  zvm_define_widget zvm_down_line
  zvm_define_widget zvm_up_line
  zvm_define_widget zvm_backward_char
  zvm_define_widget zvm_forward_char
  zvm_define_widget zvm_enter_insert_mode
  zvm_define_widget zvm_exit_insert_mode
  zvm_define_widget zvm_enter_visual_mode
  zvm_define_widget zvm_exit_visual_mode
  zvm_define_widget zvm_exchange_point_and_mark
  zvm_define_widget zvm_open_line_below
  zvm_define_widget zvm_open_line_above
  zvm_define_widget zvm_vi_substitue
  zvm_define_widget zvm_vi_change
  zvm_define_widget zvm_vi_delete
  zvm_define_widget zvm_vi_yank
  zvm_define_widget zvm_vi_put_after
  zvm_define_widget zvm_vi_put_before
  zvm_define_widget zvm_switch_keyword

  # Override standard widgets
  zvm_define_widget zle-line-pre-redraw zvm_zle-line-pre-redraw

  # Ensure insert mode cursor when exiting vim
  zvm_define_widget zle-line-init zvm_zle-line-init

  # Override reset-prompt widget
  zvm_define_widget reset-prompt zvm_reset_prompt

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

  # Other key bindings
  zvm_bindkey visual 'j'  zvm_down_line
  zvm_bindkey visual 'k'  zvm_up_line
  zvm_bindkey visual 'h'  zvm_backward_char
  zvm_bindkey visual 'l'  zvm_forward_char
  zvm_bindkey vicmd  'v'  zvm_enter_visual_mode
  zvm_bindkey vicmd  'V'  zvm_enter_visual_mode
  zvm_bindkey visual 'o'  zvm_exchange_point_and_mark
  zvm_bindkey vicmd  'o'  zvm_open_line_below
  zvm_bindkey vicmd  'O'  zvm_open_line_above
  zvm_bindkey vicmd  's'  zvm_vi_substitue
  zvm_bindkey visual 'c'  zvm_vi_change
  zvm_bindkey visual 'd'  zvm_vi_delete
  zvm_bindkey visual 'y'  zvm_vi_yank
  zvm_bindkey vicmd  'p'  zvm_vi_put_after
  zvm_bindkey vicmd  'P'  zvm_vi_put_before

  zvm_bindkey vicmd '^A' zvm_switch_keyword
  zvm_bindkey vicmd '^X' zvm_switch_keyword

  # Binding escape key
  zvm_bindkey viins "$ZVM_VI_ESCAPE_BINDKEY" zvm_exit_insert_mode
  zvm_bindkey visual "$ZVM_VI_ESCAPE_BINDKEY" zvm_exit_visual_mode

  if [[ "$ZVM_VI_ESCAPE_BINDKEY" != '^[' ]]; then
    local is_custom_escape_key=true
  fi

  if $is_custom_escape_key; then
    zvm_bindkey viins '^[' zvm_exit_insert_mode
    zvm_bindkey visual '^[' zvm_exit_visual_mode
  fi

  # Binding and overwrite original y/d/c of vicmd
  for c in {y,d,c}; do
    zvm_bindkey vicmd "$c"
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

  # Append for escaping visual mode
  if $is_custom_escape_key; then
    surrounds+=("$ZVM_VI_ESCAPE_BINDKEY")
  fi

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
  zvm_bindkey vicmd '%' zvm_move_around_surround

  # Fix BACKSPACE was stuck in zsh
  # Since normally '^?' (backspace) is bound to vi-backward-delete-char
  zvm_bindkey viins '^?' backward-delete-char

  # Enable vi keymap
  bindkey -v

  zvm_exec_commands 'after_init'
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

# Check if a command is existed
function zvm_exist_command() {
  local ret=($(type ${1}; echo $?))
  return ${ret: -1}
}

# Execute commands
function zvm_exec_commands() {
  local commands="zvm_${1}_commands"
  commands=(${(P)commands})

  # Execute the default command
  if zvm_exist_command "zvm_$1"; then
    eval "zvm_$1" ${@:2}
  fi

  # Execute extra commands
  for cmd in $commands; do
    if zvm_exist_command ${cmd}; then
      cmd="$cmd ${@:2}"
    fi
    eval $cmd
  done
}

# Initialize the plugin when starting new command line
precmd_functions+=(zvm_precmd_function)

