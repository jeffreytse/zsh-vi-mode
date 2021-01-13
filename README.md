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

<img alt="Zsh Vi-mode Demo" src="https://user-images.githubusercontent.com/9413601/101981242-61530300-3ca6-11eb-8c7a-c0f4c69562bb.gif" />


## ✨ Features

- 🎉 Better experience with the near-native vi(vim) mode.
- ⌛ Lower delay and better response (Mode switching, widget calling).
- ✏️  Mode indication with different cursor styles.
- 🧮 Cursor movement (Navigation).
- 📝 Insert & Replace (Insert mode).
- 💡 Text Objects.
- 🔎 Searching history.
- ❇️  Undo, Redo, Cut, Copy, Paste, and Delete.
- 🔮 Better surrounds functionality (Add, Replace, Delete, Move Around, and Highlight).
- 🔣 Switch keywords (Increase/Decrease Number, Boolean, etc. **In progress**).


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
which could better matches your flavor, such as `jj` or `jk` and so on.


History
-------

- `ctrl-p` : Previous command in history
- `ctrl-n` : Next command in history
- `/`      : Search backward in history
- `n`      : Repeat the last `/`


Mode indicators
---------------

`Normal mode` is indicated with block style cursor, and `Insert mode` with beam
style cursor by default.


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
variable.

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

-   `di(` or `vi(` -> `d`
-   `ca(` or `va(` -> `c`
-   `yi(` or `vi(` -> `y`


## 💎 Credits

- [Zsh](https://www.zsh.org/) - A powerful shell that operates as both an interactive shell and as a scripting language interpreter.
- [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh) - A delightful, open source, community-driven framework for managing your ZSH configuration.
- [vim-surround](https://github.com/tpope/vim-surround) - A vim plugin that all about "surroundings": parentheses, brackets, quotes, XML tags, and more.
- [vim-sandwich](https://github.com/machakann/vim-sandwich) - A set of operator and textobject plugins to add/delete/replace surroundings of a sandwiched textobject.

## 🔫 Contributing

Issues and Pull Requests are greatly appreciated. If you've never contributed to an open source project before I'm more than happy to walk you through how to create a pull request.

You can start by [opening an issue](https://github.com/jeffreytse/zsh-vi-mode/issues/new) describing the problem that you're looking to resolve and we'll go from there.

## 🌈 License

This theme is licensed under the [MIT license](https://opensource.org/licenses/mit-license.php) © JeffreyTse.
