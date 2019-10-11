# This script will be executed by the batch node
# Authors: Shuto Araki, Suhas Somnath, Junqi Yin

# Arguments: port, hostname of login node, number of nodes

export HOME=$(pwd)

# The 01_login.sh passes the port number which must be picked up here
export PORT=$1

# Parsing the names of the compute nodes allocated for this job from the LSB variables
computenodes=$(cat ${LSB_DJOB_HOSTFILE} | sort | uniq | grep -v login | grep -v batch)

# Set one of these as the master node where the jupyter server will run
master=$(echo ${computenodes} | cut -d' ' -f1)

# Storing the number of requested nodes as a variable:
nnodes=$3

# Capturing the hostname of the login node as a variable:
hostname=$2

# Capturing the verbose flag:
verbose=$4
# If nothing came through, assume True:
verbose=${verbose:=1}

# Just printing out values of some of the variables here:
if [[ $verbose -eq 1 ]]; then 
  # echo -e "\n" >> bout.txt
  echo "# of nodes: $nnodes" >> bout.txt
  echo "Compute nodes:" >> bout.txt
  echo "$computenodes" >> bout.txt
  echo "Master node is: $master" >> bout.txt
  echo -e "\n" >> bout.txt

  echo "Starting jsrun with parameters: -n${nnodes} -a1 -c42 -g6 -r1" >> bout.txt
  echo -e "\n" >> bout.txt
fi

# Calling the script that will spawn the JupyterLab server:
jsrun -n${nnodes} -a1 -c42 -g6 -r1 ./03_compute.sh $PORT >> bout.txt &

echo "JupyterLab is now running on the compute node: $master." >> bout.txt
echo "Now establish connection with local machine via ssh tunelling" >> bout.txt
echo -e "\n" >> bout.txt

# Instructions on connecting the pipes:
echo "Follow the next 4 steps below:" >> bout.txt
echo "---------------------------------------------------------------" >> bout.txt
echo "1. Hit Ctrl+C" >> bout.txt
echo "2. Connect the login node (where you are seeing this) with the compute node (where Jupyter is running) by pasting the following command:" >> bout.txt
echo -e "\n" >> bout.txt
echo "      ssh -N -L $PORT:localhost:$PORT $master" >> bout.txt
echo -e "\n" >> bout.txt
echo "3. Open a new terminal window on your personal computer run the following command" >> bout.txt
echo -e "\n" >> bout.txt
echo "      ssh -N -L $PORT:localhost:$PORT $USER@${hostname}.summit.olcf.ornl.gov" >> bout.txt
echo -e "\n" >> bout.txt
echo "and log in to this node to establish a tunnel between your personal computer and the login node" >> bout.txt
echo "4. Open a browser on your personal computer and enter the following address:" >> bout.txt
echo -e "\n" >> bout.txt
echo "      localhost:$PORT" >> bout.txt