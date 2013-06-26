desc "Update the dotfiles repo"
task :update do
  puts " Cleaning the folder… ".bg_brown.black
  `git reset --hard > /dev/null`
  puts " Done! ".bg_green.black

  puts " Grabbing latest changes… ".bg_brown.black
  `git pull > /dev/null`
  puts " Done! ".bg_green.black

  puts " Updating dependencies… ".bg_brown.black
  `git submodule sync > /dev/null`
  `git submodule update --init > /dev/null`
  puts " Done! ".bg_green.black
end

desc "Install the dotfiles"
task :install => [:folders, :symlinks] do
end

task :folders do
  create_list = [
    "#{ENV['HOME']}/.config"
  ]

  create_list.each do |folder|
    FileUtils.mkdir_p folder
  end
end

task :symlinks do
  symlinks = {
    '.gitconfig'        => ".gitconfig",
    '.gitignore'        => ".gitignore",
    '.tmux.conf'        => ".tmux.conf",
    '.vim'              => ".vim",
    '.vimrc'            => ".vimrc",
    '.zshrc'            => ".zshrc",
    '.config/powerline' => ".config/powerline",
  }

  symlinks.each do |from_dots, symlink|
    from_dots = "#{ENV['HOME']}/.dotfiles/#{from_dots}"
    symlink   = "#{ENV['HOME']}/#{symlink}"

    FileUtils.rm_rf(symlink) if File.exists?(symlink) || File.symlink?(symlink)

    FileUtils.ln_s from_dots, symlink
  end
end

desc "Install or update the dotfiles."
task :default => [:update, :install] do
end

# add some colors
class String
  def black;          "\033[30m#{self}\033[0m" end
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def brown;          "\033[33m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def magenta;        "\033[35m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
  def bg_black;       "\033[40m#{self}\0330m"  end
  def bg_red;         "\033[41m#{self}\033[0m" end
  def bg_green;       "\033[42m#{self}\033[0m" end
  def bg_brown;       "\033[43m#{self}\033[0m" end
  def bg_blue;        "\033[44m#{self}\033[0m" end
  def bg_magenta;     "\033[45m#{self}\033[0m" end
  def bg_cyan;        "\033[46m#{self}\033[0m" end
  def bg_gray;        "\033[47m#{self}\033[0m" end
  def bold;           "\033[1m#{self}\033[22m" end
  def reverse_color;  "\033[7m#{self}\033[27m" end
end
