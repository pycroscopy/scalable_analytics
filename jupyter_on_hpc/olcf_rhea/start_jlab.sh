#!/bin/bash
# Author: Suhas Somnath
# This script will run JupyterLab on a compute node

# Regardless of the rank we want to load the correct (Ana/mini)conda module:
module load python/3.7.0-anaconda3-2018.12

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
    # First find the base name for the node - "or-slurm-c" that precedes the node number
    prefix=$(echo ${SLURM_JOB_NODELIST} | cut -d'[' -f 1)
    # First split based on '[' and get the second part: 00-01, 03]
    # Next split based on '-' and take the first number: 00
    # In some cases, nodes are assigned as "or-slurm-c[00, 05]"
    # To account for the comma, split by "," and take the first
    nodenum=$(echo ${SLURM_JOB_NODELIST} | cut -d'[' -f 2 | cut -d'-' -f 1 | cut -d',' -f 1)
    # Finally prepend with the prefix because all we have is just the node number
    master=${prefix}${nodenum}
  fi

  # Now we have all the peices to the puzzle:
  port=$1
  hostname=$(echo $2 | cut -c1-11) # Remove the 'g'
  verbose=$3

  if [[ $verbose -eq 1 ]]; then
    echo "Arguments from parent script: Port: ${port}, Verbose: ${verbose}, Hostname: ${hostname}" >> bout.txt
    echo "SLURM allocated these nodes: ${SLURM_JOB_NODELIST}" >> bout.txt
    echo "Nodes: ${SLURM_JOB_NODELIST}. Master = ${master}" >> bout.txt
  fi

  echo "JupyterLab will now run on ${master}" >> bout.txt
  echo "Now connect this server to your personal computer by following the steps below:" >> bout.txt

  echo "1. Connect the login node (where you are seeing this) with the compute node (where Jupyter is running) by pasting the following command:" >> bout.txt
  echo -e "\n" >> bout.txt
  echo "      ssh -N -L $port:localhost:$port $master" >> bout.txt
  echo -e "\n" >> bout.txt
  echo "2. Open a new terminal window on your personal computer run the following command:" >> bout.txt
  echo -e "\n" >> bout.txt
  echo "      ssh -N -L $port:localhost:$port $USER@${hostname}.ccs.ornl.gov" >> bout.txt
  echo -e "\n" >> bout.txt
  echo "and log in to this node to establish a tunnel between your personal computer and the login node" >> bout.txt
  echo "3. Open a browser on your personal computer and enter the following address:" >> bout.txt
  echo -e "\n" >> bout.txt
  echo "      localhost:$port" >> bout.txt
  echo -e "\n" >> bout.txt
  echo "4. To shut down JupyterLab (and this job), click on 'File' in the top menu bar in JupyterLab and select 'Shut Down'. Confirm and you are done. You will still need to press 'Ctrl'+'C' in the terminal you used to connect to the login node form your personal computer" >> bout.txt
  echo "=====================  END OF INSTRUCTIONS  ==============================" >> bout.txt
  # Starting the jupyter lab server here. Note the flags:
  # --no-browser - tells jupyter that there is no available broswer to render the server output
  # --NotebookApp.token='' - Removes authentication. Ideally the user should set their own password.
  # --port $1 - makes the jupyter server visible on the specified port.
  # in the event that multiple users use the same port, you could try a different number
  jupyter-lab --ip=0.0.0.0 --no-browser --port $port # >> bout.txt
fi