#!/bin/bash

./painbox -d -e ./redis-stable/src/redis-cli,-c,-p,$1,get,foo -e ./redis-stable/src/redis-cli,-c,-p,$1,set,foo,bar -e ./redis-stable/src/redis-cli,-c,-p,$1,get,foo -s primary_test_single.boprun -l follow

m4 primary_test_single.boprun.m4 > primary_test_single.boprun.dot && dot -Tpdf -o primary_test_single.boprun.pdf primary_test_single.boprun.dot

