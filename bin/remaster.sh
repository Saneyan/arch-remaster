#!/bin/sh
#
# Entry of Arch Remaster.
#
# @author   TADOKORO Saneyuki <saneyan@mail.gfunction.com>
# @license  MIT License

declare -r _args=${@:2:($# - 1)}
declare -rg _dirname=$(cd $(dirname $0)/../ && pwd)
source $_dirname/subsets/remaster-{env,utils}

case $1 in
  "build") subcmds/build $_args;;
  "deploy") subcmds/deploy $_args;;
  "undeploy") subcmds/undeploy $_args;;
  *)
    cat <<_EOT_
Arch Remaster - Remastering Arch Linux ISO.

./remaster.sh <command> <options>

Commands:
  build    : Build remastered Arch Linux ISO. 
  deploy   : Deploy the environment.
  undeploy : Undeploy the environment. 

Build options:
  -i : The directory contents.
  -o : Remastered Arch ISO path.
  -c : The Cookbook path.
  -s : Shell in a chroot.
  -u : Update packages and the system.
  -f : Enable full automatic building.
  -g : Generate a new ISO file.
  -q : Squash a filesystem.
  -a : Specify system architecture.

Deploy options:
  -i : Input Arch Linux ISO.
  -d : Destination directory.
  -a : Specify system architecture.

Undeploy options:
  -d : The directory contents.
  -a : Specify system architecture.
  -X : Remove all contents.

_EOT_
    ;;
esac
