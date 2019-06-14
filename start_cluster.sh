#!/bin/bash

cd ./redis-stable/utils/create-cluster
./create-cluster start
./create-cluster create
cd ../../..

