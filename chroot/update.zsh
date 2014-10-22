echo "==> Update packages"
pacman -Syu --force --noconfirm archiso linux

if [ -e /cookbooks ]; then
  export PATH=$PATH:$(ruby -e "print Gem.user_dir")/bin
  cd cookbooks
  berks install
  [ ! -e chef/cookbooks ] && berks vendor chef/cookbooks
  chef-solo -c ./solo.rb -j ./solo.json install
fi
