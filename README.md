# Dotfiles

## Emacs
On Windows put `init.el` into `%APPDATA%\.emacs.d\` which is (`C:\Users\<username>\AppData\Roaming\.emacs.d\` by default)

## Neovim
Link `nvim` folder into
~/.config/nvim
on Linux or

C:\Users\<username>\AppData\Local\nvim
on Windows

The result should be i.e. a folder:
C:\Users\<username>\AppData\Local\nvim

Use good UI that supports drag-and-drop on windows instead of default QT UI:
https://github.com/neovide/neovide
We can just put the executable into our neovim installation directory
