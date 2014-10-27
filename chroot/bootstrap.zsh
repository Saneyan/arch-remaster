source /remaster/subsets/remaster-utils

if [ -e $AFTERZ ]; then
  mv --verbose $AFTERZ $DEFAULTZ
  source $DEFAULTZ
else
  rm --verbose $DEFAULTZ
fi

if [ $UPDATE = true ]; then
  source /remaster/chroot/update.zsh
else
  source /remaster/chroot/initialize.zsh
fi

LANG=C pacman -Sl | awk '/\[installed\]$/ {print $1 "/" $2 "-" $3}' > /pkglist.txt
pacman -Scc --noconfirm

exit 0
