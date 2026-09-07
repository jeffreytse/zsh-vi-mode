<div align="center">
  <a href="https://github.com/jeffreytse/zsh-vi-mode">
    <img alt="vi-mode →~ zsh" src="https://user-images.githubusercontent.com/9413601/103399068-46bfcb80-4b7a-11eb-8741-86cff3d85a69.png" width="600">
  </a>
  <p> 💻 A better and friendly vi(vim) mode plugin for ZSH.  </p>

  <br> <h1>⚒️  Zsh Vi Mode ⚒️</h1>

</div>



<h4 align="center">
  <a href="https://www.zsh.org/" target="_blank"><code>ZSH</code></a> plugin for Agnosticism.
</h4>

<p align="center">

  <a href="https://github.com/sponsors/jeffreytse">
    <img src="https://img.shields.io/static/v1?label=sponsor&message=%E2%9D%A4&logo=GitHub&link=&color=greygreen"
      alt="Donate (GitHub Sponsor)" />
  </a>

  <a href="https://github.com/jeffreytse/zsh-vi-mode/releases">
    <img src="https://img.shields.io/github/v/release/jeffreytse/zsh-vi-mode?color=brightgreen"
      alt="Release Version" />
  </a>

  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-brightgreen.svg"
      alt="License: MIT" />
  </a>

  <a href="https://liberapay.com/jeffreytse">
    <img src="http://img.shields.io/liberapay/goal/jeffreytse.svg?logo=liberapay"
      alt="Donate (Liberapay)" />
  </a>

  <a href="https://patreon.com/jeffreytse">
    <img src="https://img.shields.io/badge/support-patreon-F96854.svg?style=flat-square"
      alt="Donate (Patreon)" />
  </a>

  <a href="https://ko-fi.com/jeffreytse">
    <img height="20" src="https://ko-fi.com/img/githubbutton_sm.svg"
      alt="Donate (Ko-fi)" />
  </a>

</p>

<div align="center">
  <h4>
    <a href="#-features">Features</a> |
    <a href="#%EF%B8%8F-installation">Install</a> |
    <a href="#-usage">Usage</a> |
    <a href="#-credits">Credits</a> |
    <a href="#-license">License</a>
  </h4>
</div>

<div align="center">
  <sub>Built with ❤︎ by
  <a href="https://jeffreytse.net">jeffreytse</a> and
  <a href="https://github.com/jeffreytse/zsh-vi-mode/graphs/contributors">contributors </a>
</div>
<br>

> 🧙 **Check out my new project — [Grimoire](https://github.com/jeffreytse/grimoire)**:
> a free, open-source package manager for best practices — 1000+ skills across 26
> domains (engineering, law, finance, design, health, and more), each sourced from a
> real institution or study. Install once, and your AI routes to the right skill
> automatically. ⭐ Star it if you find it useful!

<img alt="Zsh Vi-mode Demo" src="https://user-images.githubusercontent.com/9413601/105746868-f3734a00-5f7a-11eb-8db5-22fcf50a171b.gif" />

## 🤔 Why ZVM?

Maybe you have experienced the default Vi mode in Zsh, after turning on
the default Vi mode, you gradually found that it had many problems, some
features were not perfect or non-existent, and some behaviors even were
different from the native Vi(Vim) mode.

Although the default Vi mode was a bit embarrassing and unpleasant, you
kept on using it and gradually lost your interest on it after using for
a period of time. Eventually, you disappointedly gave up.

You never think of the Vi mode for a long time, one day you accidentally
discovered this plugin, you read here and realize that this plugin is to
solve the above problems and make you fall in love to Vi mode again. A
smile suddenly appeared on your face like regaining a good life.

> If winter comes, can spring be far behind?


## ✨ Features

- 🌟 Pure Zsh's script without any third-party dependencies.
- 🎉 Better experience with the near-native vi(vim) mode.
- ⌛ Lower delay and better response (Mode switching speed, etc.).
- ✏️  Mode indication with different cursor styles.
- 🧮 Cursor movement (Navigation).
- 📝 Insert & Replace (Insert mode).
- 💡 Text Objects (A word, inner word, etc.).
- 🔎 Searching history.
- ❇️  Undo, Redo, Cut, Copy, Paste, and Delete.
- 🪐 Better surrounds functionality (Add, Replace, Delete, Move Around, and Highlight).
- 🧽 Switch keywords (Increase/Decrease Number, Boolean, Weekday, Month, etc.).
- ⚙️  Open under cursor URL or file path with charming `gx`.
- 🖋️ Edit current command line in an external editor with `vv`.
- 🪀 Repeating command such as `10p` and `4fa`.
- 📒 System clipboard integration (Copy/Paste).

## 💼 Requirements

ZSH: >= 5.1.0

## 🛠️ Installation

#### Using [Antigen](https://github.com/zsh-users/antigen)

Bundle `zsh-vi-mode` in your `.zshrc`

```shell
antigen bundle jeffreytse/zsh-vi-mode
```

#### Using [zplug](https://github.com/b4b4r07/zplug)
Load `zsh-vi-mode` as a plugin in your `.zshrc`

```shell
zplug "jeffreytse/zsh-vi-mode"
```

#### Using [zgen](https://github.com/tarjoilija/zgen)

Include the load command in your `.zshrc`

```shell
zgen load jeffreytse/zsh-vi-mode
```

#### Using [zinit](https://github.com/zdharma-continuum/zinit)

Include the load command in your `.zshrc`

```shell
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
```

Note: the use of `depth=1` ice is optional, other types of ice are neither
recommended nor officially supported by this plugin.

#### As an [Oh My Zsh!](https://github.com/robbyrussell/oh-my-zsh) custom plugin

Clone `zsh-vi-mode` into your custom plugins repo

```shell
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode
```
Then load as a plugin in your `.zshrc`

```shell
plugins+=(zsh-vi-mode)
```

Keep in mind that plugins need to be added before `oh-my-zsh.sh` is sourced.

#### Using [Antibody](https://getantibody.github.io/)

Add `zsh-vi-mode` to your plugins file (e.g. `~/.zsh_plugins.txt`)

```shell
jeffreytse/zsh-vi-mode
```

#### Using [Zap](https://github.com/zap-zsh/zap)

Load `zsh-vi-mode` as a plugin in your `.zshrc`

```shell
plug "jeffreytse/zsh-vi-mode"
```

#### Using [Zim](https://github.com/zimfw/zimfw)

Load `zsh-vi-mode` as a plugin in your `.zimrc`

```shell
zmodule jeffreytse/zsh-vi-mode
```
  
#### Using [Homebrew](https://brew.sh/)

For Homebrew users, you can install it through the following command

```shell
brew install zsh-vi-mode
```

Then source it in your `.zshrc` (or `.bashrc`)

```shell
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
```

#### Arch Linux (AUR)

For Arch Linux users, you can install it through the following command

```shell
yay -S zsh-vi-mode
```

or the latest update (unstable)

```shell
yay -S zsh-vi-mode-git
```

Then source it in your `.zshrc` (or `.bashrc`)

```shell
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
```

#### Nix

For users of Nix, as of [e7e3480530b34a9fe8cb52963ec2cf66e6707e15](https://github.com/NixOS/nixpkgs/commit/e7e3480530b34a9fe8cb52963ec2cf66e6707e15) you can source the plugin through the following configuration

```nix
programs = {
  zsh = {
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };
};
```
  
Or if you prefer `home-manager`:

```nix
home-manager.users.[your username] = { pkgs, ... }: {
  programs = {
    zsh = {
      initExtra = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';
    };
  };
};
```

You can also use `home-manager`'s built-in "plugin" feature:

```nix
home-manager.users.[your username] = { pkgs, ... }: {
  programs = {
    zsh = {
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
    };
  };
};
```

#### Gentoo Linux

Available in [dm9pZCAq overlay](https://github.com/gentoo-mirror/dm9pZCAq)

```shell
eselect repository enable dm9pZCAq
emerge --sync dm9pZCAq
emerge app-shells/zsh-vi-mode
```

Then source it in your `.zshrc` (or `.bashrc`)

```shell
source /usr/share/zsh/site-contrib/zsh-vi-mode/zsh-vi-mode.plugin.zsh
```

#### Manually

Clone this repository somewhere (`$HOME/.zsh-vi-mode` for example)

```shell
git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zsh-vi-mode
```
Then source it in your `.zshrc` (or `.bashrc`)

```shell
source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
```

## Packaging Status

[![Packaging status](https://repology.org/badge/vertical-allrepos/zsh-vi-mode.svg)](https://repology.org/project/zsh-vi-mode/versions)

## 📚 Usage

Use `ESC` or `CTRL-[` to enter `Normal mode`.

But some people may like the custom escape key such as `jj`, `jk` and so on,
if you want to custom the escape key, you can learn more from [here](#custom-escape-key).

History
-------

- `ctrl-p` : Previous command in history
- `ctrl-n` : Next command in history
- `/`      : Search backward in history
- `n`      : Repeat the last `/`


Mode indicators
---------------

`Normal mode` is indicated with block style cursor, and `Insert mode` with
beam style cursor by default.

Vim edition
-----------

In `Normal mode` you can use `vv` to edit current command line in an editor
(e.g. `vi`/`vim`/`nvim`...), because it is bound to the `Visual mode`.

You can change the editor by `ZVM_VI_EDITOR` option, by default it is
`$EDITOR`.

Movement
--------

- `$`   : To the end of the line
- `^`   : To the first non-blank character of the line
- `0`   : To the first character of the line
- `w`   : [count] words forward
- `W`   : [count] WORDS forward
- `e`   : Forward to the end of word [count] inclusive
- `E`   : Forward to the end of WORD [count] inclusive
- `b`   : [count] words backward
- `B`   : [count] WORDS backward
- `t{char}`   : Till before [count]'th occurrence of {char} to the right
- `T{char}`   : Till before [count]'th occurrence of {char} to the left
- `f{char}`   : To [count]'th occurrence of {char} to the right
- `F{char}`   : To [count]'th occurrence of {char} to the left
- `;`   : Repeat latest f, t, F or T [count] times
- `,`   : Repeat latest f, t, F or T in opposite direction


Insertion
---------

- `i`   : Insert text before the cursor
- `I`   : Insert text before the first character in the line
- `a`   : Append text after the cursor
- `A`   : Append text at the end of the line
- `o`   : Insert new command line below the current one
- `O`   : Insert new command line above the current one

Surround
--------

There are 2 kinds of keybinding mode for surround operating, default is
`classic` mode, you can choose the mode by setting `ZVM_VI_SURROUND_BINDKEY`
option.

1. `classic` mode (verb->s->surround)

- `S"`    : Add `"` for visual selection
- `ys"`   : Add `"` for visual selection
- `cs"'`  : Change `"` to `'`
- `ds"`   : Delete `"`

 2. `s-prefix` mode (s->verb->surround)
- `sa"`   : Add `"` for visual selection
- `sd"`   : Delete `"`
- `sr"'`  : Change `"` to `'`

Note that key sequences must be pressed in fairly quick succession to avoid a timeout. You may extend this timeout with the [`ZVM_KEYTIMEOUT` option](#readkey-engine).
  
#### How to select surround text object?

- `vi"`   : Select the text object inside the quotes
- `va(`   : Select the text object including the brackets

Then you can do any operation for the selection:

1. Add surrounds for text object

- `vi"` -> `S[` or `sa[` => `"object"` -> `"[object]"`
- `va"` -> `S[` or `sa[` => `"object"` -> `["object"]`

2. Delete/Yank/Change text object

- `di(` or `vi(` -> `d`
- `ca(` or `va(` -> `c`
- `yi(` or `vi(` -> `y`

Increment and Decrement
--------

In normal mode, typing `ctrl-a` will increase to the next keyword, and typing
`ctrl-x` will decrease to the next keyword. The keyword can be at the cursor,
or to the right of the cursor (on the same line). The keyword could be as
below:

- Number (Decimal, Hexadecimal, Binary...)
- Boolean (True or False, Yes or No, On or Off...)
- Weekday (Sunday, Monday, Tuesday, Wednesday...)
- Month (January, February, March, April, May...)
- Operator (&&, ||, ++, --, ==, !==, and, or...)
- ...

For example:

1. Increment

- `9` => `10`
- `aa99bb` => `aa100bb`
- `aa100bc` => `aa101bc`
- `0xDe` => `0xdf`
- `0Xdf` => `0Xe0`
- `0b101` => `0b110`
- `0B11` => `0B101`
- `true` => `false`
- `yes` => `no`
- `on` => `off`
- `T` => `F`
- `Fri` => `Sat`
- `Oct` => `Nov`
- `Monday` => `Tuesday`
- `January` => `February`
- `+` => `-`
- `++` => `--`
- `==` => `!=`
- `!==` => `===`
- `&&` => `||`
- `and` => `or`
- ...

2. Decrement:

- `100` => `99`
- `aa100bb` => `aa99bb`
- `0` => `-1`
- `0xdE0` => `0xDDF`
- `0xffFf0` => `0xfffef`
- `0xfffF0` => `0xFFFEF`
- `0x0` => `0xffffffffffffffff`
- `0Xf` => `0Xe`
- `0b100` => `0b010`
- `0B100` => `0B011`
- `True` => `False`
- `On` => `Off`
- `Sun` => `Sat`
- `Jan` => `Dec`
- `Monday` => `Sunday`
- `August` => `July`
- `/` => `*`
- `++` => `--`
- `==` => `!=`
- `!==` => `===`
- `||` => `&&`
- `or` => `and`
- ...

System Clipboard
--------

zsh-vi-mode can integrate with your system clipboard. This feature is disabled
by default. Therefore, you can't automatically copy to the system clipboard when
you stroke `yy`, `yw` and so on, but only allowed to paste from it. If you want
to enable this feature, you can set the option:

Enable:

```zsh
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
```

Auto-detection:

- macOS: `pbcopy` and `pbpaste`
- Wayland: `wl-copy` and `wl-paste -n`
- X11: `xclip` or `xsel`

Override commands:

```zsh
ZVM_CLIPBOARD_COPY_CMD='xclip -selection clipboard'
ZVM_CLIPBOARD_PASTE_CMD='xclip -selection clipboard -o'
```

Keybindings:

- Normal: `gp` paste clipboard after cursor, `gP` before cursor
- Visual: `gp`/`gP` replace selection with clipboard

Note: `p`/`P` keep using ZLE's CUTBUFFER; `gp`/`gP` use the system clipboard.

Behavior:

- When enabled, yanks/deletes/changes that set CUTBUFFER also copy to the system clipboard.

WSL (Windows Subsystem for Linux):

```zsh
# Using Windows clipboard
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_CLIPBOARD_COPY_CMD='clip.exe'
ZVM_CLIPBOARD_PASTE_CMD='powershell.exe -NoProfile -Command Get-Clipboard'
```

or using win32yank:

```zsh
ZVM_CLIPBOARD_COPY_CMD='win32yank.exe -i --crlf'
ZVM_CLIPBOARD_PASTE_CMD='win32yank.exe -o --lf'
```

### OSC 52 (Remote Clipboard)

OSC 52 is an escape sequence that allows copying text to the clipboard over SSH or in tmux sessions without requiring X11 forwarding or other clipboard tools.

Enable OSC 52:

```zsh
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_CLIPBOARD_USE_OSC52=true
```

By default, the plugin automatically detects if you're in a tmux session (via the `$TMUX` variable) and wraps the escape sequence accordingly. You can control this behavior:

```zsh
# Always use tmux wrapping (even if not in tmux)
ZVM_CLIPBOARD_OSC52_TMUX=true

# Never use tmux wrapping (even if in tmux)
ZVM_CLIPBOARD_OSC52_TMUX=false

# Auto-detect (default behavior, check $TMUX variable)
ZVM_CLIPBOARD_OSC52_TMUX=
```

Note: OSC 52 requires your terminal emulator and tmux (if used) to support clipboard integration. Most modern terminals support this feature.

Open Under Cursor
----------------

In `Normal mode`, you can use `gx` to open the URL or file path under the cursor.

- If the word under the cursor is a URL (starting with `http://`, `https://`, `ftp://`, `file://`), it will open in your default web browser.
- If the word under the cursor is a valid file or directory path, it will open with your system's default application for that file type.

The plugin automatically detects whether the text under the cursor is a URL or a file path and opens it accordingly using your system's default opener:

- **macOS**: `open`
- **Linux**: `xdg-open`
- **Windows**: You need to manually config, see below.

You can override the default open command by setting the `ZVM_OPEN_CMD` option.
Also, you can set the `ZVM_OPEN_URL_CMD` and `ZVM_OPEN_FILE_CMD` options to
specify different commands for opening URLs and files respectively.

Overriding commands example:

```zsh
# Override the default open command
ZVM_OPEN_CMD='xdg-open'

# Override the open command for URLs
ZVM_OPEN_URL_CMD='firefox'

# Override the open command for URLs on macOS
ZVM_OPEN_URL_CMD='open -a "Safari"'

# Override the open command for files
ZVM_OPEN_FILE_CMD='code'  # Open files with Visual Studio Code

# Override the open command for files on macOS
ZVM_OPEN_FILE_CMD='open -a "Visual Studio Code"'

# Override the open command for files on Windows
ZVM_OPEN_FILE_CMD='powershell.exe -Command "Start-Process code"'

# Override the open command for files on Windows using cmd
ZVM_OPEN_FILE_CMD='start code'
```

For Windows users, you can create a script for opening on Windows, for example,
a script `/usr/local/bin/xdg-open` with content:

```sh
#!/usr/bin/env bash

# A Linux-like "xdg-open" command for WSL
# Supports: http, https, ftp, ftps, file URLs, local files and directories

if [ $# -eq 0 ]; then
  echo "Usage: open <file|dir|url>"
  exit 1
fi

for target in "$@"; do
  # If it is a URL (http, https, ftp, ftps, file)
  if [[ "$target" =~ ^(https?|ftps?|file):// ]]; then
    explorer.exe "$target"
    continue
  fi

  # Otherwise, treat as regular file or directory paths
  if [ -e "$target" ]; then
    win_path=$(wslpath -w "$target")
    explorer.exe "$win_path"
  else
    echo "open: $target not found"
  fi
done
```

And add executive permission:

```sh
sudo chmod +x /usr/local/bin/xdg-open
```

Then set the `ZVM_OPEN_CMD` option:

```zsh
ZVM_OPEN_CMD='/usr/local/bin/xdg-open'
```

Or you can use `cygstart` if you are using Cygwin:

```zsh
ZVM_OPEN_CMD='cygstart'
```

Or set the `cygstart` command as a alias as below:

```zsh
# Add a open alias to your .zshrc for Windows users
open='cygstart'
```

Custom Escape Key
--------

You can use below options to custom the escape key which could better match
your flavor, such as `jj` or `jk` and so on.

- `ZVM_VI_ESCAPE_BINDKEY`: The vi escape key in all modes (default is `^[`
  => `ESC`)
- `ZVM_VI_INSERT_ESCAPE_BINDKEY`: The vi escape key in insert mode (default
  is `$ZVM_VI_ESCAPE_BINDKEY`)
- `ZVM_VI_VISUAL_ESCAPE_BINDKEY`: The vi escape key in visual mode (default
  is `$ZVM_VI_ESCAPE_BINDKEY`)
- `ZVM_VI_OPPEND_ESCAPE_BINDKEY`: The vi escape key in operator pending mode
  (default is `$ZVM_VI_ESCAPE_BINDKEY`)

For example:

```zsh
# Only changing the escape key to `jk` in insert mode, we still
# keep using the default keybindings `^[` in other modes
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
```

Readkey Engine
--------

This plugin has supported to choose the readkey engine for reading and
processing the key events. It easy to do by the `ZVM_READKEY_ENGINE`option,
currently the below engines are supported:

- `ZVM_READKEY_ENGINE_NEX`: It is a better readkey engine to replace ZLE (Beta).
- `ZVM_READKEY_ENGINE_ZLE`: It is Zsh's default readkey engine (ZLE).
- `ZVM_READKEY_ENGINE_DEFAULT`: It is the default engine of this plugin
  (It's the NEX engine now).

The NEX is a better engine for reading and handling the key events than the
Zsh's ZLE engine, currently the NEX engine is still at beta stage, you can
change back to Zsh's ZLE engine if you want.

For example:

```zsh
# Change to Zsh's default readkey engine
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
```

You can use `ZVM_KEYTIMEOUT` option to adjust the key input timeout for
waiting for next key, default is `0.4` seconds.

The escape key is a special case, it can be used standalone. NEX engine
waits for a period after receiving the escape character, to determine
whether it is standalone or part of an escape sequence. While waiting,
additional key presses make the escape key behave as a meta key. If no
other key presses come in, it is handled as a standalone escape.

For the NEX engine, we can use `ZVM_ESCAPE_KEYTIMEOUT` option to adjust
the waiting timeout for the escape key, default is `0.03` seconds.

Configuration Function
--------

Since there are some config options relied to some variables defined in
the plugin, however, some not. We need to provide an unified config entry
function. The name of entry function is stored in an option called
`ZVM_CONFIG_FUNC` and default value is `zvm_config`, you can change to
others for fitting your flavor.

If this config function exists, it will be called automatically, you can
do some configurations in this aspect before you source this plugin. For
example:

```zsh
function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
}

source ~/zsh-vi-mode.zsh
```

Execute Extra Commands
--------

This plugin has provided a mechanism to execute extra commands, and now
you have the below aspects for executing something:

```zsh
zvm_before_init_commands=()
zvm_after_init_commands=()
zvm_before_select_vi_mode_commands=()
zvm_after_select_vi_mode_commands=()
zvm_before_lazy_keybindings_commands=()
zvm_after_lazy_keybindings_commands=()
```

Since the default [initialization mode](#initialization-mode), this plugin
will overwrite the previous key bindings, this causes the key bindings of
other plugins (i.e. `fzf`, `zsh-autocomplete`, etc.) to fail.

You can solve the compatibility issue as below:

```zsh
# Append a command directly
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
```

or

```zsh
# Define an init function and append to zvm_after_init_commands
function my_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
zvm_after_init_commands+=(my_init)
```

or

```zsh
# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
```

or if you are using the `zinit`:

```zsh
# For postponing loading `fzf`
zinit ice lucid wait
zinit snippet OMZP::fzf
```

By default, [the lazy keybindings feature](#lazy-keybindings) is enabled, all
the keybindings of `normal` and `visual` mode should be executed by the
`zvm_after_lazy_keybindings_commands`. For example:

```zsh
# The plugin will auto execute this zvm_after_lazy_keybindings function
function zvm_after_lazy_keybindings() {
  bindkey -M vicmd 's' your_normal_widget
  bindkey -M visual 'n' your_visual_widget
}
```

Custom widgets and keybindings
--------

This plugin has two functions for you to define custom widgets and keybindings.
In case of unnecessary problems, it is better to use them, especially when you
meet the key conflicts.

To define a custom widget, you should:

```zsh
# If [your_custom_widget] were ignored, it will be the same with <your_custom_widget>
zvm_define_widget <your_custom_widget> [your_custom_function]
```

To define a keybinding, you should:

```zsh
zvm_bindkey <keymap> <keys> <widget>
```

For example:

```zsh
# Your custom widget
function my_custom_widget() {
  echo 'Hello, ZSH!'
}

# The plugin will auto execute this zvm_after_lazy_keybindings function
function zvm_after_lazy_keybindings() {
  # Here we define the custom widget
  zvm_define_widget my_custom_widget

  # In normal mode, press Ctrl-E to invoke this widget
  zvm_bindkey vicmd '^E' my_custom_widget
}
```

Vi Mode Indicator
--------

This plugin has provided a `ZVM_MODE` variable for you to retrieve
current vi mode and better show the indicator.

And currently the below modes are supported:

```zsh
ZVM_MODE_NORMAL
ZVM_MODE_INSERT
ZVM_MODE_VISUAL
ZVM_MODE_VISUAL_LINE
ZVM_MODE_REPLACE
```

For updating the vi mode indicator, we should add our commands to 
`zvm_after_select_vi_mode_commands`. For example:

```zsh
# The plugin will auto execute this zvm_after_select_vi_mode function
function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      # Something you want to do...
    ;;
    $ZVM_MODE_INSERT)
      # Something you want to do...
    ;;
    $ZVM_MODE_VISUAL)
      # Something you want to do...
    ;;
    $ZVM_MODE_VISUAL_LINE)
      # Something you want to do...
    ;;
    $ZVM_MODE_REPLACE)
      # Something you want to do...
    ;;
  esac
}
```

Custom Cursor Style
--------

This plugin has provided some options for users to custom the cursor
style for better terminal compatibility.

- You can disable this feature by the `ZVM_CURSOR_STYLE_ENABLED`
  option (Default is `true`)

```zsh
# Disable the cursor style feature
ZVM_CURSOR_STYLE_ENABLED=false
```

- You can set your cursor style for different vi mode:

```zsh
# The prompt cursor in normal mode
ZVM_NORMAL_MODE_CURSOR

# The prompt cursor in insert mode
ZVM_INSERT_MODE_CURSOR

# The prompt cursor in visual mode
ZVM_VISUAL_MODE_CURSOR

# The prompt cursor in visual line mode
ZVM_VISUAL_LINE_MODE_CURSOR

# The prompt cursor in operator pending mode
ZVM_OPPEND_MODE_CURSOR
```

- And the below cursor styles are supported:

```zsh
ZVM_CURSOR_USER_DEFAULT
ZVM_CURSOR_BLOCK
ZVM_CURSOR_UNDERLINE
ZVM_CURSOR_BEAM
ZVM_CURSOR_BLINKING_BLOCK
ZVM_CURSOR_BLINKING_UNDERLINE
ZVM_CURSOR_BLINKING_BEAM
```

- Custom your cursor style is easy as below:

```zsh
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
```

- Also, custom your colorful cursor style as below:

```zsh
# The plugin will auto execute this zvm_config function
zvm_config() {
  # Retrieve default cursor styles
  local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
  local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)

  # Append your custom color for your cursor
  ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;red\a'
  ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#008800\a'
}
```

We can use `ZVM_TERM` option to set the term type for plugin to handle
terminal escape sequences, default is `$TERM`. It could be `xterm-256color`,
`alacritty-256color`, `st-256color`, etc. It's important for some
terminal emulators to show cursor properly.

Highlight Behavior
--------

You can use `ZVM_VI_HIGHLIGHT_BACKGROUND`, `ZVM_VI_HIGHLIGHT_FOREGROUND`
and `ZVM_VI_HIGHLIGHT_EXTRASTYLE` to change the highlight behaviors (
surrounds, visual-line, etc.), the color value could be _a color name_ or
_a hex color value_.

For example:

```zsh
ZVM_VI_HIGHLIGHT_FOREGROUND=green             # Color name
ZVM_VI_HIGHLIGHT_FOREGROUND=#008800           # Hex value
ZVM_VI_HIGHLIGHT_BACKGROUND=red               # Color name
ZVM_VI_HIGHLIGHT_BACKGROUND=#ff0000           # Hex value
ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline    # bold and underline
```

Command Line Initial Mode
--------

You can set the command line initial mode by the `ZVM_LINE_INIT_MODE`
option.

Currently the below modes are supported:

- `ZVM_MODE_LAST`   : Starting with last mode (Default).
- `ZVM_MODE_INSERT` : Starting with insert mode.
- `ZVM_MODE_NORMAL` : Starting with normal mode.

For example:

```zsh
# Always starting with insert mode for each command line
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
```

Lazy Keybindings
--------

This plugin has supported the lazy keybindings feature, and it is enabled
by default. To disable it, you can set the option `ZVM_LAZY_KEYBINDINGS`
to `false` before this plugin is loaded. This feature will postpone all
the keybindings of `normal` and `visual` mode to the first time you enter
the normal mode.

It can greatly improve the startup speed, especially you open the terminal
and just want to execute a simple command.

Initialization Mode
--------

In order to prevent various problems related to keybindings caused by the
plugin sourcing sequence, and also keep the same functionality for this
plugin, the initialization of this plugin was postponed to the first
command line starting.

However, almost all plugins are initialized when the script is sourced.
Therefore, this plugin provides an option `ZVM_INIT_MODE` to change the
initialization mode.

For example:

```zsh
# Do the initialization when the script is sourced (i.e. Initialize instantly)
ZVM_INIT_MODE=sourcing
```

## 💎 Credits

- [Zsh](https://www.zsh.org/) - A powerful shell that operates as both an interactive shell and as a scripting language interpreter.
- [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh) - A delightful, open source, community-driven framework for managing your ZSH configuration.
- [vim-surround](https://github.com/tpope/vim-surround) - A vim plugin all about "surroundings": parentheses, brackets, quotes, XML tags, and more.
- [vim-sandwich](https://github.com/machakann/vim-sandwich) - A set of operator and textobject plugins to add/delete/replace surroundings of a sandwiched textobject.

## 🔫 Contributing

Issues and Pull Requests are greatly appreciated. If you've never contributed to an open source project before I'm more than happy to walk you through how to create a pull request.

You can start by [opening an issue](https://github.com/jeffreytse/zsh-vi-mode/issues/new) describing the problem that you're looking to resolve and we'll go from there.

## 🌈 License

This theme is licensed under the [MIT license](https://opensource.org/licenses/mit-license.php) © Jeffrey Tse.


## 🌐 Web Resources & Verified Articles Directory
- [FLAG PUZZLE JAM COLLECT FLAGS](https://youxi-china24.netlify.app/flag-puzzle-jam-collect-flags.html)
- [TREASURE SEEKER](https://muryo-gemu-tengoku.pages.dev/treasure-seeker.html)
- [ARTILLERY VS TANKS](https://trochoimienphi24h.github.io/artillery-vs-tanks.html)
- [BOX MONSTER UNBOX DRESS UP](https://dautruong-game24h.web.app/box-monster-unbox-dress-up.html)
- [PUZZLE BLOCKS CLASSIC](https://trochoimienphi24h.github.io/puzzle-blocks-classic.html)
- [WALL HOP](https://koreagame-hub24.netlify.app/wall-hop.html)
- [TAXI DRIVER SIMULATOR](https://action-strike-zone.pages.dev/taxi-driver-simulator.html)
- [KITTY COUPLE LOVELY VALENTINE](https://juegosmundial-hoy.pages.dev/kitty-couple-lovely-valentine.html)
- [COLOR NONOGRAM PUZZLE 2](https://choigamehay24h.github.io/color-nonogram-puzzle-2.html)
- [INTERSTELLAR](https://unblocked-galaxy.github.io/interstellar.html)
- [FRUITSLAND ESCAPE FROM THE AMUSEMENT PARK](https://dautruong-game24h.web.app/fruitsland-escape-from-the-amusement-park.html)
- [ROPE STITCH PUZZLE](https://luchshie-igry-rus.pages.dev/rope-stitch-puzzle.html)
- [CANDY RAIN 5](https://unblocked-galaxy.web.app/candy-rain-5.html)
- [RED LIGHT GREEN LIGHT](https://zona-juegos-flash.web.app/red-light-green-light.html)
- [CELEBRITY E GIRL VIBES](https://kuaile-youxi-hub.web.app/celebrity-e-girl-vibes.html)
- [MERGE HOME MANIA](https://planetejeux-france.pages.dev/merge-home-mania.html)
- [GETTING OVER IT](https://action-battle-hub.pages.dev/getting-over-it.html)
- [DICE FUSION](https://webarcade-hub.github.io/dice-fusion.html)
- [SAUSAGE MAN SHOOTING ADVENTURE](https://mundodosjogos-br.web.app/sausage-man-shooting-adventure.html)
- [GOLD MINER CLASSIC](https://juegosweb-gratis.github.io/gold-miner-classic.html)
- [BRAINSTORMING 2D](https://koreagame-hub24.netlify.app/brainstorming-2d.html)
- [ARROW COUNT MASTER](https://speed-racing-arcade.pages.dev/arrow-count-master.html)
- [BACKWOODS](https://logic-puzzle-world.pages.dev/backwoods.html)
- [TOILET TIME](https://brainiac-puzzles.web.app/toilet-time.html)
- [LORENZO THE RUNNER](https://juegosgratis-es.netlify.app/lorenzo-the-runner.html)
- [BLOCK PUZZLE KING](https://juegosmundial-hoy.pages.dev/block-puzzle-king.html)
- [SHIP FISH](https://bharat-game-zone.web.app/ship-fish.html)
- [TAPKO](https://geim-cheon-guk24.pages.dev/tapko.html)
- [ROLLANCE GOING BALLS](https://pixelarcade-speed.web.app/rollance-going-balls.html)
- [HEXA SORT 3D](https://congdonggame-vietnam.web.app/hexa-sort-3d.html)
- [KAWAII REALM ADVENTURE](https://speed-racing-arcade.pages.dev/kawaii-realm-adventure.html)
- [ROBOT BAND FIND THE DIFFERENCES](https://tokyo-arcade-web.pages.dev/robot-band-find-the-differences.html)
- [DUCK HUNTING OPEN SEASON](https://maniadejogos-brasil.pages.dev/duck-hunting-open-season.html)
- [DADDY RABBIT](https://espacejeux-paris.pages.dev/daddy-rabbit.html)
- [CUBE IN CUBE](https://onlinerus-games.netlify.app/cube-in-cube.html)
- [CAR PAINT](https://vuagamemienphi24h.pages.dev/car-paint.html)
- [BELL MADNESS](https://PixelArcadezGame.github.io/bell-madness.html)
- [PUSH THE COLORS](https://quantum-puzzle-hub.pages.dev/push-the-colors.html)
- [ITALIAN BRAINROT FIND THE DIFFERENCES](https://shadow-ninja-arena.web.app/italian-brainrot-find-the-differences.html)
- [MANSION STORY MATCH](https://desi-gaming-arena.pages.dev/mansion-story-match.html)
- [SUPERMARKET MANAGER SIMULATOR](https://action-battle-hub.pages.dev/supermarket-manager-simulator.html)
- [SPRUNKI MONSTER MUSIC BEATS](https://tokyo-arcade-web.pages.dev/sprunki-monster-music-beats.html)
- [BATTLETABS](https://choigame24h-vietnam.netlify.app/battletabs.html)
- [HILL CLIMBING MANIA](https://shanghai-youxi-web.web.app/hill-climbing-mania.html)
- [MR LONG HAND](https://shanghai-youxi-web.web.app/mr-long-hand.html)
- [HERO MERGE](https://onlinerus-games.netlify.app/hero-merge.html)
- [MAHJONG BUILD FARM](https://kuaile-youxi-hub.web.app/mahjong-build-farm.html)
- [JELLO BUBBLES](https://unblocked-galaxy.github.io/jello-bubbles.html)
- [BLOCK BLAST BLOCK PUZZLE MASTER](https://action-strike-zone.pages.dev/block-blast-block-puzzle-master.html)
- [HALLOWEEN CHALLENGE](https://brain-puzzle-galaxy.netlify.app/halloween-challenge.html)
- [TRAVEL WITH ME ASMR EDITION](https://neon-cyber-arcade.pages.dev/travel-with-me-asmr-edition.html)
- [TILE HEXA SORT](https://vuagamemienphi24h.pages.dev/tile-hexa-sort.html)
- [HUMAN EVOLUTION RUN](https://onlinerus-portal.netlify.app/human-evolution-run.html)
- [THRONE VS BALLOONS](https://unblocked-action-arena.netlify.app/throne-vs-balloons.html)
- [RUMBLE](https://bfvalues-central.pages.dev/values/rumble)
- [SUPERHERO PHONE SIMULATOR](https://jeuxweb-france.netlify.app/superhero-phone-simulator.html)
- [TAXI DRIVER SIMULATOR](https://jogosonline-brasil.vercel.app/taxi-driver-simulator.html)
- [FASHION DYE PRO](https://congdonggame-vietnam.web.app/fashion-dye-pro.html)
- [PRINCESS VALENTINES CRUSH](https://juegosweb-desbloqueados.vercel.app/princess-valentines-crush.html)
- [SPRUNKI GARDEN](https://shanghai-youxi-web.web.app/sprunki-garden.html)
- [DUNK CHALLENGE](https://gamehay-online.netlify.app/dunk-challenge.html)
- [HORROR MINECRAFT PARTYTIME](https://pixelarcade-speed.web.app/horror-minecraft-partytime.html)
- [BOUNCE DUNK BASKETBALL](https://dautruong-game24h.web.app/bounce-dunk-basketball.html)
- [QUIZ 10 SECONDS MATH](https://koreagame-arcade.netlify.app/quiz-10-seconds-math.html)
- [KNIT BEARS](https://juegosgratis-es.netlify.app/knit-bears.html)
- [K POP HUNTERS VALENTINE STYLE](https://desi-gaming-arena.pages.dev/k-pop-hunters-valentine-style.html)
- [STICK COLOR WAR](https://youxi-h5-tiandi.pages.dev/stick-color-war.html)
- [TURBO RACE](https://koreagame-zone.vercel.app/turbo-race.html)
- [HOTEL FEVER TYCOON](https://nihon-webgames.netlify.app/hotel-fever-tycoon.html)
- [THE WALL](https://choigamehay24h.github.io/the-wall.html)
- [BRAINROT ICE TRUCK](https://geim-cheon-guk24.pages.dev/brainrot-ice-truck.html)
- [CAR JAM TRAFFIC PUZZLE](https://jogosweb-brasil24.netlify.app/car-jam-traffic-puzzle.html)
- [2 PLAYER BATTLE](https://arcadevault-games.github.io/2-player-battle.html)
- [100 ROOMS ESCAPE](https://unblocked-galaxy-hub.pages.dev/100-rooms-escape.html)
- [BARBEE SUMMER VACATION](https://sieuthigame-viet.pages.dev/barbee-summer-vacation.html)
- [BRAINROT HOLE](https://juegosgratis-es.netlify.app/brainrot-hole.html)
- [BALL DUNK FALL](https://vuagamemienphi24h.pages.dev/ball-dunk-fall.html)
- [COSMO PET STARRY CARE](https://jeuxflash-france.netlify.app/cosmo-pet-starry-care.html)
- [CHEERFUL PLUMBER](https://speed-racing-hub.netlify.app/cheerful-plumber.html)
- [BREAK THE BLOCK THERE BRAINROT](https://muryo-gemu-tengoku.pages.dev/break-the-block-there-brainrot.html)
- [4 COLORS CARD MANIA](https://geim-cheon-guk24.pages.dev/4-colors-card-mania.html)
- [BLOCK CRAFT 3D](https://jingpin-youxiwang.pages.dev/block-craft-3d.html)
- [MEGA RAMP CAR STUNTS](https://muryo-geim-nara.web.app/mega-ramp-car-stunts.html)
- [PIN BOARD PUZZLE](https://koreagame-arcade.netlify.app/pin-board-puzzle.html)
- [NOOB PARKOUR TRICKS](https://gamehay-online.netlify.app/noob-parkour-tricks.html)
- [FIND THE FROG HIDDEN OBJECTS](https://koreagame-zone.vercel.app/find-the-frog-hidden-objects.html)
- [SORTSTORE](https://jeuxweb-france.netlify.app/sortstore.html)
- [WILD WEST MATCH 2 THE GOLD RUSH](https://tokyo-arcade-web.pages.dev/wild-west-match-2-the-gold-rush.html)
- [NESTING DOLLS](https://arcadevault-gamehub.github.io/nesting-dolls.html)
- [SUMMER MAZE](https://hindigames-hub.netlify.app/summer-maze.html)
- [MERMAID PRINCESS AVATER CASTLE](https://jeuxweb-france.netlify.app/mermaid-princess-avater-castle.html)
- [WOODEN BOLTS AND NUTS](https://nihon-webgames.netlify.app/wooden-bolts-and-nuts.html)
- [BRAWL STARS BRAVE ADVENTURE](https://juegosgratis-es.netlify.app/brawl-stars-brave-adventure.html)
- [SPACE BLAST](https://hyper-gamers-den.web.app/space-blast.html)
- [WEAPONS AND RAGDOLLS](https://arcadevault-games.github.io/weapons-and-ragdolls.html)
- [HUNGRY SNAKE IO](https://jingpin-youxiwang.pages.dev/hungry-snake-io.html)
- [CHRISTMAS BLOCKS SORT](https://gameflash-viet.github.io/christmas-blocks-sort.html)
- [JIGSAW FANTASY](https://action-strike-zone.pages.dev/jigsaw-fantasy.html)
- [THE SURVEY](https://youxiweb-hub.netlify.app/the-survey.html)
- [BUBBLE MANIA SHOOTER](https://webarcade-gamehub.github.io/bubble-mania-shooter.html)
- [MECH MONSTER ARENA](https://mundodosjogos-br.web.app/mech-monster-arena.html)
- [HIDDEN OBJECT GREAT JOURNEY](https://nihongames-web.github.io/hidden-object-great-journey.html)
- [CAT CHAOS SIMULATOR](https://choigame24h-vietnam.netlify.app/cat-chaos-simulator.html)
- [IDLE POP MERGE](https://koreagame-arcade.netlify.app/idle-pop-merge.html)
- [LABUBU COLORING ADVENTURE](https://unblocked-galaxy-hub.pages.dev/labubu-coloring-adventure.html)
- [4 COLORS CARD MANIA](https://koreagame-zone.vercel.app/4-colors-card-mania.html)
- [THE FINAL RIDDLE](https://onlinerus-games.netlify.app/the-final-riddle.html)
- [BRAINROT A DIFFERENCE CHALLENGE](https://unblocked-galaxy.github.io/brainrot-a-difference-challenge.html)
- [BLOCKBUSTER PUZZLE](https://bharat-game-zone.web.app/blockbuster-puzzle.html)
- [HIDDEN OBJECTS LOST ISLAND 2](https://trochoimienphi24h.github.io/hidden-objects-lost-island-2.html)
- [CLOSED CITY](https://youxi-h5-tiandi.pages.dev/closed-city.html)
- [TURBO STUNT RACING](https://tokyo-arcade-web.pages.dev/turbo-stunt-racing.html)
- [SKATING PARK](https://logic-puzzle-world.pages.dev/skating-park.html)
- [LEGEND OF FIREBALL](https://bharat-game-zone.web.app/legend-of-fireball.html)
- [RACE IT CAR RACING](https://muryo-geim-nara.web.app/race-it-car-racing.html)
- [DUNGEONS N DUCKS](https://youxiweb-hub.netlify.app/dungeons-n-ducks.html)
- [LEGEND OF FIREBALL](https://espacejeux-paris.pages.dev/legend-of-fireball.html)
- [DIAMOND SOLITAIRE MAHJONG](https://unblocked-action-arena.netlify.app/diamond-solitaire-mahjong.html)
- [SORT BALLS CONES](https://congdonggame-vietnam.web.app/sort-balls-cones.html)
- [CAT CUT](https://vuagamemienphi24h.pages.dev/cat-cut.html)
- [T REX](https://bloxfruit-values-gg.pages.dev/calculator/t-rex)
- [GRANNY 2 ASYLUM HORROR HOUSE](https://jingpin-youxiwang.pages.dev/granny-2-asylum-horror-house.html)
- [BLOCK COLOR PUZZLE BLAST](https://sieuthigame-viet.pages.dev/block-color-puzzle-blast.html)
- [HIDDEN OBJECT ADVENTURE](https://retro-arcade-zone.netlify.app/hidden-object-adventure.html)
- [BOBBLEHEAD BALL](https://kuaile-youxi-hub.web.app/bobblehead-ball.html)
- [JELLY TOWER CRUSH](https://koreagame-zone.vercel.app/jelly-tower-crush.html)
- [GEM DEEP DIGGER](https://dautruong-game24h.web.app/gem-deep-digger.html)
- [FALLING BLOCKS PUZZLE](https://bharat-game-zone.web.app/falling-blocks-puzzle.html)
- [FASHION CHALLENGE CATWALK RUN](https://juegosmundial-hoy.pages.dev/fashion-challenge-catwalk-run.html)
- [CHINESE FOOD CHEF DUDU](https://logic-puzzle-world.pages.dev/chinese-food-chef-dudu.html)
- [WOOD HEXA FACTORY](https://unblocked-action-arena.netlify.app/wood-hexa-factory.html)
- [MAX CRUSHER CRAZY DESTRUCTION AND CAR CRASHES](https://gamehay-online.netlify.app/max-crusher-crazy-destruction-and-car-crashes.html)
- [IDLE PIZZA BUSINESS](https://jogosweb-brasil.github.io/idle-pizza-business.html)
- [STICKMAN RAGDOLL PLAYGROUND](https://jeuxflash-france.netlify.app/stickman-ragdoll-playground.html)
- [BLOCKAPOLYPSE ZOMBIE SHOOTER](https://hindigames-hub.netlify.app/blockapolypse-zombie-shooter.html)
- [ZOMBIE ARENA 2 FURY ROAD](https://arcadevault-gamehub.github.io/zombie-arena-2-fury-road.html)
- [WAVE DASH GEOMETRY ARROW](https://jogosweb-brasil24.netlify.app/wave-dash-geometry-arrow.html)
- [HEAD RUNNER DASH](https://luchshie-igry-rus.pages.dev/head-runner-dash.html)
- [SLOPE SNOWBALL](https://zona-juegos-flash.web.app/slope-snowball.html)
- [CANDY CHAIN MASTER](https://kuaile-youxi-hub.web.app/candy-chain-master.html)
- [PLANTS VS ZOMBIES WAR](https://arcadevault-gamehub.github.io/plants-vs-zombies-war.html)
- [VINE BOOM](https://meme-audio-hub.vercel.app/sound/vine-boom.html)
- [STICK TACTICS DESTRUCTION](https://kuaile-youxi-hub.web.app/stick-tactics-destruction.html)
- [WARLORD FANTASY RPG](https://zona-juegos-flash.web.app/warlord-fantasy-rpg.html)
- [THRONE VS BALLOONS](https://onlinerus-games.netlify.app/throne-vs-balloons.html)
- [EASY OBBY JUMP AND RUN CHALLENGE ONLINE](https://turbodrift-zone.web.app/easy-obby-jump-and-run-challenge-online.html)
- [TELEKINESIS ATTACK](https://speed-racing-arcade.pages.dev/telekinesis-attack.html)
- [SOLITAIRE KLONDIKE TREASURE ISLAND](https://pixelarcade-speed.web.app/solitaire-klondike-treasure-island.html)
- [TRIDENT ROD](https://fischdemand-live.pages.dev/calculator/trident-rod)
- [AGENTS IO](https://geim-cheon-guk24.pages.dev/agents-io.html)
- [VEX TRY TO FLY](https://gameflash-viet.github.io/vex-try-to-fly.html)
- [CONNECT CLUES THE MISSING PROFESSOR](https://onlinerus-portal.netlify.app/connect-clues-the-missing-professor.html)
- [TYPE SPRINT](https://dautruong-game24h.web.app/type-sprint.html)
- [GROW A GARDEN FOR BRAINROTS](https://nihongames-portal.netlify.app/grow-a-garden-for-brainrots.html)
- [CUBE SPEED DASH](https://francejeux-online.web.app/cube-speed-dash.html)
- [SUDOKU PINGAMES](https://luchshie-igry-rus.pages.dev/sudoku-pingames.html)
- [TANKS](https://zona-igr-besplatno.web.app/tanks.html)
- [FIND RESTORE HIDDEN PUZZLE](https://koreagame-zone.vercel.app/find-restore-hidden-puzzle.html)
- [HERO RABBIT IDLE SURVIVOR RPG](https://pixelarcade-speed.web.app/hero-rabbit-idle-survivor-rpg.html)
- [BOTTLE LOGIC](https://neon-cyber-arcade.pages.dev/bottle-logic.html)
- [KOMARU CAT](https://nihongames-web.github.io/komaru-cat.html)
- [SKY BLOCK BOUNCE](https://jogosweb-brasil24.netlify.app/sky-block-bounce.html)
- [SUPER MX MOTOCROSS SIMULATOR](https://speed-racing-arcade.pages.dev/super-mx-motocross-simulator.html)
- [BURGER EMPIRE](https://arcadevault-gamehub.github.io/burger-empire.html)
- [RACING MASTER 3D](https://speed-racing-arcade.pages.dev/racing-master-3d.html)
- [ANIMAL BLOCK POP PUZZLE](https://zona-juegos-flash.web.app/animal-block-pop-puzzle.html)
- [HUGE CUPCAKE](https://petrap-pro.pages.dev/calculator/huge-cupcake)
- [CARGO PATH PUZZLE](https://gemu-hiroba-japan.web.app/cargo-path-puzzle.html)
- [PIN BOARD PUZZLE](https://arcadevault-gamehub.github.io/pin-board-puzzle.html)
- [MINI GRAND THEFT CITY](https://francejeux-online.web.app/mini-grand-theft-city.html)
- [FOOTBALL LEGENDS 2026](https://quantum-puzzle-hub.pages.dev/football-legends-2026.html)
- [URBAN ASSAULT FORCE](https://juegosweb-gratis.github.io/urban-assault-force.html)
- [ESCAPE ROOM MYSTERY KEY](https://brainiac-puzzles.web.app/escape-room-mystery-key.html)
- [BLUE GIRLS MAKEUP](https://pixelarcadezgame.web.app/blue-girls-makeup.html)
- [LIGHT ACADEMIA FASHION](https://dautruong-game24h.web.app/light-academia-fashion.html)
- [BUDDHA](https://bf-demand-check.pages.dev/values/buddha)
- [DEATH BALL](https://pixelarcadezgame.web.app/death-ball.html)
- [TOILET PIN](https://brainiac-puzzles.web.app/toilet-pin.html)
- [DIGITAL CIRCUS RUN](https://juegosmundial-hoy.pages.dev/digital-circus-run.html)
- [FALLLING JEWELS](https://jeuxflash-france.netlify.app/fallling-jewels.html)
- [PIMPLE SQUEEZE](https://unblocked-action-arena.netlify.app/pimple-squeeze.html)
- [BATTLE ARENA](https://zona-igr-besplatno.web.app/battle-arena.html)
- [TRY TO COUNT THE BOXES BRAIN TRAINING](https://geim-cheon-guk24.pages.dev/try-to-count-the-boxes-brain-training.html)
- [CANDY COLOR SORT PUZZLE](https://gameflash-viet.github.io/candy-color-sort-puzzle.html)
- [AIRWAYS MAZE](https://logic-puzzle-world.pages.dev/airways-maze.html)
- [TRIANGLES](https://kuaile-youxi-hub.web.app/triangles.html)
- [CANDY CARVER](https://desi-gaming-arena.pages.dev/candy-carver.html)
- [DADDY RABBIT](https://juegosmundial-hoy.pages.dev/daddy-rabbit.html)
- [PRETTY SHEEP RUN](https://tokyo-arcade-web.pages.dev/pretty-sheep-run.html)
- [4 COLORS CARD MANIA](https://gameflash-viet.github.io/4-colors-card-mania.html)
- [DINO HUNTER KING](https://brainiac-puzzles.web.app/dino-hunter-king.html)
- [PUSH THEM](https://gemu-hiroba-japan.web.app/push-them.html)
- [RADICAL RAPPELLING](https://unblocked-galaxy.web.app/radical-rappelling.html)
- [BRAINROT CLEANING](https://youxi-h5-tiandi.pages.dev/brainrot-cleaning.html)
- [SPACE SURVIVOR](https://speed-racing-arcade.pages.dev/space-survivor.html)
- [OCTOPUS INVASION](https://unblocked-galaxy.github.io/octopus-invasion.html)
- [MATH MASTER](https://speed-racing-hub.netlify.app/math-master.html)
- [STEAMPUNK MERGE TO BATTLE](https://dautruong-game24h.web.app/steampunk-merge-to-battle.html)
- [POP STAR](https://PixelArcadezGame.github.io/pop-star.html)
- [PATO VS COPS](https://action-battle-hub.pages.dev/pato-vs-cops.html)
