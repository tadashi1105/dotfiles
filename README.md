# tadashi1105's dotfiles

> [!WARNING]
> Don’t blindly use my settings unless you know what that entails. Use at your own risk!

## Installation

### Prerequisites

- A [Nerd Font](https://www.nerdfonts.com/) installed and enabled in your terminal.

```sh
brew install --cask font-monaspace-nerd-font
```

### Install dotfiles

```sh
brew install neovim
brew install starship
brew install tmux
```

```sh
git clone --bare https://github.com/tadashi1105/dotfiles.git ~/.dotfiles
git --git-dir=~/.dotfiles/ --work-tree=~ checkout
```

## Link

- [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)
