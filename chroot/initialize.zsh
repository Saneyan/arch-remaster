echo "==> Initialise the pacman keyrings"
pacman-key --init
pacman-key --populate archlinux

echo "==> Install and update packages"
pacman -Syy
pacman -Syu --force --noconfirm archiso linux
pacman -S --noconfirm gcc make ruby

mkinitcpio -p linux

if [ -e /cookbooks ]; then
  export PATH=$PATH:$(ruby -e "print Gem.user_dir")/bin
  gem install chef berkshelf --verbose
  if [ $? = 0 ]; then
    cd /cookbooks/$COOKBOOK
    berks install
    berks vendor chef/cookbooks
    chef-solo -c ./solo.rb -j ./solo.json install
  fi
fi
