Arch Remaster
=============

**Remastering Arch Linux ISO**

## Installation

Clone from GitHub repository and download Arch Linux ISO from official website.
In advance, make Chef cookbooks to deploy your remastering Arch Linux ISO and the system environment.

```
git clone https://github.com/Saneyan/arch-remaster.git arch-remaster
cd arch-remaster
```

## Usage

`remaster.sh` in bin directory is a entry of Arch Remaster. `help` command prints its usage in detail.

```
bin/remaster.sh <command> <options>
```

### Deployment and Undepolyment

Deploy an environment to customize Arch Linux ISO by using `deploy` command.

```
bin/remaster.sh deploy -i <arch_iso_path> -d <destination_dir>
```

To undeploy an environment, use `undeploy` command.

```
bin/remaster.sh undeploy -d <destination_dir>
```

_Note: You might want to specify system architecture depending upon the situation. If so, you can use `-a` option which must be assigned 'x86\_64' or 'i686'._

## Build

The following command option specifies directory contents, remastered ISO path, full automatic building, squash filesystem and generating ISO file.

```
bin/remaster.sh build -i <dir_contents> -o <remastered_iso_path> -f -g -q
```

## License

MIT License.
