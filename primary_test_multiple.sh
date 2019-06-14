#!/bin/bash

./painbox -d -e ./redis-stable/src/redis-cli,-c,-p,$1,get,foo -e ./redis-stable/src/redis-cli,-c,-p,$1,set,foo,bar -e ./redis-stable/src/redis-cli,-c,-p,$1,set,foo,baz -e ./redis-stable/src/redis-cli,-c,-p,$1,get,foo -s primary_test_multiple.boprun

m4 primary_test_multiple.boprun.m4 > primary_test_multiple.boprun.dot && dot -Tpdf -o primary_test_multiple.boprun.pdf primary_test_multiple.boprun.dot


