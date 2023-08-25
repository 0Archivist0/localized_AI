#!/bin/bash

# First we should update apt, just in case.
sudo apt update
# Install python

sudo apt install python3-dev python3

# Once it is installed you should be able to confirm the versions.
python3 --version 
pip3 --version
