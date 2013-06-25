ZSH=$HOME/.dotfiles/.oh-my-zsh

plugins=(git symfony2 tmuxinator)

source $ZSH/oh-my-zsh.sh
export DISABLE_AUTO_TITLE=true

# dotfiles bin
PATH=$PATH:$HOME/.dotfiles/.bin

# powerline
export PYTHONPATH=$PYTHONPATH:$HOME/.dotfiles/.python-packages/
[[ -s "$HOME/.dotfiles/.python-packages/powerline/bindings/zsh/powerline.zsh" ]] && source "$HOME/.dotfiles/.python-packages/powerline/bindings/zsh/powerline.zsh"

[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
