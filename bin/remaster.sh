#!/bin/sh
#
# Remastering Arch Linux ISO.
#
# @author   TADOKORO Saneyuki <saneyan@mail.gfunction.com>
# @license  MIT License

case $1 in
  "build") subsets/build ${@:2:($# - 1)};;
  "deploy") subsets/deploy ${@:2:($# - 1)};;
  "undeploy") subsets/undeploy ${@:2:($# - 1)};;
esac
