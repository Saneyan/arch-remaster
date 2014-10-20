echo "==> Update packages"
yaourt -Syua --force --noconfirm archiso linux

mkinitcpio -p linux
