# zsh-vi-mode.zsh -- A better and friendly vi(vim) mode for Zsh
# https://github.com/jeffreytse/zsh-vi-mode
#
# Copyright (c) 2020 Jeffrey Tse
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
# Some of these variables should be set before sourcing this file.
#
# ZVM_CONFIG_FUNC
# the config function (default is `zvm_config`), if this config function
# exists, it will be called automatically, you can do some configurations
# in this aspect before you source this plugin.
#
# For example:
#
# ```zsh
# function zvm_config() {
#   ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
#   ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
# }
#
# source ~/zsh-vi-mode.zsh
# ```
#
# ZVM_INIT_MODE
# the plugin initial mode (default is doing the initialization when the first
# new command line is starting. For doing the initialization instantly, you
# can set it to `sourcing`.
#
# ZVM_VI_ESCAPE_BINDKEY
# the vi escape key for all modes (default is ^[ => <ESC>), you can set it
# to whatever you like, such as `jj`, `jk` and so on.
#
# ZVM_VI_INSERT_ESCAPE_BINDKEY
# the vi escape key of insert mode (default is $ZVM_VI_ESCAPE_BINDKEY), you
# can set it to whatever, such as `jj`, `jk` and so on.
#
# ZVM_VI_VISUAL_ESCAPE_BINDKEY
# the vi escape key of visual mode (default is $ZVM_VI_ESCAPE_BINDKEY), you
# can set it to whatever, such as `jj`, `jk` and so on.
#
# ZVM_VI_OPPEND_ESCAPE_BINDKEY
# the vi escape key of operator pendding mode (default is
# $ZVM_VI_ESCAPE_BINDKEY), you can set it to whatever, such as `jj`, `jk`
# and so on.
#
# ZVM_VI_INSERT_MODE_LEGACY_UNDO:
# using legacy undo behavior in vi insert mode
#
# ZVM_VI_HIGHLIGHT_FOREGROUND:
# the behavior of highlight foreground (surrounds, visual-line, etc) in vi mode
#
# ZVM_VI_HIGHLIGHT_BACKGROUND:
# the behavior of highlight background (surrounds, visual-line, etc) in vi mode
#
# ZVM_VI_HIGHLIGHT_EXTRASTYLE:
# the behavior of highlight extra style (i.e. bold, underline) in vi mode
#
# For example:
#   ZVM_VI_HIGHLIGHT_FOREGROUND=green           # Color name
#   ZVM_VI_HIGHLIGHT_FOREGROUND=#008800         # Hex value
#   ZVM_VI_HIGHLIGHT_BACKGROUND=red             # Color name
#   ZVM_VI_HIGHLIGHT_BACKGROUND=#ff0000         # Hex value
#   ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline  # bold and underline
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
# ZVM_READKEY_ENGINE
# the readkey engine for reading and processing the key events, and the
# below engines are supported:
#  ZVM_READKEY_ENGINE_NEX (Default)
#  ZVM_READKEY_ENGINE_ZLE
#
# the NEX is a better engine for reading and handling the key events than
# the Zsh's ZLE engine, currently the NEX engine is at beta stage, and
# you can change to Zsh's ZLE engine if you want.
#
# ZVM_KEYTIMEOUT:
# the key input timeout for waiting for next key (default is 0.4 seconds)
#
# ZVM_ESCAPE_KEYTIMEOUT:
# the key input timeout for waiting for next key if it is beginning with
# an escape character (default is 0.03 seconds), and this option is just
# available for the NEX readkey engine
#
# ZVM_LINE_INIT_MODE
# the setting for init mode of command line (default is empty), empty will
# keep the last command mode, for the first command line it will be insert
# mode, you can also set it to a specific vi mode to alway keep the mode
# for each command line
#
# For example:
#   ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
#   ZVM_LINE_INIT_MODE=$ZVM_MODE_NORMAL
#
# ZVM_LAZY_KEYBINDINGS:
# the setting for lazy keybindings (default is true), and lazy keybindings
# will postpone the keybindings of vicmd and visual keymaps to the first
# time entering normal mode
#
# ZVM_NORMAL_MODE_CURSOR:
# the prompt cursor in normal mode
#
# ZVM_INSERT_MODE_CURSOR:
# the prompt cursor in insert mode
#
# ZVM_VISUAL_MODE_CURSOR:
# the prompt cursor in visual mode
#
# ZVM_VISUAL_LINE_MODE_CURSOR:
# the prompt cursor in visual line mode
#
# ZVM_OPPEND_MODE_CURSOR:
# the prompt cursor in operator pending mode
#
# You can change the cursor style by below:
#  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
#
# and the below cursor style are supported:
#  ZVM_CURSOR_USER_DEFAULT
#  ZVM_CURSOR_BLOCK
#  ZVM_CURSOR_UNDERLINE
#  ZVM_CURSOR_BEAM
#  ZVM_CURSOR_BLINKING_BLOCK
#  ZVM_CURSOR_BLINKING_UNDERLINE
#  ZVM_CURSOR_BLINKING_BEAM
#
# ZVM_VI_EDITOR
# the editor to edit your command line (default is $EDITOR)
#
# ZVM_TMPDIR
# the temporary directory (default is $TMPDIR, otherwise it's /tmp)
#
# ZVM_TERM
# the term for handling terminal sequences, it's important for some
# terminal emulators to show cursor properly (default is $TERM)
#
# ZVM_CURSOR_STYLE_ENABLED
# enable the cursor style feature (default is true)
#

# Avoid sourcing plugin multiple times
command -v 'zvm_version' >/dev/null && return

# Plugin information
typeset -gr ZVM_NAME='zsh-vi-mode'
typeset -gr ZVM_DESCRIPTION='💻 A better and friendly vi(vim) mode plugin for ZSH.'
typeset -gr ZVM_REPOSITORY='https://github.com/jeffreytse/zsh-vi-mode'
typeset -gr ZVM_VERSION='0.8.5'

# Plugin initial status
ZVM_INIT_DONE=false

# Postpone reset prompt (i.e. postpone the widget `reset-prompt`)
# empty (No postponing)
# true (Enter postponing)
# false (Trigger reset prompt)
ZVM_POSTPONE_RESET_PROMPT=

# Operator pending mode
ZVM_OPPEND_MODE=false

# Insert mode could be
# `i` (insert)
# `a` (append)
# `I` (insert at the non-blank beginning of current line)
# `A` (append at the end of current line)
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

# Default zvm readkey engines
ZVM_READKEY_ENGINE_NEX='nex'
ZVM_READKEY_ENGINE_ZLE='zle'
ZVM_READKEY_ENGINE_DEFAULT=$ZVM_READKEY_ENGINE_NEX

# Default alternative character for escape characters
ZVM_ESCAPE_SPACE='\s'
ZVM_ESCAPE_NEWLINE='^J'

# Default vi modes
ZVM_MODE_LAST=''
ZVM_MODE_NORMAL='n'
ZVM_MODE_INSERT='i'
ZVM_MODE_VISUAL='v'
ZVM_MODE_VISUAL_LINE='vl'
ZVM_MODE_REPLACE='r'

# Default cursor styles
ZVM_CURSOR_USER_DEFAULT='ud'
ZVM_CURSOR_BLOCK='bl'
ZVM_CURSOR_UNDERLINE='ul'
ZVM_CURSOR_BEAM='be'
ZVM_CURSOR_BLINKING_BLOCK='bbl'
ZVM_CURSOR_BLINKING_UNDERLINE='bul'
ZVM_CURSOR_BLINKING_BEAM='bbe'

# The commands need to be repeated
ZVM_REPEAT_MODE=false
ZVM_REPEAT_RESET=false
ZVM_REPEAT_COMMANDS=($ZVM_MODE_NORMAL i)

##########################################
# Initial all default settings

# Default config function
: ${ZVM_CONFIG_FUNC:='zvm_config'}

# Load config by calling the config function
if command -v "$ZVM_CONFIG_FUNC" >/dev/null; then
  $ZVM_CONFIG_FUNC
fi

# Set the readkey engine (default is NEX engine)
: ${ZVM_READKEY_ENGINE:=$ZVM_READKEY_ENGINE_DEFAULT}

# Set key input timeout (default is 0.4 seconds)
: ${ZVM_KEYTIMEOUT:=0.4}

# Set the escape key timeout (default is 0.03 seconds)
: ${ZVM_ESCAPE_KEYTIMEOUT:=0.03}

# Set keybindings mode (default is true)
# The lazy keybindings will post the keybindings of vicmd and visual
# keymaps to the first time entering the normal mode
: ${ZVM_LAZY_KEYBINDINGS:=true}

# All keybindings for lazy loading
if $ZVM_LAZY_KEYBINDINGS; then
  ZVM_LAZY_KEYBINDINGS_LIST=()
fi

# Set the cursor style in defferent vi modes, the value you could use
# the predefined value, such as $ZVM_CURSOR_BLOCK, $ZVM_CURSOR_BEAM,
# $ZVM_CURSOR_BLINKING_BLOCK and so on.
: ${ZVM_INSERT_MODE_CURSOR:=$ZVM_CURSOR_BEAM}
: ${ZVM_NORMAL_MODE_CURSOR:=$ZVM_CURSOR_BLOCK}
: ${ZVM_VISUAL_MODE_CURSOR:=$ZVM_CURSOR_BLOCK}
: ${ZVM_VISUAL_LINE_MODE_CURSOR:=$ZVM_CURSOR_BLOCK}

# Operator pending mode cursor style (default is underscore)
: ${ZVM_OPPEND_MODE_CURSOR:=$ZVM_CURSOR_UNDERLINE}

# Set the vi escape key (default is ^[ => <ESC>)
: ${ZVM_VI_ESCAPE_BINDKEY:=^[}
: ${ZVM_VI_INSERT_ESCAPE_BINDKEY:=$ZVM_VI_ESCAPE_BINDKEY}
: ${ZVM_VI_VISUAL_ESCAPE_BINDKEY:=$ZVM_VI_ESCAPE_BINDKEY}
: ${ZVM_VI_OPPEND_ESCAPE_BINDKEY:=$ZVM_VI_ESCAPE_BINDKEY}

# Set the line init mode (empty will keep the last mode)
# you can also set it to others, such as $ZVM_MODE_INSERT.
: ${ZVM_LINE_INIT_MODE:=$ZVM_MODE_LAST}

: ${ZVM_VI_INSERT_MODE_LEGACY_UNDO:=false}
: ${ZVM_VI_SURROUND_BINDKEY:=classic}
: ${ZVM_VI_HIGHLIGHT_BACKGROUND:=#cc0000}
: ${ZVM_VI_HIGHLIGHT_FOREGROUND:=#eeeeee}
: ${ZVM_VI_HIGHLIGHT_EXTRASTYLE:=default}
: ${ZVM_VI_EDITOR:=${EDITOR:-vim}}
: ${ZVM_TMPDIR:=${TMPDIR:-/tmp}}

# Set the term for handling terminal sequences, it's important for some
# terminal emulators to show cursor properly (default is $TERM)
: ${ZVM_TERM:=${TERM:-xterm-256color}}

# Enable the cursor style feature
: ${ZVM_CURSOR_STYLE_ENABLED:=true}

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
  zvm_switch_operator
  zvm_switch_weekday
  zvm_switch_month
)

# Display version information
function zvm_version() {
  echo -e "$ZVM_NAME $ZVM_VERSION"
  echo -e "\e[4m$ZVM_REPOSITORY\e[0m"
  echo -e "$ZVM_DESCRIPTION"
}

# The widget wrapper
function zvm_widget_wrapper() {
  local rawfunc=$1;
  local func=$2;
  local -i retval
  $func "${@:3}"
  return retval
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
    eval "$wrapper() { zvm_widget_wrapper $rawfunc $func \"\$@\" }"
    func=$wrapper
  fi

  zle -N $widget $func
}

# Get the keys typed to invoke this widget, as a literal string
function zvm_keys() {
  local keys=${ZVM_KEYS:-$KEYS}

  # Append the prefix of keys if it is visual or visual-line mode
  case "${ZVM_MODE}" in
    $ZVM_MODE_VISUAL)
      if [[ "$keys" != v* ]]; then
        keys="v${keys}"
      fi
      ;;
    $ZVM_MODE_VISUAL_LINE)
      if [[ "$keys" != V* ]]; then
        keys="V${keys}"
      fi
      ;;
  esac

  # Escape the newline and space characters, otherwise, we can't
  # get the output from subshell correctly.
  keys=${keys//$'\n'/$ZVM_ESCAPE_NEWLINE}
  keys=${keys// /$ZVM_ESCAPE_SPACE}

  echo $keys
}

# Find the widget on a specified bindkey
function zvm_find_bindkey_widget() {
  local keymap=$1
  local keys=$2
  local prefix_mode=${3:-false}
  retval=()

  if $prefix_mode; then
    local pos=0
    local spos=3
    local prefix_keys=

    # Get the prefix keys
    if [[ $prefix_keys ]]; then
      prefix_keys=${prefix_keys:0:-1}

      # If the last key is an escape key (e.g. \", \`, \\) we still
      # need to remove the escape backslash `\`
      if [[ ${prefix_keys: -1} == '\' ]]; then
        prefix_keys=${prefix_keys:0:-1}
      fi
    fi

    local result=$(bindkey -M ${keymap} -p "$prefix_keys")$'\n'

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
        retval+=($k ${result:$((spos+1)):$((i-spos-1))})
      fi

      # Save as new position
      pos=$i+1

      # Skip 3 characters
      # One key and quotes at least (i.e \n"_" )
      i=$i+3
    done
  else
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
      retval+=($k ${result:$i+1})

      break
    done
  fi
}

# Read keys for retrieving widget
function zvm_readkeys() {
  local keymap=$1
  local key=${2:-$(zvm_keys)}
  local keys=
  local widget=
  local result=
  local pattern=
  local timeout=

  while :; do
    # Keep reading key for escape character
    if [[ "$key" == $'\e' ]]; then
      while :; do
        local k=
        read -t $ZVM_ESCAPE_KEYTIMEOUT -k 1 k || break
        key="${key}${k}"
      done
    fi

    keys="${keys}${key}"

    # Handle the pattern
    if [[ -n "$key" ]]; then
      # Transform the non-printed characters
      local k=$(zvm_escape_non_printed_characters "${key}")

      # Escape keys
      # " -> \" It's a special character in bash syntax
      # ` -> \` It's a special character in bash syntax
      # <space> -> ` ` It's a special character in bash syntax
      k=${k//\"/\\\"}
      k=${k//\`/\\\`}
      k=${k//$ZVM_ESCAPE_SPACE/ }

      pattern="${pattern}${k}"
    fi

    # Find out widgets that match this key pattern
    zvm_find_bindkey_widget $keymap "$pattern" true
    result=(${retval[@]})

    # Exit key input if there is only one widget matched
    # or no more widget matched.
    case ${#result[@]} in
      2) key=; widget=${result[2]}; break;;
      0) break;;
    esac

    # Evaluate the readkey timeout
    # Special timeout for the escape sequence
    if [[ "${keys}" == $'\e' ]]; then
      timeout=$ZVM_ESCAPE_KEYTIMEOUT
      # Check if there is any one custom escape sequence
      for ((i=1; i<=${#result[@]}; i=i+2)); do
        if [[ "${result[$i]}" =~ '^\^\[\[?[A-Z0-9]*~?\^\[' ]]; then
          timeout=$ZVM_KEYTIMEOUT
          break
        fi
      done
    else
      timeout=$ZVM_KEYTIMEOUT
    fi

    # Wait for reading next key, and we should save the widget
    # as the final widget if it is full matching
    key=
    if [[ "${result[1]}" == "${pattern}" ]]; then
      widget=${result[2]}
      # Get current widget as final widget when reading key timeout
      read -t $timeout -k 1 key || break
    else
      zvm_enter_oppend_mode
      read -k 1 key
    fi
  done

  # Exit operator pending mode
  if $ZVM_OPPEND_MODE; then
    zvm_exit_oppend_mode
  fi

  if [[ -z "$key" ]]; then
    retval=(${keys} $widget)
  else
    retval=(${keys:0:-$#key} $widget $key)
  fi
}

# Add key bindings
function zvm_bindkey() {
  local keymap=$1
  local keys=$2
  local widget=$3
  local params=$4
  local key=

  # We should bind keys with an existing widget
  [[ -z $widget ]] && return

  # If lazy keybindings is enabled, we need to add to the lazy list
  if [[ ${ZVM_LAZY_KEYBINDINGS_LIST+x} && ${keymap} != viins ]]; then
    keys=${keys//\"/\\\"}
    keys=${keys//\`/\\\`}
    ZVM_LAZY_KEYBINDINGS_LIST+=(
      "${keymap} \"${keys}\" ${widget} \"${params}\""
    )
    return
  fi

  # Hanle the keybinding of NEX readkey engine
  if [[ $ZVM_READKEY_ENGINE == $ZVM_READKEY_ENGINE_NEX ]]; then
    # Get the first key (especially check if ctrl characters)
    if [[ $#keys -gt 1 && "${keys:0:1}" == '^' ]]; then
      key=${keys:0:2}
    else
      key=${keys:0:1}
    fi
    bindkey -M $keymap "${key}" zvm_readkeys_handler
  fi

  # Wrap params to a new widget
  if [[ -n $params ]]; then
    local suffix=$(zvm_string_to_hex $params)
    eval "$widget:$suffix() { $widget $params }"
    widget="$widget:$suffix"
    zvm_define_widget $widget
  fi

  # Bind keys with with a widget
  bindkey -M $keymap "${keys}" $widget
}

# Convert string to hexadecimal
function zvm_string_to_hex() {
  local str=
  for ((i=1;i<=$#1;i++)); do
    str+=$(printf '%x' "'${1[$i]}")
  done
  echo "$str"
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
    elif [[ "$c" == ' ' ]]; then
      str="${str}^@"
    else
      str="${str}${c}"
    fi
  done

  # Escape the newline and space characters, otherwise, we can't
  # get the output from subshell correctly.
  str=${str// /$ZVM_ESCAPE_SPACE}
  str=${str//$'\n'/$ZVM_ESCAPE_NEWLINE}

  echo -n $str
}

# Backward remove characters of an emacs region in the line
function zvm_backward_kill_region() {
  local bpos=$CURSOR-1 epos=$CURSOR

  # Backward search the boundary of current region
  for ((; bpos >= 0; bpos--)); do
    # Break when cursor is at the beginning of line
    [[ "${BUFFER:$bpos:1}" == $'\n' ]] && break

    # Break when cursor is at the boundary of a word region
    [[ "${BUFFER:$bpos:2}" =~ ^\ [^\ $'\n']$ ]] && break
  done

  bpos=$bpos+1
  CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}
  BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
  CURSOR=$bpos
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
  local i=$CURSOR

  # If there is a completion suffix, we should break at the
  # postion of suffix begin, otherwise, it should break when
  # forward finding out the first newline character.
  for ((; i<$#BUFFER; i++)); do
    if ((SUFFIX_ACTIVE == 1)) && ((i >= SUFFIX_BEGIN)); then
      break
    fi
    if [[ "${BUFFER[$i]}" == $'\n' ]]; then
      i=$((i-1))
      break
    fi
  done

  CURSOR=$i
  LBUFFER+=$'\n'

  zvm_reset_repeat_commands $ZVM_MODE_NORMAL o
  zvm_select_vi_mode $ZVM_MODE_INSERT
}

# Open line above
function zvm_open_line_above() {
  local i=$CURSOR

  # Break when backward finding out the first newline character.
  for ((; i>0; i--)); do
    if [[ "${BUFFER[$i]}" == $'\n' ]]; then
      break
    fi
  done

  CURSOR=$i
  LBUFFER+=$'\n'
  CURSOR=$((CURSOR-1))

  zvm_reset_repeat_commands $ZVM_MODE_NORMAL O
  zvm_select_vi_mode $ZVM_MODE_INSERT
}

# Replace characters one by one (Replacing mode)
function zvm_vi_replace() {
  if [[ $ZVM_MODE == $ZVM_MODE_NORMAL ]]; then
    local cursor=$CURSOR
    local cache=()
    local cmds=()
    local key=

    zvm_select_vi_mode $ZVM_MODE_REPLACE

    while :; do
      # Read a character for replacing
      zvm_update_cursor

      # Redisplay the command line, this is to be called from within
      # a user-defined widget to allow changes to become visible
      zle -R

      read -k 1 key

      # Escape key will break the replacing process, and enter key
      # will repace with a newline character.
      case $(zvm_escape_non_printed_characters $key) in
        '^['|$ZVM_VI_OPPEND_ESCAPE_BINDKEY) break;;
        '^M') key=$'\n';;
      esac

      # If the key is backspace, we should move backward the cursor
      if [[ $key == '' ]]; then
        # Cursor position should not be less than zero
        if ((cursor > 0)); then
          cursor=$((cursor-1))
        fi

        # We should recover the character when cache size is not zero
        if ((${#cache[@]} > 0)); then
          key=${cache[-1]}

          if [[ $key == '<I>' ]]; then
            key=
          fi

          cache=(${cache[@]:0:-1})
          BUFFER[$cursor+1]=$key

          # Remove from commands
          cmds=(${cmds[@]:0:-1})
        fi
      else
        # If the key or the character at cursor is a newline character,
        # or the cursor is at the end of buffer, we should insert the
        # key instead of replacing with the key.
        if [[ $key == $'\n' ||
          $BUFFER[$cursor+1] == $'\n' ||
          $BUFFER[$cursor+1] == ''
        ]]; then
          cache+=('<I>')
          LBUFFER+=$key
        else
          cache+=(${BUFFER[$cursor+1]})
          BUFFER[$cursor+1]=$key
        fi

        cursor=$((cursor+1))

        # Push to commands
        cmds+=($key)
      fi

      # Update next cursor position
      CURSOR=$cursor

      zle redisplay
    done

    # The cursor position should go back one character after
    # exiting the replace mode
    zle vi-backward-char

    zvm_select_vi_mode $ZVM_MODE_NORMAL
    zvm_reset_repeat_commands $ZVM_MODE R $cmds
  elif [[ $ZVM_MODE == $ZVM_MODE_VISUAL ]]; then
    zvm_enter_visual_mode V
    zvm_vi_change
  elif [[ $ZVM_MODE == $ZVM_MODE_VISUAL_LINE ]]; then
    zvm_vi_change
  fi
}

# Replace characters in one time
function zvm_vi_replace_chars() {
  local cmds=()
  local key=

  # Read a character for replacing
  zvm_enter_oppend_mode

  # Redisplay the command line, this is to be called from within
  # a user-defined widget to allow changes to become visible
  zle redisplay
  zle -R

  read -k 1 key

  zvm_exit_oppend_mode

  # Escape key will break the replacing process
  case $(zvm_escape_non_printed_characters $key) in
    $ZVM_VI_OPPEND_ESCAPE_BINDKEY)
      zvm_exit_visual_mode
      return
  esac

  if [[ $ZVM_MODE == $ZVM_MODE_NORMAL ]]; then
    cmds+=($key)
    BUFFER[$CURSOR+1]=$key
  else
    local ret=($(zvm_calc_selection))
    local bpos=${ret[1]} epos=${ret[2]}
    for ((bpos=bpos+1; bpos<=epos; bpos++)); do
      # Newline character is no need to be replaced
      if [[ $BUFFER[$bpos] == $'\n' ]]; then
        cmds+=($'\n')
        continue
      fi

      cmds+=($key)
      BUFFER[$bpos]=$key
    done
    zvm_exit_visual_mode
  fi

  # Reset the repeat commands
  zvm_reset_repeat_commands $ZVM_MODE r $cmds
}

# Substitute characters of selection
function zvm_vi_substitute() {
  # Substitute one character in normal mode
  if [[ $ZVM_MODE == $ZVM_MODE_NORMAL ]]; then
    BUFFER="${BUFFER:0:$CURSOR}${BUFFER:$((CURSOR+1))}"
    zvm_reset_repeat_commands $ZVM_MODE c 0 1
    zvm_select_vi_mode $ZVM_MODE_INSERT
  else
    zvm_vi_change
  fi
}

# Substitute all characters of a line
function zvm_vi_substitute_whole_line() {
  zvm_select_vi_mode $ZVM_MODE_VISUAL_LINE false
  zvm_vi_substitute
}

# Check if cursor is at an empty line
function zvm_is_empty_line() {
  local cursor=${1:-$CURSOR}
  if [[ ${BUFFER:$cursor:1} == $'\n' &&
    ${BUFFER:$((cursor-1)):1} == $'\n' ]]; then
    return
  fi
  return 1
}

# Get the beginning and end position of selection
function zvm_selection() {
  local bpos= epos=
  if (( MARK > CURSOR )) ; then
    bpos=$CURSOR epos=$((MARK+1))
  else
    bpos=$MARK epos=$((CURSOR+1))
  fi
  echo $bpos $epos
}

# Calculate the region of selection
function zvm_calc_selection() {
  local ret=($(zvm_selection))
  local bpos=${ret[1]} epos=${ret[2]} cpos=

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
  CURSOR=$bpos MARK=$epos
}

# Up case of the visual selection
function zvm_vi_up_case() {
  local ret=($(zvm_selection))
  local bpos=${ret[1]} epos=${ret[2]}
  local content=${BUFFER:$bpos:$((epos-bpos))}
  BUFFER="${BUFFER:0:$bpos}${(U)content}${BUFFER:$epos}"
  zvm_exit_visual_mode
}

# Down case of the visual selection
function zvm_vi_down_case() {
  local ret=($(zvm_selection))
  local bpos=${ret[1]} epos=${ret[2]}
  local content=${BUFFER:$bpos:$((epos-bpos))}
  BUFFER="${BUFFER:0:$bpos}${(L)content}${BUFFER:$epos}"
  zvm_exit_visual_mode
}

# Opposite case of the visual selection
function zvm_vi_opp_case() {
  local ret=($(zvm_selection))
  local bpos=${ret[1]} epos=${ret[2]}
  local content=${BUFFER:$bpos:$((epos-bpos))}
  for ((i=1; i<=$#content; i++)); do
    if [[ ${content[i]} =~ [A-Z] ]]; then
      content[i]=${(L)content[i]}
    elif [[ ${content[i]} =~ [a-z] ]]; then
      content[i]=${(U)content[i]}
    fi
  done
  BUFFER="${BUFFER:0:$bpos}${content}${BUFFER:$epos}"
  zvm_exit_visual_mode
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
  local offset=1

  if [[ ${content: -1} == $'\n' ]]; then
    local pos=${CURSOR}

    # Find the end of current line
    for ((; $pos<$#BUFFER; pos++)); do
      if [[ ${BUFFER:$pos:1} == $'\n' ]]; then
        pos=$pos+1
        break
      fi
    done

    # Special handling if cursor at an empty line
    if zvm_is_empty_line; then
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

    offset=0
    BUFFER="${head}${content}${foot}"
    CURSOR=$pos
  else
    # Special handling if cursor at an empty line
    if zvm_is_empty_line; then
      head="${BUFFER:0:$((CURSOR-1))}"
      foot="${BUFFER:$CURSOR}"
    else
      head="${BUFFER:0:$CURSOR}"
      foot="${BUFFER:$((CURSOR+1))}"
    fi

    BUFFER="${head}${BUFFER:$CURSOR:1}${content}${foot}"
    CURSOR=$CURSOR+$#content
  fi

  # Reresh display and highlight buffer
  zvm_highlight clear
  zvm_highlight custom $(($#head+$offset)) $(($#head+$#content+$offset))
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
    if zvm_is_empty_line; then
      head=${BUFFER:0:$((pos-1))}
      foot=$'\n'${BUFFER:$pos}
      pos=$((pos-1))
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
    CURSOR=$((CURSOR-1))
  fi

  # Reresh display and highlight buffer
  zvm_highlight clear
  zvm_highlight custom $#head $(($#head+$#content))
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

  zvm_exit_visual_mode ${1:-true}
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

  # Return when it's repeating mode
  $ZVM_REPEAT_MODE && return

  # Reset the repeat commands
  if [[ $ZVM_MODE != $ZVM_MODE_NORMAL ]]; then
    local npos=0 ncount=0 ccount=0
    # Count the amount of newline character and the amount of
    # characters after the last newline character.
    while :; do
      # Forward find the last newline character's position
      npos=$(zvm_substr_pos $CUTBUFFER $'\n' $npos)
      if [[ $npos == -1 ]]; then
        if (($ncount == 0)); then
          ccount=$#CUTBUFFER
        fi
        break
      fi
      npos=$((npos+1))
      ncount=$(($ncount + 1))
      ccount=$(($#CUTBUFFER - $npos))
    done
    zvm_reset_repeat_commands $ZVM_MODE c $ncount $ccount
  fi

  zvm_exit_visual_mode false
  zvm_select_vi_mode $ZVM_MODE_INSERT
}

# Change characters from cursor to the end of current line
function zvm_vi_change_eol() {
  local bpos=$CURSOR epos=$CURSOR

  # Find the end of current line
  for ((; $epos<$#BUFFER; epos++)); do
    if [[ "${BUFFER:$epos:1}" == $'\n' ]]; then
      break
    fi
  done

  CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}
  BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"

  zvm_reset_repeat_commands $ZVM_MODE c 0 $#CUTBUFFER
  zvm_select_vi_mode $ZVM_MODE_INSERT
}

# Default handler for unhandled key events
function zvm_default_handler() {
  local keys=$(zvm_keys)
  local extra_keys=$1

  # Exit vi mode if keys is the escape keys
  case $(zvm_escape_non_printed_characters "$keys") in
    '^['|$ZVM_VI_INSERT_ESCAPE_BINDKEY)
      zvm_exit_insert_mode
      ZVM_KEYS=${extra_keys}
      return
      ;;
    [vV]'^['|[vV]$ZVM_VI_VISUAL_ESCAPE_BINDKEY)
      zvm_exit_visual_mode
      ZVM_KEYS=${extra_keys}
      return
      ;;
  esac

  case "$KEYMAP" in
    vicmd)
      case "$keys" in
        [vV]c) zvm_vi_change;;
        [vV]d) zvm_vi_delete;;
        [vV]y) zvm_vi_yank;;
        [vV]S) zvm_change_surround S;;
        [cdyvV]*) zvm_range_handler "${keys}${extra_keys}";;
        *)
          for ((i=0;i<$#keys;i++)) do
            zvm_navigation_handler ${keys:$i:1}
            zvm_highlight
          done
          ;;
      esac
      ;;
    viins|main)
      if [[ "${keys:0:1}" =~ [a-zA-Z0-9\ ] ]]; then
        zvm_self_insert "${keys:0:1}"
        zle redisplay
        ZVM_KEYS="${keys:1}${extra_keys}"
        return
      elif [[ "${keys:0:1}" == $'\e' ]]; then
        zvm_exit_insert_mode
        ZVM_KEYS="${keys:1}${extra_keys}"
        return
      fi
      ;;
    visual)
      ;;
  esac

  ZVM_KEYS=
}

# Read keys for retrieving and executing a widget
function zvm_readkeys_handler() {
  local keymap=${1}
  local keys=${2:-$KEYS}
  local key=
  local widget=

  # Get the keymap if keymap is empty
  if [[ -z $keymap ]]; then
    case "$ZVM_MODE" in
      $ZVM_MODE_INSERT) keymap=viins;;
      $ZVM_MODE_NORMAL) keymap=vicmd;;
      $ZVM_MODE_VISUAL|$ZVM_MODE_VISUAL_LINE) keymap=visual;;
    esac
  fi

  # Read keys and retrieve the widget
  zvm_readkeys $keymap $keys
  keys=${retval[1]}
  widget=${retval[2]}
  key=${retval[3]}

  # Escape space in keys
  keys=${keys//$ZVM_ESCAPE_SPACE/ }
  key=${key//$ZVM_ESCAPE_SPACE/ }

  ZVM_KEYS="${keys}"

  # If the widget is current handler, we should call the default handler
  if [[ "${widget}" == "${funcstack[1]}" ]]; then
    widget=
  fi

  # If the widget isn't matched, we should call the default handler
  if [[ -z ${widget} ]]; then
    zle zvm_default_handler "$key"

    # Push back to the key input stack
    if [[ -n "$ZVM_KEYS" ]]; then
      zle -U "$ZVM_KEYS"
    fi
  else
    zle $widget
  fi

  ZVM_KEYS=
}

# Find and move cursor to next character
function zvm_find_and_move_cursor() {
  local char=$1
  local count=${2:-1}
  local forward=${3:-true}
  local skip=${4:-false}
  local cursor=$CURSOR

  [[ -z $char ]] && return 1

  # Find the specific character
  while :; do
    if $forward; then
      cursor=$((cursor+1))
      ((cursor > $#BUFFER)) && break
    else
      cursor=$((cursor-1))
      ((cursor < 0)) && break
    fi
    if [[ ${BUFFER[$cursor+1]} == $char ]]; then
      count=$((count-1))
    fi
    ((count == 0)) && break
  done

  [[ $count > 0 ]] && return 1

  # Skip the character
  if $skip; then
    if $forward; then
      cursor=$((cursor-1))
    else
      cursor=$((cursor+1))
    fi
  fi

  CURSOR=$cursor
}

# Handle the navigation action
function zvm_navigation_handler() {
  # Return if no keys provided
  [[ -z $1 ]] && return 1

  local keys=$1
  local count=
  local cmd=

  # Retrieve the calling command
  if [[ $keys =~ '^([1-9][0-9]*)?([fFtT].?)$' ]]; then
    count=${match[1]:-1}

    # The length of keys must be 2
    if (( ${#match[2]} < 2)); then
      zvm_enter_oppend_mode

      read -k 1 cmd
      keys+=$cmd

      case "$(zvm_escape_non_printed_characters ${keys[-1]})" in
        $ZVM_VI_OPPEND_ESCAPE_BINDKEY) return 1;;
      esac

      zvm_exit_oppend_mode
    fi

    local forward=true
    local skip=false

    [[ ${keys[-2]} =~ '[FT]' ]] && forward=false
    [[ ${keys[-2]} =~ '[tT]' ]] && skip=true

    cmd=(zvm_find_and_move_cursor ${keys[-1]} $count $forward $skip)
    count=1
  else
    count=${keys:0:-1}
    case ${keys: -1} in
      '^') cmd=(zle vi-first-non-blank);;
      '$') cmd=(zle vi-end-of-line);;
      ' ') cmd=(zle vi-forward-char);;
      '0') cmd=(zle vi-digit-or-beginning-of-line);;
      'h') cmd=(zle vi-backward-char);;
      'j') cmd=(zle down-line-or-history);;
      'k') cmd=(zle up-line-or-history);;
      'l') cmd=(zle vi-forward-char);;
      'w') cmd=(zle vi-forward-word);;
      'W') cmd=(zle vi-forward-blank-word);;
      'e') cmd=(zle vi-forward-word-end);;
      'E') cmd=(zle vi-forward-blank-word-end);;
      'b') cmd=(zle vi-backward-word);;
      'B') cmd=(zle vi-backward-blank-word);;
    esac
  fi

  # Check widget if the widget is empty
  if [[ -z $cmd ]]; then
    return 0
  fi

  # Check if keys includes the count
  if [[ ! $count =~ ^[0-9]+$ ]]; then
    count=1
  fi

  # Call the widget, we can not use variable `i`, since
  # some widgets will affect the variable `i`, and it
  # will cause an infinite loop.
  local init_cursor=$CURSOR
  local last_cursor=$CURSOR
  local exit_code=0
  for ((c=0; c<count; c++)); do
    $cmd

    exit_code=$?

    if [[ ${cmd[1]} == 'zle' ]]; then
      exit_code=0
    elif [[ $exit_code != 0 ]]; then
      break
    fi

    # If the cursor position is no change, we can break
    # the loop and no need to loop so many times, thus
    # when the count is quite large, it will not be
    # stuck for a long time.
    [[ $last_cursor == $CURSOR ]] && break

    last_cursor=$CURSOR
  done

  if [[ $exit_code == 0 ]]; then
    retval=$keys
  else
    CURSOR=$init_cursor
  fi

  return $exit_code
}

# Handle a range of characters
function zvm_range_handler() {
  local keys=$1
  local cursor=$CURSOR
  local key=
  local mode=
  local cmds=($ZVM_MODE)
  local count=1
  local exit_code=0

  # Enter operator pending mode
  zvm_enter_oppend_mode false

  # If the keys is less than 2 keys, we should read more
  # keys (e.g. d, c, y, etc.)
  while (( ${#keys} < 2 )); do
    zvm_update_cursor
    read -k 1 key
    keys="${keys}${key}"
  done

  # If the keys ends in numbers, we should read more
  # keys (e.g. d2, c3, y10, etc.)
  while [[ ${keys: 1} =~ ^[1-9][0-9]*$ ]]; do
    zvm_update_cursor
    read -k 1 key
    keys="${keys}${key}"
  done

  # If the last character is `i` or `a`, we should, we
  # should read one more key
  if [[ ${keys: -1} =~ [ia] ]]; then
    zvm_update_cursor
    read -k 1 key
    keys="${keys}${key}"
  fi

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
      zvm_select_vi_mode $mode false
    fi
  fi

  #######################################
  # Selection Cases:
  #
  # 1. SAMPLE: `word1  word2  w`, CURSOR: at `w` of `word1`
  #
  #  c[we] -> `word1`
  #  c2[we] -> `word1  word2`
  #  ve -> `word1`
  #  v2e -> `word1  word2`
  #  vw -> `word1  w`
  #  v2w -> `word1  word2  w`
  #  [dy]e -> `word1`
  #  [dy]2e -> `word1  word2`
  #  [dy]w -> `word1  `
  #  [dy]2w -> `word1  word2  `
  #  [cdyv]iw -> `word1`
  #  [cdyv]aw -> `word1  `
  #  [cdyv]2iw -> `word1  `
  #  [cdyv]2aw -> `word1  word2  `
  #
  # 2. SAMPLE: `a  bb  c  dd`, CURSOR: at `a`
  #
  #  cw -> `a`
  #  c2w -> `a bb`
  #  ce -> `a bb`
  #  c2e -> `a bb c`
  #
  # 3. SAMPLE: ` .foo.  bar.  baz.`, CURSOR: at `f`
  #
  #  c[WE] -> `foo.`
  #  c2[WE] -> `foo.  bar.`
  #  vE -> `foo.`
  #  v2E -> `foo.  bar.`
  #  vW -> `foo.  b`
  #  v2W -> `foo.  bar.  b`
  #  d2W -> `foo.  bar.  b`
  #  [dy]E -> `foo.`
  #  [dy]2E -> `foo.  bar.`
  #  [dy]W -> `foo.  `
  #  [dy]2W -> `foo.  bar.  `
  #  [cdyv]iW -> `.foo.`
  #  [cdyv]aW -> `.foo.  `
  #  [cdyv]2iW -> `.foo.  `
  #  [cdyv]2aW -> `.foo.  bar.  `
  #
  # 4. SAMPLE: ` .foo.bar.baz.`, CURSOR: at `r`
  #
  #  [cdy]b -> `ba`
  #  [cdy]B -> `.foo.ba`
  #  vb -> `bar`
  #  vB -> `.foo.bar`
  #  vFf -> `foo.bar`
  #  vTf -> `oo.bar`
  #  [cdyv]fz -> `r.baz`
  #  [cdy]Ff -> `foo.ba`
  #  [cdyv]tz -> `r.ba`
  #  [cdy]Tf -> `oo.ba`
  #

  # Pre navigation handling
  local navkey=

  if [[ $keys =~ '^c([1-9][0-9]*)?[ia][wW]$' ]]; then
    count=${match[1]:-1}
    navkey=${keys: -2}
  elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?[ia][eE]$' ]]; then
    navkey=
  elif [[ $keys =~ '^c([1-9][0-9]*)?w$' ]]; then
    zle vi-backward-char
    count=${match[1]:-1}
    navkey='e'
  elif [[ $keys =~ '^c([1-9][0-9]*)?W$' ]]; then
    zle vi-backward-blank-char
    count=${match[1]:-1}
    navkey='E'
  elif [[ $keys =~ '^c([1-9][0-9]*)?e$' ]]; then
    count=${match[1]:-1}
    navkey='e'
  elif [[ $keys =~ '^c([1-9][0-9]*)?E$' ]]; then
    count=${match[1]:-1}
    navkey='E'
  elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?[bB]$' ]]; then
    MARK=$((MARK-1))
    count=${match[1]:-1}
    navkey=${keys: -1}
  elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?([FT].?)$' ]]; then
    MARK=$((MARK-1))
    count=${match[1]:-1}
    navkey=${match[2]}
  elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?j$' ]]; then
    # Exit if there is no line below
    count=${match[1]:-1}
    for ((i=$((CURSOR+1)); i<=$#BUFFER; i++)); do
      [[ ${BUFFER[$i]} == $'\n' ]] && navkey='j'
    done
  elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?k$' ]]; then
    # Exit if there is no line above
    count=${match[1]:-1}
    for ((i=$((CURSOR+1)); i>0; i--)); do
      [[ ${BUFFER[$i]} == $'\n' ]] && navkey='k'
    done
  elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?h$' ]]; then
    MARK=$((MARK-1))
    count=${match[1]:-1}
    navkey='h'

    # Exit if the cursor is at the beginning of a line
    if ((MARK < 0)); then
      navkey=
    elif [[ ${BUFFER[$MARK+1]} == $'\n' ]]; then
      navkey=
    fi
  elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?l$' ]]; then
    count=${match[1]:-1}
    count=$((count-1))
    navkey=${count}l
  elif [[ $keys =~ '^.([1-9][0-9]*)?([^0-9]+)$' ]]; then
    count=${match[1]:-1}
    navkey=${match[2]}
  else
    navkey=
  fi

  # Handle navigation
  case $navkey in
    '') exit_code=1;;
    *[ia][wW])
      local widget=
      local mark=

      # At least 1 time
      if [[ -z $count ]]; then
        count=1
      fi

      # Retrieve the widget
      case ${navkey: -2} in
        iw) widget=select-in-word;;
        aw) widget=select-a-word;;
        iW) widget=select-in-blank-word;;
        aW) widget=select-a-blank-word;;
      esac

      # Execute the widget for `count` times, and
      # save the `mark` position of the first time
      for ((c=0; c<count; c++)); do
        zle $widget
        if (( c == 0 )); then
          mark=$MARK
        fi
        CURSOR=$((CURSOR+1))
        if (($CURSOR >= $#BUFFER)); then
          break
        fi
      done

      MARK=$mark
      CURSOR=$((CURSOR-1))
      ;;
    *)
      local retval=

      # Prevent some actions(e.g. w, e) from affecting the auto
      # suggestion suffix
      BUFFER+=$'\0'

      if zvm_navigation_handler "${count}${navkey}"; then
        keys="${keys[1]}${retval}"
      else
        exit_code=1
      fi

      BUFFER[-1]=''
      ;;
  esac

  # Check if there is no range selected
  if [[ $exit_code != 0 ]]; then
    zvm_exit_visual_mode
    return
  fi

  # Post navigation handling
  if [[ $keys =~ '^[cdy]([1-9][0-9]*)?[ia][wW]$' ]]; then
    cursor=$MARK
  elif [[ $keys =~ '[dy]([1-9][0-9]*)?[wW]' ]]; then
    CURSOR=$((CURSOR-1))
    # If the CURSOR is at the newline character, we should
    # move backward a character
    if [[ "${BUFFER:$CURSOR:1}" == $'\n' ]]; then
      CURSOR=$((CURSOR-1))
    fi
  else
    cursor=$CURSOR
  fi

  # Handle operation
  case "${keys}" in
    c*) zvm_vi_change; cursor=;;
    d*) zvm_vi_delete; cursor=;;
    y*) zvm_vi_yank;;
    [vV]*) cursor=;;
  esac

  # Reset the repeat commands when it's changing or deleting
  if $ZVM_REPEAT_MODE; then
    zvm_exit_visual_mode false
  elif [[ $keys =~ '^[cd].*' ]]; then
    cmds+=($keys)
    zvm_reset_repeat_commands $cmds
  fi

  # Change the cursor position if the cursor is not null
  if [[ ! -z $cursor ]]; then
    CURSOR=$cursor
  fi
}

# Edit command line in EDITOR
function zvm_vi_edit_command_line() {
  # Create a temporary file and save the BUFFER to it
  local tmp_file=$(mktemp ${ZVM_TMPDIR}/zshXXXXXX)

  # Some users may config the noclobber option to prevent from
  # overwriting existing files with the > operator, we should
  # use >! operator to ignore the noclobber.
  echo "$BUFFER" >! "$tmp_file"

  # Edit the file with the specific editor, in case of
  # the warning about input not from a terminal (e.g.
  # vim), we should tell the editor input is from the
  # terminal and not from standard input.
  "${(@Q)${(z)${ZVM_VI_EDITOR}}}" $tmp_file </dev/tty

  # Reload the content to the BUFFER from the temporary
  # file after editing, and delete the temporary file.
  BUFFER=$(cat $tmp_file)
  rm "$tmp_file"

  # Exit the visual mode
  case $ZVM_MODE in
    $ZVM_MODE_VISUAL|$ZVM_MODE_VISUAL_LINE)
      zvm_exit_visual_mode
      ;;
  esac
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
    vsa*) action=a; surround=${keys:3};;
    vys*) action=y; surround=${keys:3};;
    s[dr]*) action=${keys:1:1}; surround=${keys:2};;
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
  zle reset-prompt
}

# Change surround in vicmd or visual mode
function zvm_change_surround() {
  local ret=($(zvm_parse_surround_keys))
  local action=${1:-${ret[1]}}
  local surround=${2:-${ret[2]//$ZVM_ESCAPE_SPACE/ }}
  local bpos=${3} epos=${4}
  local is_appending=false
  case $action in
    S|y|a) is_appending=true;;
  esac
  if $is_appending; then
    if [[ -z $bpos && -z $epos ]]; then
      ret=($(zvm_selection))
      bpos=${ret[1]} epos=${ret[2]}
    fi
  else
    ret=($(zvm_search_surround "$surround"))
    (( ${#ret[@]} )) || return
    bpos=${ret[1]} epos=${ret[2]}
    zvm_highlight custom $bpos $(($bpos+1))
    zvm_highlight custom $epos $(($epos+1))
  fi
  local key=
  case $action in
    c|r)
      zvm_enter_oppend_mode
      read -k 1 key
      zvm_exit_oppend_mode
      ;;
    S|y|a)
      if [[ -z $surround ]]; then
        zvm_enter_oppend_mode
        read -k 1 key
        zvm_exit_oppend_mode
      else
        key=$surround
      fi
      if [[ $ZVM_MODE == $ZVM_MODE_VISUAL ]]; then
        zle visual-mode
      fi
      ;;
  esac

  # Check if it is ESCAPE key (<ESC> or ZVM_VI_ESCAPE_BINDKEY)
  case "$key" in
    $'\e'|"${ZVM_VI_ESCAPE_BINDKEY//\^\[/$'\e'}")
      zvm_highlight clear
      return
  esac

  # Start changing surround
  ret=($(zvm_match_surround "$key"))
  local bchar=${${ret[1]//$ZVM_ESCAPE_SPACE/ }:-$key}
  local echar=${${ret[2]//$ZVM_ESCAPE_SPACE/ }:-$key}
  local value=$($is_appending && echo 0 || echo 1 )
  local head=${BUFFER:0:$bpos}
  local body=${BUFFER:$((bpos+value)):$((epos-(bpos+value)))}
  local foot=${BUFFER:$((epos+value))}
  BUFFER="${head}${bchar}${body}${echar}${foot}"

  # Clear highliht
  zvm_highlight clear

  case $action in
    S|y|a) zvm_select_vi_mode $ZVM_MODE_NORMAL;;
  esac
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

# Repeat last change
function zvm_repeat_change() {
  ZVM_REPEAT_MODE=true

  local cmd=${ZVM_REPEAT_COMMANDS[2]}

  # Handle repeat command
  case $cmd in
    [aioAIO]) zvm_repeat_insert;;
    c) zvm_repeat_vi_change;;
    [cd]*) zvm_repeat_range_change;;
    R) zvm_repeat_replace;;
    r) zvm_repeat_replace_chars;;
    *) zle vi-repeat-change;;
  esac

  zle redisplay

  ZVM_REPEAT_MODE=false
}

# Repeat inserting characters
function zvm_repeat_insert() {
  local cmd=${ZVM_REPEAT_COMMANDS[2]}
  local cmds=(${ZVM_REPEAT_COMMANDS[3,-1]})

  # Pre-handle the command
  case $cmd in
    a) CURSOR+=1;;
    o)
      zle vi-backward-char
      zle vi-end-of-line
      LBUFFER+=$'\n'
      ;;
    A)
      zle vi-end-of-line
      CURSOR=$((CURSOR+1))
      ;;
    I) zle vi-first-non-blank;;
    O)
      zle vi-digit-or-beginning-of-line
      LBUFFER+=$'\n'
      CURSOR=$((CURSOR-1))
      ;;
  esac

  # Insert characters
  for ((i=1; i<=${#cmds[@]}; i++)); do
    cmd="${cmds[$i]}"

    # Hanlde the backspace command
    if [[ $cmd == '' ]]; then
      if (($#LBUFFER > 0)); then
        LBUFFER=${LBUFFER:0:-1}
      fi
      continue
    fi

    # The length of character should be 1
    if (($#cmd == 1)); then
      LBUFFER+=$cmd
    fi
  done
}

# Repeat changing visual characters
function zvm_repeat_vi_change() {
  local mode=${ZVM_REPEAT_COMMANDS[1]}
  local cmds=(${ZVM_REPEAT_COMMANDS[3,-1]})

  # Backward move cursor to the beginning of line
  if [[ $mode == $ZVM_MODE_VISUAL_LINE ]]; then
    zle vi-digit-or-beginning-of-line
  fi

  local ncount=${cmds[1]}
  local ccount=${cmds[2]}
  local pos=$CURSOR epos=$CURSOR

  # Forward expand the characters to the Nth newline character
  for ((i=0; i<$ncount; i++)); do
    pos=$(zvm_substr_pos $BUFFER $'\n' $pos)
    if [[ $pos == -1 ]]; then
      epos=$#BUFFER
      break
    fi
    pos=$((pos+1))
    epos=$pos
  done

  # Forward expand the remaining characters
  for ((i=0; i<$ccount; i++)); do
    local char=${BUFFER[$epos+i]}
    if [[ $char == $'\n' || $char == '' ]]; then
      ccount=$i
      break
    fi
  done

  epos=$((epos+ccount))
  RBUFFER=${RBUFFER:$((epos-CURSOR))}
}

# Repeat changing a range of characters
function zvm_repeat_range_change() {
  local cmd=${ZVM_REPEAT_COMMANDS[2]}

  # Remove characters
  zvm_range_handler $cmd

  # Insert characters
  zvm_repeat_insert
}

# Repeat replacing
function zvm_repeat_replace() {
  local cmds=(${ZVM_REPEAT_COMMANDS[3,-1]})
  local cmd=
  local cursor=$CURSOR

  for ((i=1; i<=${#cmds[@]}; i++)); do
    cmd="${cmds[$i]}"

    # If the cmd or the character at cursor is a newline character,
    # or the cursor is at the end of buffer, we should insert the
    # cmd instead of replacing with the cmd.
    if [[ $cmd == $'\n' ||
      $BUFFER[$cursor+1] == $'\n' ||
      $BUFFER[$cursor+1] == ''
    ]]; then
      LBUFFER+=$cmd
    else
      BUFFER[$cursor+1]=$cmd
    fi

    cursor=$((cursor+1))
    CURSOR=$cursor
  done

  # The cursor position should go back one character after
  # exiting the replace mode
  zle vi-backward-char
}

# Repeat replacing characters
function zvm_repeat_replace_chars() {
  local mode=${ZVM_REPEAT_COMMANDS[1]}
  local cmds=(${ZVM_REPEAT_COMMANDS[3,-1]})
  local cmd=

  # Replacment of visual mode should move backward cursor to the
  # begin of current line, and replacing to the end of last line.
  if [[ $mode == $ZVM_MODE_VISUAL_LINE ]]; then
    zle vi-digit-or-beginning-of-line
    cmds+=($'\n')
  fi

  local cursor=$((CURSOR+1))

  for ((i=1; i<=${#cmds[@]}; i++)); do
    cmd="${cmds[$i]}"

    # If we meet a newline character in the buffer, we should keep
    # stop replacing, util we meet next newline character command.
    if [[ ${BUFFER[$cursor]} == $'\n' ]]; then
      if [[ $cmd == $'\n' ]]; then
        cursor=$((cursor+1))
      fi
      continue
    fi

    # A newline character command should keep replacing with last
    # character, until we meet a newline character in the buffer,
    # then we use next command.
    if [[ $cmd == $'\n' ]]; then
      i=$((i-1))
      cmd="${cmds[$i]}"
    fi

    # The length of character should be 1
    if (($#cmd == 1)); then
      BUFFER[$cursor]="${cmd}"
    fi

    cursor=$((cursor+1))

    # Break when it reaches the end
    if ((cursor > $#BUFFER)); then
      break
    fi
  done
}

# Select a word under the cursor
function zvm_select_in_word() {
  local cursor=${1:-$CURSOR}
  local buffer=${2:-$BUFFER}
  local bpos=$cursor epos=$cursor
  local pattern='[0-9a-zA-Z_]'

  if ! [[ "${buffer:$cursor:1}" =~ $pattern ]]; then
    pattern="[^${pattern:1:-1} ]"
  fi

  for ((; $bpos>=0; bpos--)); do
    [[ "${buffer:$bpos:1}" =~ $pattern ]] || break
  done
  for ((; $epos<$#buffer; epos++)); do
    [[ "${buffer:$epos:1}" =~ $pattern ]] || break
  done

  bpos=$((bpos+1))

  # The ending position must be greater than 0
  if (( epos > 0 )); then
    epos=$((epos-1))
  fi

  echo $bpos $epos
}

# Switch keyword
function zvm_switch_keyword() {
  local bpos= epos= cpos=$CURSOR

  # Cursor position cases:
  #
  # 1. Cursor on symbol:
  # 2+2   => +
  # 2-2   => -
  # 2 + 2 => +
  # 2 +2  => +2
  # 2 -2  => -2
  # 2 -a  => -a
  #
  # 2. Cursor on number or alpha:
  # 2+2   => +2
  # 2-2   => -2
  # 2 + 2 => 2
  # 2 +2  => +2
  # 2 -2  => -2
  # 2 -a  => -a

  # If cursor is on the `+` or `-`, we need to check if it is a
  # number with a sign or an operator, only the number needs to
  # forward the cursor.
  if [[ ${BUFFER:$cpos:2} =~ [+-][0-9] ]]; then
    if [[ $cpos == 0 || ${BUFFER:$((cpos-1)):1} =~ [^0-9] ]]; then
      cpos=$((cpos+1))
    fi

  # If cursor is on the `+` or `-`, we need to check if it is a
  # short option, only the short option needs to forward the cursor.
  elif [[ ${BUFFER:$cpos:2} =~ [+-][a-zA-Z] ]]; then
    if [[ $cpos == 0 || ${BUFFER:$((cpos-1)):1} == ' ' ]]; then
      cpos=$((cpos+1))
    fi
  fi

  local result=($(zvm_select_in_word $cpos))
  bpos=${result[1]} epos=$((${result[2]}+1))

  # Move backward the cursor
  if [[ $bpos != 0 && ${BUFFER:$((bpos-1)):1} == [+-] ]]; then
    bpos=$((bpos-1))
  fi

  local word=${BUFFER:$bpos:$((epos-bpos))}
  local keys=$(zvm_keys)

  if [[ $keys == '' ]]; then
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
    # 1. Increment:
    # 0xDe => 0xdf
    # 0xdE => 0xDF
    # 0xde0 => 0xddf
    # 0xffffffffffffffff => 0x0000000000000000
    # 0X9 => 0XA
    # 0Xdf => 0Xe0
    #
    # 2. Decrement:
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
    # 1. Increment:
    # 0b1 => 0b10
    # 0x1111111111111111111111111111111111111111111111111111111111111111 =>
    # 0x0000000000000000000000000000000000000000000000000000000000000000
    # 0B0 => 0B1
    #
    # 2. Decrement:
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
  elif [[ $word =~ ([-+]?[0-9]+) ]]; then
    # Decimal cases:
    #
    # 1. Increment:
    # 0 => 1
    # 99 => 100
    #
    # 2. Decrement:
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

    # Check if need the plus sign prefix
    if [[ ${word:$bpos:1} == '+' ]]; then
      result="+${result}"
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
  local bpos=0 epos=$#word

  # Remove option prefix
  if [[ $word =~ (^[+-]{0,2}) ]]; then
    local prefix=${match[1]}
    bpos=$mend
    word=${word:$bpos}
  fi

  case ${(L)word} in
    true) result=false;;
    false) result=true;;
    yes) result=no;;
    no) result=yes;;
    on) result=off;;
    off) result=on;;
    y) result=n;;
    n) result=y;;
    t) result=f;;
    f) result=t;;
    *) return;;
  esac

  # Transform the case
  if [[ $word =~ ^[A-Z]+$ ]]; then
    result=${(U)result}
  elif [[ $word =~ ^[A-Z] ]]; then
    result=${(U)result:0:1}${result:1}
  fi

  echo $result $bpos $epos
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

  # Return if no match
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

# Switch operator keyword
function zvm_switch_operator() {
  local word=$1
  local increase=$2
  local result=

  case ${(L)word} in
    '&&') result='||';;
    '||') result='&&';;
    '++') result='--';;
    '--') result='++';;
    '==') result='!=';;
    '!=') result='==';;
    '===') result='!==';;
    '!==') result='===';;
    '+') result='-';;
    '-') result='*';;
    '*') result='/';;
    '/') result='+';;
    'and') result='or';;
    'or') result='and';;
    *) return;;
  esac

  # Transform the case
  if [[ $word =~ ^[A-Z]+$ ]]; then
    result=${(U)result}
  elif [[ $word =~ ^[A-Z] ]]; then
    result=${(U)result:0:1}${result:1}
  fi

  # Since the `echo` command can not print the character
  # `-`, here we use `printf` command alternatively.
  printf "%s 0 $#word" "${result}"
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

  # Return if no match
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
  local redraw=false

  # Hanlde region by the option
  case "$opt" in
    mode)
      case "$ZVM_MODE" in
        $ZVM_MODE_VISUAL|$ZVM_MODE_VISUAL_LINE)
          local ret=($(zvm_calc_selection))
          local bpos=$((ret[1])) epos=$((ret[2]))
          local bg=$ZVM_VI_HIGHLIGHT_BACKGROUND
          local fg=$ZVM_VI_HIGHLIGHT_FOREGROUND
          local es=$ZVM_VI_HIGHLIGHT_EXTRASTYLE
          region=("$bpos $epos fg=$fg,bg=$bg,$es")
          ;;
      esac
      redraw=true
      ;;
    custom)
      local bpos=$2 epos=$3
      local bg=${4:-$ZVM_VI_HIGHLIGHT_BACKGROUND}
      local fg=${5:-$ZVM_VI_HIGHLIGHT_FOREGROUND}
      local es=${6:-$ZVM_VI_HIGHLIGHT_EXTRASTYLE}
      region=("${ZVM_REGION_HIGHLIGHT[@]}")
      region+=("$bpos $epos fg=$fg,bg=$bg,$es")
      redraw=true
      ;;
    clear)
      zle redisplay
      redraw=true
      ;;
    redraw) redraw=true;;
  esac

  # Update region highlight
  if (( $#region > 0 )) || [[ "$opt" == 'clear' ]]; then

    # Remove old region highlight
    local rawhighlight=()
    for ((i=1; i<=${#region_highlight[@]}; i++)); do
      local raw=true
      local spl=(${(@s/ /)region_highlight[i]})
      local pat="${spl[1]} ${spl[2]}"
      for ((j=1; j<=${#ZVM_REGION_HIGHLIGHT[@]}; j++)); do
        if [[ "$pat" == "${ZVM_REGION_HIGHLIGHT[j]:0:$#pat}" ]]; then
          raw=false
          break
        fi
      done
      if $raw; then
        rawhighlight+=("${region_highlight[i]}")
      fi
    done

    # Assign new region highlight
    ZVM_REGION_HIGHLIGHT=("${region[@]}")
    region_highlight=("${rawhighlight[@]}" "${ZVM_REGION_HIGHLIGHT[@]}")
  fi

  # Check if we need to refresh the region highlight
  if $redraw; then
    zle -R
  fi
}

# Enter the visual mode
function zvm_enter_visual_mode() {
  local mode=
  local last_mode=$ZVM_MODE
  local last_region=

  # Exit the visual mode
  case $last_mode in
    $ZVM_MODE_VISUAL|$ZVM_MODE_VISUAL_LINE)
      last_region=($MARK $CURSOR)
      zvm_exit_visual_mode
      ;;
  esac

  case "${1:-$(zvm_keys)}" in
    v) mode=$ZVM_MODE_VISUAL;;
    V) mode=$ZVM_MODE_VISUAL_LINE;;
    *) mode=$last_mode;;
  esac

  # We should just exit the visual mdoe if current mode
  # is the same with last visual mode
  if [[ $last_mode == $mode ]]; then
    return
  fi

  zvm_select_vi_mode $mode

  # Recover the region when changing to another visual mode
  if [[ -n $last_region ]]; then
    MARK=$last_region[1]
    CURSOR=$last_region[2]
    zle redisplay
  fi
}

# Exit the visual mode
function zvm_exit_visual_mode() {
  case "$ZVM_MODE" in
    $ZVM_MODE_VISUAL) zle visual-mode;;
    $ZVM_MODE_VISUAL_LINE) zle visual-line-mode;;
  esac
  zvm_highlight clear
  zvm_select_vi_mode $ZVM_MODE_NORMAL ${1:-true}
}

# Enter the vi insert mode
function zvm_enter_insert_mode() {
  local keys=${1:-$(zvm_keys)}

  if [[ $keys == 'i' ]]; then
    ZVM_INSERT_MODE='i'
  elif [[ $keys == 'a' ]]; then
    ZVM_INSERT_MODE='a'
    if ! zvm_is_empty_line; then
      CURSOR=$((CURSOR+1))
    fi
  fi

  zvm_reset_repeat_commands $ZVM_MODE_NORMAL $ZVM_INSERT_MODE
  zvm_select_vi_mode $ZVM_MODE_INSERT
}

# Exit the vi insert mode
function zvm_exit_insert_mode() {
  ZVM_INSERT_MODE=
  zvm_select_vi_mode $ZVM_MODE_NORMAL
}

# Enter the vi operator pending mode
function zvm_enter_oppend_mode() {
  ZVM_OPPEND_MODE=true
  ${1:-true} && zvm_update_cursor
}

# Exit the vi operator pending mode
function zvm_exit_oppend_mode() {
  ZVM_OPPEND_MODE=false
  ${1:-true} && zvm_update_cursor
}

# Insert at the beginning of the line
function zvm_insert_bol() {
  ZVM_INSERT_MODE='I'
  zle vi-first-non-blank
  zvm_select_vi_mode $ZVM_MODE_INSERT
  zvm_reset_repeat_commands $ZVM_MODE_NORMAL $ZVM_INSERT_MODE
}

# Append at the end of the line
function zvm_append_eol() {
  ZVM_INSERT_MODE='A'
  zle vi-end-of-line
  CURSOR=$((CURSOR+1))
  zvm_select_vi_mode $ZVM_MODE_INSERT
  zvm_reset_repeat_commands $ZVM_MODE_NORMAL $ZVM_INSERT_MODE
}

# Self insert content to cursor position
function zvm_self_insert() {
  local keys=${1:-$KEYS}

  # Update the autosuggestion
  if [[ ${POSTDISPLAY:0:$#keys} == $keys ]]; then
    POSTDISPLAY=${POSTDISPLAY:$#keys}
  else
    POSTDISPLAY=
  fi

  LBUFFER+=${keys}
}

# Reset the repeat commands
function zvm_reset_repeat_commands() {
  ZVM_REPEAT_RESET=true
  ZVM_REPEAT_COMMANDS=($@)
}

# Select vi mode
function zvm_select_vi_mode() {
  local mode=$1
  local reset_prompt=${2:-true}

  # Check if current mode is the same with the new mode
  if [[ $mode == "$ZVM_MODE" ]]; then
    zvm_update_cursor
    mode=
  fi

  zvm_exec_commands 'before_select_vi_mode'

  # Some plugins would reset the prompt when we select the
  # keymap, so here we postpone executing reset-prompt.
  zvm_postpone_reset_prompt true

  # Exit operator pending mode
  if $ZVM_OPPEND_MODE; then
    zvm_exit_oppend_mode false
  fi

  case $mode in
    $ZVM_MODE_NORMAL)
      ZVM_MODE=$ZVM_MODE_NORMAL
      zvm_update_cursor
      zle vi-cmd-mode
      ;;
    $ZVM_MODE_INSERT)
      ZVM_MODE=$ZVM_MODE_INSERT
      zvm_update_cursor
      zle vi-insert
      ;;
    $ZVM_MODE_VISUAL)
      ZVM_MODE=$ZVM_MODE_VISUAL
      zvm_update_cursor
      zle visual-mode
      ;;
    $ZVM_MODE_VISUAL_LINE)
      ZVM_MODE=$ZVM_MODE_VISUAL_LINE
      zvm_update_cursor
      zle visual-line-mode
      ;;
    $ZVM_MODE_REPLACE)
      ZVM_MODE=$ZVM_MODE_REPLACE
      zvm_enter_oppend_mode
      ;;
  esac

  # This aspect provides you a moment to do something, such as
  # update the cursor, prompt and so on.
  zvm_exec_commands 'after_select_vi_mode'

  # Stop and trigger reset-prompt
  $reset_prompt && zvm_postpone_reset_prompt false true

  # Start the lazy keybindings when the first time entering the
  # normal mode, when the mode is the same as last mode, we get
  # empty value for $mode.
  if [[ $mode == $ZVM_MODE_NORMAL ]] &&
    (( $#ZVM_LAZY_KEYBINDINGS_LIST > 0 )); then

    zvm_exec_commands 'before_lazy_keybindings'

    # Here we should unset the list for normal keybindings
    local list=("${ZVM_LAZY_KEYBINDINGS_LIST[@]}")
    unset ZVM_LAZY_KEYBINDINGS_LIST

    for r in "${list[@]}"; do
      eval "zvm_bindkey ${r}"
    done

    zvm_exec_commands 'after_lazy_keybindings'
  fi
}

# Postpone reset prompt
function zvm_postpone_reset_prompt() {
  local toggle=$1
  local force=$2

  if $toggle; then
    ZVM_POSTPONE_RESET_PROMPT=true
  else
    if [[ $ZVM_POSTPONE_RESET_PROMPT == false || $force ]]; then
      ZVM_POSTPONE_RESET_PROMPT=
      zle reset-prompt
    else
      ZVM_POSTPONE_RESET_PROMPT=
    fi
  fi
}

# Reset prompt
function zvm_reset_prompt() {
  # Return if postponing is enabled
  if [[ -n $ZVM_POSTPONE_RESET_PROMPT ]]; then
    ZVM_POSTPONE_RESET_PROMPT=false
    return
  fi

  local -i retval
  if [[ -z "$rawfunc" ]]; then
    zle .reset-prompt -- "$@"
  else
    $rawfunc -- "$@"
  fi

  return retval
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

function zvm_set_cursor() {
  # Term of vim isn't supported
  if [[ -n $VIMRUNTIME ]]; then
    return
  fi

  echo -ne "$1"
}

# Get the escape sequence of cursor style
function zvm_cursor_style() {
  local style=${(L)1}
  local term=${2:-$ZVM_TERM}

  case $term in
    # For xterm and rxvt and their derivatives use the same escape
    # sequences as the VT520 terminal. And screen, konsole, alacritty
    # and st implement a superset of VT100 and VT100, they support
    # 256 colors the same way xterm does.
    xterm*|rxvt*|screen*|tmux*|konsole*|alacritty*|st*)
      case $style in
        $ZVM_CURSOR_BLOCK) style='\e[2 q';;
        $ZVM_CURSOR_UNDERLINE) style='\e[4 q';;
        $ZVM_CURSOR_BEAM) style='\e[6 q';;
        $ZVM_CURSOR_BLINKING_BLOCK) style='\e[1 q';;
        $ZVM_CURSOR_BLINKING_UNDERLINE) style='\e[3 q';;
        $ZVM_CURSOR_BLINKING_BEAM) style='\e[5 q';;
        $ZVM_CURSOR_USER_DEFAULT) style='\e[0 q';;
      esac
      ;;
    *) style='\e[0 q';;
  esac

  # Restore default cursor color
  if [[ $style == '\e[0 q' ]]; then
    local old_style=

    case $ZVM_MODE in
      $ZVM_MODE_INSERT) old_style=$ZVM_INSERT_MODE_CURSOR;;
      $ZVM_MODE_NORMAL) old_style=$ZVM_NORMAL_MODE_CURSOR;;
      $ZVM_MODE_OPPEND) old_style=$ZVM_OPPEND_MODE_CURSOR;;
    esac

    if [[ $old_style =~ '\e\][0-9]+;.+\a' ]]; then
      style=$style'\e\e]112\a'
    fi
  fi

  echo $style
}

# Update the cursor according current vi mode
function zvm_update_cursor() {

  # Check if we need to update the cursor style
  $ZVM_CURSOR_STYLE_ENABLED || return

  local mode=$1
  local shape=

  # Check if it is operator pending mode
  if $ZVM_OPPEND_MODE; then
    mode=opp
    shape=$(zvm_cursor_style $ZVM_OPPEND_MODE_CURSOR)
  fi

  # Get cursor shape by the mode
  case "${mode:-$ZVM_MODE}" in
    $ZVM_MODE_NORMAL)
      shape=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
      ;;
    $ZVM_MODE_INSERT)
      shape=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)
      ;;
    $ZVM_MODE_VISUAL)
      shape=$(zvm_cursor_style $ZVM_VISUAL_MODE_CURSOR)
      ;;
    $ZVM_MODE_VISUAL_LINE)
      shape=$(zvm_cursor_style $ZVM_VISUAL_LINE_MODE_CURSOR)
      ;;
  esac

  if [[ $shape ]]; then
    zvm_set_cursor $shape
  fi
}

# Updates highlight region
function zvm_update_highlight() {
  case "$ZVM_MODE" in
    $ZVM_MODE_VISUAL|$ZVM_MODE_VISUAL_LINE)
      zvm_highlight
      ;;
  esac
}

# Updates repeat commands
function zvm_update_repeat_commands() {
  # We don't need to update the repeat commands if current
  # mode is already the repeat mode.
  $ZVM_REPEAT_MODE && return

  # We don't need to update the repeat commands if it is
  # reseting the repeat commands.
  if $ZVM_REPEAT_RESET; then
    ZVM_REPEAT_RESET=false
    return
  fi

  # We update the repeat commands when it's the insert mode
  [[ $ZVM_MODE == $ZVM_MODE_INSERT ]] || return

  local char=$KEYS

  # If current key is an arrow key, we should do something
  if [[ "$KEYS" =~ '\[[ABCD]' ]]; then
    # If last key is also an arrow key, we just replace it
    if [[ ${ZVM_REPEAT_COMMANDS[-1]} =~ '\[[ABCD]' ]]; then
      ZVM_REPEAT_COMMANDS=(${ZVM_REPEAT_COMMANDS[@]:0:-1})
    fi
  else
    # If last command is arrow key movement, we should reset
    # the repeat commands with i(nsert) command
    if [[ ${ZVM_REPEAT_COMMANDS[-1]} =~ '\[[ABCD]' ]]; then
      zvm_reset_repeat_commands $ZVM_MODE_NORMAL i
    fi
    char=${BUFFER[$CURSOR]}
  fi

  # If current key is backspace key, we should remove last
  # one, until it has only the mode and inital command
  if [[ "$KEYS" == '' ]]; then
    if ((${#ZVM_REPEAT_COMMANDS[@]} > 2)) &&
      [[ ${ZVM_REPEAT_COMMANDS[-1]} != '' ]]; then
      ZVM_REPEAT_COMMANDS=(${ZVM_REPEAT_COMMANDS[@]:0:-1})
    elif (($#LBUFFER > 0)); then
      ZVM_REPEAT_COMMANDS+=($KEYS)
    fi
  else
    ZVM_REPEAT_COMMANDS+=($char)
  fi
}

# Updates editor information when line pre redraw
function zvm_zle-line-pre-redraw() {
  # Fix cursor style is not updated in tmux environment, when
  # there are one more panel in the same window, the program
  # in other panel could change the cursor shape, we need to
  # update cursor style when line is redrawing.
  if [[ -n $TMUX ]]; then
    zvm_update_cursor
    # Fix display is not updated in the terminal of IntelliJ IDE.
    # We should update display only when the last widget isn't a
    # completion widget
    [[ $LASTWIDGET =~ 'complet' ]] || zle redisplay
  fi
  zvm_update_highlight
  zvm_update_repeat_commands
}

# Start every prompt in the correct vi mode
function zvm_zle-line-init() {
  # Save last mode
  local mode=${ZVM_MODE:-$ZVM_MODE_INSERT}

  # It's neccessary to set to insert mode when line init
  # and we don't need to reset prompt.
  zvm_select_vi_mode $ZVM_MODE_INSERT false

  # Select line init mode and reset prompt
  case ${ZVM_LINE_INIT_MODE:-$mode} in
    $ZVM_MODE_INSERT) zvm_select_vi_mode $ZVM_MODE_INSERT;;
    *) zvm_select_vi_mode $ZVM_MODE_NORMAL;;
  esac
}

# Restore the user default cursor style after prompt finish
function zvm_zle-line-finish() {
  # When we start a program (e.g. vim, bash, etc.) from the
  # command line, the cursor style is inherited by other
  # programs, so that we need to reset the cursor style to
  # default before executing a command and set the custom
  # style again when the command exits. This way makes any
  # other interactive CLI application would not be affected
  # by it.
  local shape=$(zvm_cursor_style $ZVM_CURSOR_USER_DEFAULT)
  zvm_set_cursor $shape
}

# Initialize vi-mode for widgets, keybindings, etc.
function zvm_init() {
  # Check if it has been initalized
  if $ZVM_INIT_DONE; then
    return;
  fi

  # Mark plugin initial status
  ZVM_INIT_DONE=true

  zvm_exec_commands 'before_init'

  # Correct the readkey engine
  case $ZVM_READKEY_ENGINE in
    $ZVM_READKEY_ENGINE_NEX|$ZVM_READKEY_ENGINE_ZLE);;
    *)
      echo -n "Warning: Unsupported readkey engine! "
      echo "ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE"
      ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_DEFAULT
      ;;
  esac

  # Reduce ESC delay (zle default is 0.4 seconds)
  # Set to 0.01 second delay for taking over the key input processing
  case $ZVM_READKEY_ENGINE in
    $ZVM_READKEY_ENGINE_NEX) KEYTIMEOUT=1;;
    $ZVM_READKEY_ENGINE_ZLE) KEYTIMEOUT=$(($ZVM_KEYTIMEOUT*100));;
  esac

  # Create User-defined widgets
  zvm_define_widget zvm_default_handler
  zvm_define_widget zvm_readkeys_handler
  zvm_define_widget zvm_backward_kill_region
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
  zvm_define_widget zvm_enter_oppend_mode
  zvm_define_widget zvm_exit_oppend_mode
  zvm_define_widget zvm_exchange_point_and_mark
  zvm_define_widget zvm_open_line_below
  zvm_define_widget zvm_open_line_above
  zvm_define_widget zvm_insert_bol
  zvm_define_widget zvm_append_eol
  zvm_define_widget zvm_self_insert
  zvm_define_widget zvm_vi_replace
  zvm_define_widget zvm_vi_replace_chars
  zvm_define_widget zvm_vi_substitute
  zvm_define_widget zvm_vi_substitute_whole_line
  zvm_define_widget zvm_vi_change
  zvm_define_widget zvm_vi_change_eol
  zvm_define_widget zvm_vi_delete
  zvm_define_widget zvm_vi_yank
  zvm_define_widget zvm_vi_put_after
  zvm_define_widget zvm_vi_put_before
  zvm_define_widget zvm_vi_up_case
  zvm_define_widget zvm_vi_down_case
  zvm_define_widget zvm_vi_opp_case
  zvm_define_widget zvm_vi_edit_command_line
  zvm_define_widget zvm_repeat_change
  zvm_define_widget zvm_switch_keyword

  # Override standard widgets
  zvm_define_widget zle-line-pre-redraw zvm_zle-line-pre-redraw

  # Ensure the correct cursor style when an interactive program
  # (e.g. vim, bash, etc.) starts and exits
  zvm_define_widget zle-line-init zvm_zle-line-init
  zvm_define_widget zle-line-finish zvm_zle-line-finish

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
  zvm_bindkey viins '^W' backward-kill-word
  zvm_bindkey viins '^U' zvm_viins_undo
  zvm_bindkey viins '^Y' yank
  zvm_bindkey viins '^_' undo

  # Mode agnostic editing
  zvm_bindkey viins '^[[H'  beginning-of-line
  zvm_bindkey vicmd '^[[H'  beginning-of-line
  zvm_bindkey viins '^[[F'  end-of-line
  zvm_bindkey vicmd '^[[F'  end-of-line
  zvm_bindkey viins '^[[3~' delete-char
  zvm_bindkey vicmd '^[[3~' delete-char

  # History search
  zvm_bindkey viins '^R' history-incremental-search-backward
  zvm_bindkey viins '^S' history-incremental-search-forward
  zvm_bindkey viins '^P' up-line-or-history
  zvm_bindkey viins '^N' down-line-or-history

  # Insert mode
  zvm_bindkey vicmd 'i'  zvm_enter_insert_mode
  zvm_bindkey vicmd 'a'  zvm_enter_insert_mode
  zvm_bindkey vicmd 'I'  zvm_insert_bol
  zvm_bindkey vicmd 'A'  zvm_append_eol

  # Other key bindings
  zvm_bindkey vicmd  'v' zvm_enter_visual_mode
  zvm_bindkey vicmd  'V' zvm_enter_visual_mode
  zvm_bindkey visual 'o' zvm_exchange_point_and_mark
  zvm_bindkey vicmd  'o' zvm_open_line_below
  zvm_bindkey vicmd  'O' zvm_open_line_above
  zvm_bindkey vicmd  'r' zvm_vi_replace_chars
  zvm_bindkey vicmd  'R' zvm_vi_replace
  zvm_bindkey vicmd  's' zvm_vi_substitute
  zvm_bindkey vicmd  'S' zvm_vi_substitute_whole_line
  zvm_bindkey vicmd  'C' zvm_vi_change_eol
  zvm_bindkey visual 'c' zvm_vi_change
  zvm_bindkey visual 'd' zvm_vi_delete
  zvm_bindkey visual 'y' zvm_vi_yank
  zvm_bindkey vicmd  'p' zvm_vi_put_after
  zvm_bindkey vicmd  'P' zvm_vi_put_before
  zvm_bindkey visual 'U' zvm_vi_up_case
  zvm_bindkey visual 'u' zvm_vi_down_case
  zvm_bindkey visual '~' zvm_vi_opp_case
  zvm_bindkey visual 'v' zvm_vi_edit_command_line
  zvm_bindkey vicmd  '.' zvm_repeat_change

  zvm_bindkey vicmd '^A' zvm_switch_keyword
  zvm_bindkey vicmd '^X' zvm_switch_keyword

  # Keybindings for escape key and some specials
  local exit_oppend_mode_widget=
  local exit_insert_mode_widget=
  local exit_visual_mode_widget=
  local default_handler_widget=

  case $ZVM_READKEY_ENGINE in
    $ZVM_READKEY_ENGINE_NEX)
      exit_oppend_mode_widget=zvm_readkeys_handler
      exit_insert_mode_widget=zvm_readkeys_handler
      exit_visual_mode_widget=zvm_readkeys_handler
      ;;
    $ZVM_READKEY_ENGINE_ZLE)
      exit_insert_mode_widget=zvm_exit_insert_mode
      exit_visual_mode_widget=zvm_exit_visual_mode
      default_handler_widget=zvm_default_handler
      ;;
  esac

  # Bind custom escape key
  zvm_bindkey vicmd  "$ZVM_VI_OPPEND_ESCAPE_BINDKEY" $exit_oppend_mode_widget
  zvm_bindkey viins  "$ZVM_VI_INSERT_ESCAPE_BINDKEY" $exit_insert_mode_widget
  zvm_bindkey visual "$ZVM_VI_VISUAL_ESCAPE_BINDKEY" $exit_visual_mode_widget

  # Bind the default escape key if the escape key is not the default
  case "$ZVM_VI_OPPEND_ESCAPE_BINDKEY" in
    '^['|'\e') ;;
    *) zvm_bindkey vicmd '^[' $exit_oppend_mode_widget;;
  esac
  case "$ZVM_VI_INSERT_ESCAPE_BINDKEY" in
    '^['|'\e') ;;
    *) zvm_bindkey viins '^[' $exit_insert_mode_widget;;
  esac
  case "$ZVM_VI_VISUAL_ESCAPE_BINDKEY" in
    '^['|'\e') ;;
    *) zvm_bindkey visual '^[' $exit_visual_mode_widget;;
  esac

  # Bind and overwrite original y/d/c of vicmd
  for c in {y,d,c}; do
    zvm_bindkey vicmd "$c" $default_handler_widget
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

# Check if a command is existed
function zvm_exist_command() {
  command -v "$1" >/dev/null
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

# Initialize this plugin according to the mode
case $ZVM_INIT_MODE in
  sourcing) zvm_init;;
  *) precmd_functions+=(zvm_init);;
esac

