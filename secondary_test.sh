#!/bin/bash

./painbox -d -e ./redis-stable/src/redis-cli,--slave,-p,$1 -s secondary_test_$2.boprun

m4 secondary_test_$2.boprun.m4 > secondary_test_$2.boprun.dot && dot -Tpdf -o secondary_test_$2.boprun.pdf secondary_test_$2.boprun.dot

