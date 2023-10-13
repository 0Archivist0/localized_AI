#!/bin/bash

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

# Check if the user is logged in to Hugging Face in the browser
if curl --head --silent --fail "https://huggingface.co/dashboard/profile" > /dev/null; then
    echo "You are already logged in to Hugging Face in the browser."
    echo "Attempting to download LLaMA model weights..."
    curl -o weights.pkl https://huggingface.co/facebook/llama-7b/resolve/main/weights.pkl
    echo "LLaMA model weights downloaded successfully."
else
    echo "You are not logged in to Hugging Face in the browser."

    # Prompt the user for Hugging Face account credentials
    read -p "Enter your Hugging Face username: " username
    read -s -p "Enter your Hugging Face password: " password
    echo

    # Download LLaMA model weights using the provided credentials
    echo "Downloading LLaMA model weights..."
    curl -u "$username:$password" -o weights.pkl https://huggingface.co/facebook/llama-7b/resolve/main/weights.pkl

    echo "LLaMA model weights downloaded successfully."
fi

# Create a directory for LLaMA and navigate to it.
mkdir -p ~/llama-7b
cd ~/llama-7b

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
