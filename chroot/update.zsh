echo "==> Update packages"
yaourt -Syua --force --noconfirm archiso linux

if [[ -n $COOKBOOK ]] && [ -e /cookbooks ]; then
  export PATH=$PATH:$(ruby -e "print Gem.user_dir")/bin
  cd cookbooks/$COOKBOOK
  berks install
  [ ! -e chef/cookbooks ] && berks vendor chef/cookbooks
  chef-solo -c ./solo.rb -j ./solo.json install
fi
