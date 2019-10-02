#!/bin/bash
# Author: Suhas Somnath

# Regardless of the rank we want to load the correct (Ana/mini)conda module:
bash
# Sanity check:
which pip

# Working around the annoying permission denied for runtime directory:
export XDG_RUNTIME_DIR=""

if [[ $SLURM_PROCID -eq 0 ]]; then

  # First find the compute node where Jupyter will run
  if [[ $SLURM_JOB_NUM_NODES -eq 1 ]]; then
    # No need to parse anything.
    master=$SLURM_JOB_NODELIST
  else
    # Parse the list of nodes
    # typically of the form or-slurm-c[00-01, 03]
    # First split based on '[' and get the second part: 00-01, 03]
    # Next split based on '-' and take the first number: 00
    # In some cases, nodes are assigned as "or-slurm-c[00, 05]"
    # To account for the comma, split by "," and take the first
    # Finally prepend with "or-slurm-c" because all we have is just the node number
    master="or-slurm-c"$(echo ${SLURM_JOB_NODELIST} | cut -d'[' -f 2 | cut -d'-' -f 1 | cut -d',' -f 1)
  fi

  # Now we have all the peices to the puzzle:
  port=$1
  hostname=$2
  verbose=$3

  if [[ $verbose -eq 1 ]]; then
    echo "Arguments from parent script: Port: ${port}, Verbose: ${verbose}, Hostname: ${hostname}"
    echo "SLURM allocated these nodes: ${SLURM_JOB_NODELIST}"
    echo "Nodes: ${SLURM_JOB_NODELIST}. Master = ${master}"
  fi

  echo "JupyterLab will now run on ${master}"
  echo "Now connect this server to your personal computer by following the steps below:"

  echo "1. Connect the login node (where you are seeing this) with the compute node (where Jupyter is running) by pasting the following command:"
  echo -e "\n"
  echo "      ssh -N -L $port:localhost:$port $master"
  echo -e "\n"
  echo "2. Open a new terminal window on your personal computer run the following command:"
  echo -e "\n"
  echo "      ssh -N -L $port:localhost:$port $USER@${hostname}"
  echo -e "\n"
  echo "and log in to this node to establish a tunnel between your personal computer and the login node"
  echo "3. Open a browser on your personal computer and enter the following address:"
  echo -e "\n"
  echo "      localhost:$port"
  echo -e "\n"
  echo "4. To shut down JupyterLab (and this job), click on 'File' in the top menu bar in JupyterLab and select 'Shut Down'. Confirm and you are done. You will still need to press 'Ctrl'+'C' in the terminal you used to connect to the login node form your personal computer"
  echo "=========================================================================================="
  # Starting the jupyter lab server here. Note the flags:
  # --no-browser - tells jupyter that there is no available broswer to render the server output
  # --NotebookApp.token='' - Removes authentication. Ideally the user should set their own password.
  # --port $1 - makes the jupyter server visible on the specified port.
  # in the event that multiple users use the same port, you could try a different number
  jupyter-lab --ip=0.0.0.0 --no-browser --NotebookApp.token='' --port $port
fi