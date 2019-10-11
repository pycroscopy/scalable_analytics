#!/bin/bash

echo -e "\n" >> bout.txt

# To work around the permission denied problem:
unset XDG_RUNTIME_DIR

export HOME=$(pwd)

echo "The compute node home is $HOME" >> bout.txt

# Starting the jupyter lab server here. Note the flags:
# --no-browser - tells jupyter that there is no available broswer to render the server output
# --NotebookApp.token='' - Removes authentication. Ideally the user should set their own password. 
# --port $1 - makes the jupyter server visible on the specified port. 
# in the event that multiple users use the same port, you could try a different number
jupyter-lab --ip=0.0.0.0 --no-browser --NotebookApp.token='' --port $1 >> bout.txt