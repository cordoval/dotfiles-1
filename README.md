# Dotfiles

## Installation

### Pre-requisites

Make sure `git`, `ruby`, `zsh`, `hub` and `rake` are installed.

Also make sure `zsh` is your default shell:

```bash
$ chsh -s `which zsh`
```

or just change it in your /etc/passwd

### Automatic installer

Just run:

```bash
$ curl -sS https://raw.github.com/chadrien/dotfiles/master/bootstrap.sh | bash
```

### How to use

#### ZSH

##### Theme

I made a theme of my own **highly inspired by [jeremyFreeAgent's Powerline theme](https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme), [agnoster's theme](https://gist.github.com/3712874) and [jubianchi's theme](https://github.com/jubianchi/dotfiles/blob/master/.oh-my-zsh/themes/jubianchi.zsh-theme)**

##### Customization

You can create ~/.zshrc.local which will be included at the end of ~/.zshrc

#### Git

##### Config

First create a local config file: `touch ~/.gitconfig.local`

Then open the file and insert this:

```ini
[user]
  name = <your username>
  email = <your email>

[github]
  user = <your github username>
  password = <your github password>
```

##### Aliases

You can list the aliases via the command line with: `git aliases`

##### Customization

All your local configuration can be made in ~/.gitconfig.local without
being overwritten by a futur update of this repo.
