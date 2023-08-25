#!/bin/bash

# Source the virtualenv

source ./venv/bin/activate

# Install Rasa and Upgrade pip 

python -m pip install --upgrade pip rasa

# Our `python` now refers to the python version in the virtualenv.
# From here you should be able to use Rasa

python -m rasa --help
python -m rasa init
