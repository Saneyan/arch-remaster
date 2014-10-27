echo "==> Update packages"
mkinitcpio --preset linux --config /remaster/files/mkinitcpio.conf

if [ -e /cookbooks ]; then
  declare _gembin=$(ruby -e "print Gem.user_dir")/bin
  export PATH=$PATH:$_gembin
  ln -s _gembin /root/ruby-bin

  chef-zero -H 127.0.0.1 -p 7863 &
  sleep 3

  cd /cookbooks
  berks install
  berks vendor
  berks upload
  rm --recursive --verbose berks-cookbooks
  rm --verbose Berksfile.lock
  chef-client -S http://127.0.0.1:7863 -j /cookbooks/config.json -c /cookbooks/knife.rb

  pkill chef-zero
  sleep 3
fi
