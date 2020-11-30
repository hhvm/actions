#!/bin/sh
#
# Copyright (c) 2017-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

set -ex

OS=$(uname -s)

if [ "$OS" = "Linux" ]; then
  export DEBIAN_FRONTEND=noninteractive
  sudo apt-get update
  sudo apt-get install -y software-properties-common apt-transport-https
  sudo apt-key add "$(dirname "$0")/hhvm.gpg.key"
  if [ "$1" = "nightly" ]; then
    sudo add-apt-repository https://dl.hhvm.com/ubuntu
    sudo apt-get install -y hhvm-nightly
  elif [ "$1" = "latest" ]; then
    sudo add-apt-repository https://dl.hhvm.com/ubuntu
    sudo apt-get install -y hhvm
  else
    DISTRO=$(lsb_release --codename --short)
    sudo add-apt-repository \
      "deb https://dl.hhvm.com/ubuntu ${DISTRO}-$1 main"
    sudo apt-get install -y hhvm
  fi

elif [ "$OS" = "Darwin" ]; then
  brew tap hhvm/hhvm
  if [ "$1" = "latest" ]; then
    brew install hhvm
  else
    brew install "hhvm-$1"
  fi

else
  echo "Unknown OS: $OS"
  return 1
fi
