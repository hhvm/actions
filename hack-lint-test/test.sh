#!/bin/bash
#
# Copyright (c) 2017-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

set -e

SKIP="$1"
FLAGS="$2"

if [ "$SKIP" = "true" ]; then
  echo "Tests skipped."
  exit 0
fi

if [ "$SKIP" != "false" ]; then
  echo "Invalid skip_tests value: $SKIP"
  exit 1
fi

echo "::group::Run tests"
(
  set -x
  hhvm $FLAGS vendor/bin/hacktest tests/
)
echo "::endgroup::"
