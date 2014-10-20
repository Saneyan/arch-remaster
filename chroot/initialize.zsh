echo "==> Initialise the pacman keyrings"
pacman-key --init
pacman-key --populate archlinux

echo "==> Install and update packages"
pacman -Syy
pacman -S --noconfirm yaourt
yaourt -Syua --force --noconfirm archiso linux
yaourt -S --noconfirm ruby

mkinitcpio -p linux

if [ -e /cookbooks ]; then
  gem install chef berkshelf
  if [ $? = 0 ]; then
    cd cookbooks
    chef-solo
  fi
fi
