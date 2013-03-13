# ttcalvm

An simple calculator with LLVM and treetop.

Usage:

    $ cat /tmp/a.txt
    1 + 2 + 3 * 2 * (3 + 2) % 6
    $ ./bin/ttcalvm /tmp/a.txt
    3
