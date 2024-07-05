# tadashi1105's dotfiles

> [!WARNING]
> Don’t blindly use my settings unless you know what that entails. Use at your own risk!

## Installation

### Prerequisites

- A [Nerd Font](https://www.nerdfonts.com/) installed and enabled in your terminal.

### Install dotfiles

```sh
git clone --bare https://github.com/tadashi1105/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
```

```sh
brew bundle install
```

## Further reading

- [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)
