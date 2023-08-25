#!/bin/bash

# Check if the script is being run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with root privileges (sudo)."
  exit 1
fi

# Check if Botpress is already installed
if command -v botpress &>/dev/null; then
  echo "Botpress is already installed."
else
  echo "Botpress is not installed. Installing..."
  # Remove existing file /usr/local/bin/bp if it exists
  if [ -f "/usr/local/bin/bp" ]; then
    echo "Removing existing /usr/local/bin/bp..."
    rm -f "/usr/local/bin/bp"
  fi
  npm install -g botpress
  if [ $? -ne 0 ]; then
    echo "Error: Botpress installation failed."
    exit 1
  fi
  echo "Botpress has been successfully installed."
fi

# Specify Botpress dependencies
botpress_dependencies=("sqlite3" "serialport" "nan" "sharp")

# ... (continue with the rest of your script)
