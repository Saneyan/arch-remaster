#!/bin/sh
#
# Remastering Arch Linux ISO.
#
# @author   TADOKORO Saneyuki <saneyan@mail.gfunction.com>
# @license  MIT License
#

[ "$(whoami)" != "root" ] && echo "Root privilege required." && exit 1

declare _in= _out= _cookbook=
declare _arch=$(uname -m)       # The target architecture
declare _shell=/bin/bash        # The default shell on chroot
declare -r _pool=/tmp/customiso # The pool path of custom ISO (Read-only)
declare -r _mntp=/mnt/archiso   # The mount point of Arch ISO (Read-only)
declare -r _dirname=$(cd $(dirname $0) && pwd)

source $_dirname/remaster-utils

while getopts i:o: opt; do
  case $opt in
    # Arch ISO path.
    i) _in=$OPTARG ;;
    # Arch remasterd ISO path.
    o) _out=$OPTARG ;;
    # Chef cookbooks' path.
    c) _cookbook=$OPTARG ;;
    # The shell binary path on chroot.
    s) _shell=$OPTARG ;;
    # The target architecture. It must be x86_64 or i686 architecture.
    a)
      if [[ "$OPTARG" =~ "^(x86_64|i686)$" ]]; then
        _arch=$OPTARG
      else
        echo "Specify an architecture, 'x86_64' or 'i686'"
        return 1
      fi
      ;;
  esac
done

[[ -z $_in ]] && echo "Arch ISO path is required." && exit 1
[[ -z $_out ]] && echo "Remastered ISO path is required." && exit 1

readonly _in _out _cookbook _arch _shell

echo "Start building remastered Arch Linux..."

__ ":: Extract and unsquashing filesystem..."
[ ! -e $_mntp ] && mkdir --verbose $_mntp
mount --verbose --types iso9660 --options loop $_in $_mntp
cp --archive --verbose $_mntp $_pool
ls -l $_pool

cd $_pool/arch/$_arch
unsquashfs airootfs.sfs

mkdir --verbose mnt
mount --verbose --options loop squashfs-root/airootfs.img mnt
mkdir --verbose mnt/remaster
mount --verbose --rbind $_dirname mnt/remaster

# These cookbooks must be included in ISO.
__ ":: Bundling cookbooks..."

if [[ -n $_cookbook ]]; then
  if [[ $_cookbook =~ "^git://|^https?://" ]]; then
    git clone $_cookbook mnt/cookbooks
  elif [ -e $_cookbook ]; then
    cp --archive --verbose $_cookbook mnt/cookbooks
  fi
else
  echo "No cookbooks specified."
fi

echo "Let's customize your Arch Linux. Enjoy!"
#arch-chroot mnt $_shell

__ ":: Making squashfs..."
cp --verbose mnt/boot/vmlinuz-linux $_pool/arch/boot/$_arch/vmlinuz
cp --verbose mnt/boot/initramfs-linux.img $_pool/arch/boot/$_arch/archiso.img
mv --verbose mnt/pkglist.txt $_pool/arch/pkglist.$_arch.txt

umount mnt
rm --verbose airootfs.sfs
mksquashfs squashfs-root airootfs.sfs

__ ":: Updating files..."
rmdir --verbose mnt
rm --recursive --verbose squashfs-root
md5sum airootfs.sfs > airootfs.md5

__ ":: Generating remastered Arch ISO..."
genisoimage -r -V -J -l "ARCH_gfunction_$(date +"%Y%m%d")"\
  -b isolinux/isolinux.bin\
  -c isolinux/boot.cat\
  -o $_out \
  -no-emul-boot -boot-load-size 4 -boot-info-table $_pool

__ ":: Cleaning up..."
umount $_mntp
rm --recursive --verbose $_mntp $_pool

echo "Done!"
exit 0
