ZSH=$HOME/.dotfiles/.oh-my-zsh

# omz
ZSH_THEME="../../chadrien"

plugins=(git symfony2 brew bundler capistrano coffee composer node npm rake rvm)

source $ZSH/oh-my-zsh.sh
export DISABLE_AUTO_TITLE=true

# dotfiles bin
PATH=$PATH:$HOME/.dotfiles/.bin

# powerline
export PYTHONPATH=$PYTHONPATH:$HOME/.dotfiles/.python-packages/
# [[ -s "$HOME/.dotfiles/.python-packages/powerline/bindings/zsh/powerline.zsh" ]] && source "$HOME/.dotfiles/.python-packages/powerline/bindings/zsh/powerline.zsh"

[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
