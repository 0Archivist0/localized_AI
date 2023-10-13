import importlib
import platform
import subprocess

libraries = {
    "pytorch": "torch",
    "tensorflow": "tensorflow",
    "flax": "flax"
}

missing_libraries = []

for library, module_name in libraries.items():
    try:
        importlib.import_module(module_name)
    except ImportError:
        missing_libraries.append(library)

if missing_libraries:
    print("The following libraries are missing and will be installed:")
    for library in missing_libraries:
        print(library)

    # Check the operating system
    operating_system = platform.system().lower()

    if "pytorch" in missing_libraries:
        # Install PyTorch
        try:
            import torch
        except ImportError:
            print("Installing PyTorch...")
            # Install PyTorch based on the operating system
            if operating_system == "linux":
                subprocess.run(["pip", "install", "torch"])
            elif operating_system == "darwin":
                subprocess.run(["pip", "install", "torch"])
            elif operating_system == "windows":
                subprocess.run(["pip", "install", "torch"])
            else:
                print("Unsupported operating system. Please install PyTorch manually.")

    if "tensorflow" in missing_libraries:
        # Install TensorFlow
        try:
            import tensorflow
        except ImportError:
            print("Installing TensorFlow...")
            # Install TensorFlow based on the operating system
            if operating_system == "linux":
                subprocess.run(["pip", "install", "tensorflow"])
            elif operating_system == "darwin":
                subprocess.run(["pip", "install", "tensorflow"])
            elif operating_system == "windows":
                subprocess.run(["pip", "install", "tensorflow"])
            else:
                print("Unsupported operating system. Please install TensorFlow manually.")

    if "flax" in missing_libraries:
        # Install Flax
        try:
            import flax
        except ImportError:
            print("Installing Flax...")
            # Install Flax based on the operating system
            if operating_system == "linux":
                subprocess.run(["pip", "install", "flax"])
            elif operating_system == "darwin":
                subprocess.run(["pip", "install", "flax"])
            elif operating_system == "windows":
                subprocess.run(["pip", "install", "flax"])
            else:
                print("Unsupported operating system. Please install Flax manually.")

    print("Installation completed.")
else:
    print("All required libraries are already installed.")

# Exit the script
exit()
