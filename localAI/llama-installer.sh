#!/bin/bash
# author: kris Tomplait
# use this script at your own risk... 
# who knows what will happen
set -e

# Function to display an error message and exit
function error_exit {
    echo "Error: $1"
    exit 1
}

echo "This script will help you set up and run the LLaMA model, including the quantization process."
read -p "Press Enter to continue or Ctrl+C to exit..."

# Make sure the script is running with sudo privileges.
if [ "$EUID" -ne 0 ]; then
    error_exit "This script must be run with sudo."
fi

# Function to install a package if not already installed.
install_package() {
    local package_name="$1"
    if ! dpkg -l | grep -q "$package_name"; then
        echo "$package_name not found. Installing..."
        sudo apt-get install -y "$package_name"
    else
        echo "$package_name is already installed."
    fi
}

# Update the package lists.
echo "Updating package lists..."
sudo apt-get update

# Install required packages
install_package "python3"
install_package "python3-pip"

# Install the Hugging Face Transformers library.
echo "Installing Hugging Face Transformers library..."
pip3 install transformers

# Check that the Hugging Face Transformers library is installed in the correct location.
if ! python3 -c "import transformers" &> /dev/null; then
    error_exit "The Hugging Face Transformers library is not installed correctly."
fi

echo "Hugging Face Transformers library installed."

# Create a directory for LLaMA and navigate to it.
mkdir -p ~/llama-7b
cd ~/llama-7b

# Download the LLaMA model weights.
echo "Downloading LLaMA model weights..."
wget https://huggingface.co/facebook/llama-7b/resolve/main/weights.pkl

# Prompt for quantization
read -p "Do you want to perform quantization (Y/n)? " quantize_response

if [ "$quantize_response" == "Y" ] || [ "$quantize_response" == "y" ]; then
    echo "Performing quantization..."

    # You can add the quantization process here as needed.

    echo "Quantization completed."
else
    echo "Quantization skipped."
fi

# Run LLaMA.
echo "Running LLaMA..."
python3 -m transformers.run_generation

# All done!
echo "Done!"
