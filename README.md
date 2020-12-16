# zsh-vi-mode
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)
[![Donate (Liberapay)](http://img.shields.io/liberapay/goal/jeffreytse.svg?logo=liberapay)](https://liberapay.com/jeffreytse)
[![Donate (Patreon)](https://img.shields.io/badge/support-patreon-F96854.svg?style=flat-square)](https://patreon.com/jeffreytse)
<a href="https://ko-fi.com/jeffreytse">
  <img height="20" src="https://www.ko-fi.com/img/githubbutton_sm.svg"
    alt="Donate (Ko-fi)" />
</a>

💻 A better and friendly vi(vim) mode plugin for ZSH.

<img alt="Zsh Vi-mode Demo" src="https://user-images.githubusercontent.com/9413601/101981242-61530300-3ca6-11eb-8c7a-c0f4c69562bb.gif" />


## Features

- Cursor motion (Navigation).
- Insert & Replace (Insert mode).
- Text Objects.
- Searching text.
- Undo, Redo, Cut, Copy, Paste, and Delete.
- Surrounds (Add, Replace, Delete, and Move Around).
- ...

## Installation

### Using [Antigen](https://github.com/zsh-users/antigen)

Bundle `zsh-vi-mode` in your `.zshrc`

```shell
antigen bundle jeffreytse/zsh-vi-mode
```

### Using [zplug](https://github.com/b4b4r07/zplug)
Load `zsh-vi-mode` as a plugin in your `.zshrc`

```shell
zplug "jeffreytse/zsh-vi-mode"
```
### Using [zgen](https://github.com/tarjoilija/zgen)

Include the load command in your `.zshrc`

```shell
zgen load jeffreytse/zsh-vi-mode
```

### As an [Oh My Zsh!](https://github.com/robbyrussell/oh-my-zsh) custom plugin

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

### Manually
Clone this repository somewhere (`$HOME/.zsh-vi-mode` for example)

```shell
git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zsh-vi-mode
```
Then source it in your `.zshrc` (or `.bashrc`)

```shell
source $HOME/.zsh-vi/zsh-vi-mode.plugin.zsh
```

## Credits

- [Zsh](https://www.zsh.org/) - A powerful shell that operates as both an interactive shell and as a scripting language interpreter.
- [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh) - A delightful, open source, community-driven framework for managing your ZSH configuration.

## Contributing

Issues and Pull Requests are greatly appreciated. If you've never contributed to an open source project before I'm more than happy to walk you through how to create a pull request.

You can start by [opening an issue](https://github.com/jeffreytse/zsh-vi-mode/issues/new) describing the problem that you're looking to resolve and we'll go from there.

## License

This theme is licensed under the [MIT license](https://opensource.org/licenses/mit-license.php) © JeffreyTse.
