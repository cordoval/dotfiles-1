desc "Update the dotfiles repo"
task :update do
  `git reset --hard > /dev/null`
  `git pull > /dev/null`
  `git submodule sync > /dev/null`
  `git submodule update --init > /dev/null`
done
