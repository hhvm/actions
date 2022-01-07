#!/bin/bash
#
# Copyright (c) 2017-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

set -e

HHVM="$1"
SKIP="$2"
FLAGS="$3"

if [ "$SKIP" = "true" ]; then
  echo "Lint skipped."
  exit 0
fi

if [ "$SKIP" != "false" ]; then
  echo "Invalid skip_lint value: $SKIP"
  exit 1
fi

if [ "$HHVM" = "nightly" ]; then
  echo "Lint skipped on nightly HHVM build."
  exit 0
fi

echo "::group::Lint"
(
  set -x
  vendor/bin/hhast-lint
)
echo "::endgroup::"
