<div align="center">
  <a href="https://github.com/jeffreytse/zsh-vi-mode">
    <img alt="vi-mode →~ zsh" src="https://user-images.githubusercontent.com/9413601/103399068-46bfcb80-4b7a-11eb-8741-86cff3d85a69.png" width="600">
  </a>
  <p> 💻 A better and friendly vi(vim) mode plugin for ZSH.  </p>

  <br> <h1>⚒️  Zsh Vi Mode ⚒️</h1> <br>

</div>



<h4 align="center">
  <a href="https://www.zsh.org/" target="_blank"><code>ZSH</code></a> plugin for Agnosticism.
</h4>

<p align="center">

  <a href="https://github.com/jeffreytse/zsh-vi-mode/releases">
    <img src="https://img.shields.io/github/v/release/jeffreytse/zsh-vi-mode?color=brightgreen"
      alt="Release Version" />
  </a>

  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-brightgreen.svg"
      alt="License: MIT" />
  </a>

  <a href="">
    <img src=""
      alt="" />
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
    <img height="20" src="https://www.ko-fi.com/img/githubbutton_sm.svg"
      alt="Donate (Ko-fi)" />
  </a>

</p>

<div align="center">
  <sub>Built with ❤︎ by
  <a href="https://jeffreytse.net">jeffreytse</a> and
  <a href="https://github.com/jeffreytse/zsh-vi-mode/graphs/contributors">contributors </a>
</div>
<br>

<img alt="Zsh Vi-mode Demo" src="https://user-images.githubusercontent.com/9413601/105746868-f3734a00-5f7a-11eb-8db5-22fcf50a171b.gif" />


## ✨ Features

- 🎉 Better experience with the near-native vi(vim) mode.
- ⌛ Lower delay and better response (Mode switching, widget calling).
- ✏️  Mode indication with different cursor styles.
- 🧮 Cursor movement (Navigation).
- 📝 Insert & Replace (Insert mode).
- 💡 Text Objects (A word, inner word, etc.).
- 🔎 Searching history.
- ❇️  Undo, Redo, Cut, Copy, Paste, and Delete.
- 🔮 Better surrounds functionality (Add, Replace, Delete, Move Around, and Highlight).
- 🔣 Switch keywords (Increase/Decrease Number, Boolean, Weekday, Month, etc.).
- ⚙️  Better functionality in command mode (**In progress**).
- 🌀 Repeating command such as `10p` and `4fa` (**In progress**).
- 📒 System clipboard (**In progress**).

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

#### Using [zinit](https://github.com/zdharma/zinit)

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
  $HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode
```
Then load as a plugin in your `.zshrc`

```shell
plugins+=(zsh-vi-mode)
```

Keep in mind that plugins need to be added before `oh-my-zsh.sh` is sourced.

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

#### Manually

Clone this repository somewhere (`$HOME/.zsh-vi-mode` for example)

```shell
git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zsh-vi-mode
```
Then source it in your `.zshrc` (or `.bashrc`)

```shell
source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
```

## 📚 Usage

Use `ESC` or `CTRL-[` to enter `Normal mode` (Each command line starting with
`Insert mode` by default).

Also, you can use the `ZVM_VI_ESCAPE_BINDKEY` option to custom the escape key
which could better match your flavor, such as `jj` or `jk` and so on.

And you can use the `ZVM_KEYTIMEOUT` option to adjust the key input timeout
for waiting for next key, default is `0.3` seconds.

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

Since this plugin will overwrite the previous key bindings, this causes the
key bindings of other plugins ( such as `fzf` ) to fail.

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
  esac
}
```

Custom Cursor Style
--------

This plugin has provided some options for users to custom the cursor
style for better terminal compatibility.

- You can set your cursor style for different vi mode:

```zsh
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
```

- And the below cursor styles are supported:

```zsh
ZVM_CURSOR_BLOCK
ZVM_CURSOR_UNDERLINE
ZVM_CURSOR_BEAM
ZVM_CURSOR_BLINKING_BLOCK
ZVM_CURSOR_BLINKING_UNDERLINE
ZVM_CURSOR_BLINKING_BEAM
```

- Custom your cursor style is easy as below:

```zsh
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
```

- This feature can be disabled by the `ZVM_CURSOR_STYLE_ENABLED` option
(Default is `true`)

```zsh
# Disable the cursor style feature
ZVM_CURSOR_STYLE_ENABLED=false
```

Lazy Keybindings
--------

This plugin has supported the lazy keybindings feature, and it is enabled
by default. To disable it, you can set the option `ZVM_LAZY_KEYBINDINGS`
to `false` before this plugin is loaded. This feature will postpone all
the keybindings of `normal` and `visual` mode) to the first time you enter
the normal mode.

It can greatly improve the startup speed, especially you open the terminal
and just want to execute a simple command.

## 💎 Credits

- [Zsh](https://www.zsh.org/) - A powerful shell that operates as both an interactive shell and as a scripting language interpreter.
- [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh) - A delightful, open source, community-driven framework for managing your ZSH configuration.
- [vim-surround](https://github.com/tpope/vim-surround) - A vim plugin that all about "surroundings": parentheses, brackets, quotes, XML tags, and more.
- [vim-sandwich](https://github.com/machakann/vim-sandwich) - A set of operator and textobject plugins to add/delete/replace surroundings of a sandwiched textobject.

## 🔫 Contributing

Issues and Pull Requests are greatly appreciated. If you've never contributed to an open source project before I'm more than happy to walk you through how to create a pull request.

You can start by [opening an issue](https://github.com/jeffreytse/zsh-vi-mode/issues/new) describing the problem that you're looking to resolve and we'll go from there.

## 🌈 License

This theme is licensed under the [MIT license](https://opensource.org/licenses/mit-license.php) © Jeffrey Tse.
