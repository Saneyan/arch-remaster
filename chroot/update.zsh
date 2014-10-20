echo "==> Update packages"
yaourt -Syua --force --noconfirm archiso linux

mkinitcpio -p linux

if [ -e /cookbooks ]; then
  export PATH=$PATH:$(ruby -e "print Gem.user_dir")/bin
  cd cookbooks/$COOKBOOK
  berks update
fi
