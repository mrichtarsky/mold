#!/bin/bash
export LC_ALL=C
set -e
CC="${CC:-cc}"
CXX="${CXX:-c++}"
testname=$(basename "$0" .sh)
echo -n "Testing $testname ... "
cd "$(dirname "$0")"/../..
mold="$(pwd)/ld64.mold"
t=out/test/macho/$testname
mkdir -p $t

cat <<EOF | $CC -o $t/exe -xc - -Wl,-adhoc_codesign
#include <stdio.h>

int main() {
  printf("Hello world\n");
}
EOF

$t/exe | fgrep -q 'Hello world'

echo OK
