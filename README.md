Arch Remaster
=============

**Remastering Arch Linux ISO**

## Installation

Install arch-remaster package from AUR and download Arch Linux ISO from official website.
In advance, make Chef cookbooks to deploy your remastered Arch Linux ISO and system environment.

```
yaourt -S arch-remaster
```

## Usage

`arch-remaster` in bin directory is a entry of Arch Remaster. `help` command prints its usage.

```
arch-remaster <command> <options>
```

### Deployment and Undepolyment

`deploy` command deploys arch-remaster environment to customize your Arch Linux ISO.

```
arch-remaster deploy -i <arch_iso_path> -d <destination_dir>
```

To undeploy arch-remaster environment, use `undeploy` command.

```
arch-remaster undeploy -d <destination_dir>
```

_Note: You might want to specify system architecture depending upon the situation. If so, you can use `-a` option, but you must specify 'x86\_64' or 'i686'._

Edit `<destination_dir>/mnt/etc/pacman.d/mirrorlist` to select the best mirror server.

## Build

The following command option specifies directory contents, remastered ISO path, full automatic building, squash filesystem and generating ISO file.
You can enter interactive shell without using `-f` option.

```
arch-remaster build -i <dir_contents> -o <remastered_iso_path> -f -q -g
```

If you have your Chef cookbooks, you can deploy with them to use `-c` option.

```
arch-remaster build -i <dir_contents> -o <remastered_iso_path> -c <cookbook_path> -f -g -q
```

## Update

To update remastered Arch Linux ISO, use `-u` option.

```
arch-remaster build -i <dir_contents> -o <remastered_iso_path> -f -u
```

## License

MIT License.
