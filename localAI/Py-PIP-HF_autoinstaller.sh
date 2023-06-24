#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
fi

echo "Checking for Python3..."
if ! command -v python3 &> /dev/null; then
    echo "Python3 not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y python3
else
    echo "Python3 is already installed."
fi

echo "Checking for pip3..."
if ! command -v pip3 &> /dev/null; then
    echo "pip3 not found. Installing..."
    sudo apt-get install -y python3-pip
else
    echo "pip3 is already installed."
fi

echo "Installing Hugging Face Transformers library..."
pip3 install transformers

if ! pip3 show transformers &> /dev/null; then
    echo "Failed to install Hugging Face Transformers library."
    exit 1
fi

echo "Hugging Face Transformers library installed."

# Check to make sure that the Hugging Face Transformers library is installed in the correct location.
if [[ ! -d "$HOME/.local/lib/python3.8/site-packages/transformers" ]]; then
    echo "The Hugging Face Transformers library is not installed in the correct location."
    exit 1
fi

echo "Installation complete."
