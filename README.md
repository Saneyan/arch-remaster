Arch Remaster
=============

**Remastering Arch Linux ISO**

## Installation

Clone source codes from GitHub repository and download Arch Linux ISO from official website.
In advance, make Chef cookbooks to deploy your remastered Arch Linux ISO and system environment.

```
git clone https://github.com/Saneyan/arch-remaster.git arch-remaster
cd arch-remaster
```

## Usage

`remaster.sh` in bin directory is a entry of Arch Remaster. `help` command prints its usage.

```
bin/remaster.sh <command> <options>
```

### Deployment and Undepolyment

`deploy` command deploys arch-remaster environment to customize your Arch Linux ISO.

```
bin/remaster.sh deploy -i <arch_iso_path> -d <destination_dir>
```

To undeploy arch-remaster environment, use `undeploy` command.

```
bin/remaster.sh undeploy -d <destination_dir>
```

_Note: You might want to specify system architecture depending upon the situation. If so, you can use `-a` option, but you must specify 'x86\_64' or 'i686'._

This program uses **yaoutrt** to install and update packages. Before using the package management system, add `archlinuxfr` repository to <destination_dir>/mnt/etc/pacman.conf`.

```
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
```

Edit `<destination_dir>/mnt/etc/pacman.d/mirrorlist` to select the best mirror server.

## Build

The following command option specifies directory contents, remastered ISO path, full automatic building, squash filesystem and generating ISO file.
You can enter interactive shell without using `-f` option.

```
bin/remaster.sh build -i <dir_contents> -o <remastered_iso_path> -f -q -g
```

If you have your Chef cookbooks, you can deploy with them to use `-c` option.

```
bin/remaster.sh build -i <dir_contents> -o <remastered_iso_path> -c <cookbook_path> -f -g -q
```

## Update

To update remastered Arch Linux ISO, use `-u` option.

```
bin/remaster.sh build -i <dir_contents> -o <remastered_iso_path> -c <cookbook_path> -f -u
```

## License

MIT License.
