echo "==> Initialise the pacman keyrings"
pacman-key --init
pacman-key --populate archlinux

echo "==> Install and update packages"
pacman -Syy
pacman -Syu --force --noconfirm archiso linux
pacman -S --noconfirm gcc make autoconf ruby git

mkinitcpio --preset linux --config /remaster/files/mkinitcpio.conf

if [ -e /cookbooks ]; then
  declare _gembin=$(ruby -e "print Gem.user_dir")/bin
  export PATH=$PATH:$_gembin
  ln -s _gembin /root/ruby-bin
  unset _gembin

  gem install chef chef-zero berkshelf --verbose --no-doc --no-ri

  if [ $? = 0 ]; then
    if [ ! -e /usr/lib/systemd/system/chef-zero.service ]; then
      cp /remaster/files/chef-zero.service /usr/lib/systemd/system/chef-zero.service
      systemctl enable chef-zero
    fi

    chef-zero -H 127.0.0.1 -p 7863 &
    sleep 3

    cd /cookbooks
    berks install
    berks vendor
    berks upload
    rm --recursive --verbose berks-cookbooks
    rm --verbose Berksfile.lock
    chef-client -S http://127.0.0.1:7863 -j /cookbooks/config.json -c /cookbooks/knife.rb
  fi

  pkill chef-zero
  sleep 3
fi
