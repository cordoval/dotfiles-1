# strongly inspired by https://github.com/carlhuda/janus/blob/master/bootstrap.sh

function die()
{
  echo "${@}"
  exit 1
}

git clone https://github.com/chadrien/dotfiles.git $HOME/.dotfiles \
    || die "Could not clone the repository to ${HOME}/.dotfiles"

cd $HOME/.dotfiles || die "Could not go into the ${HOME}/.dotfiles"
rake || die "Rake failed."
