#!/bin/bash
# This script requests a job from the scheduler to run the JupyterLab server
# Author: Suhas Somnath

# Default values for flags:
nnodes=1 # Number of nodes: -n flag
queue='testing' # Does not have a flag. Change if necessary
port=5959 # Port at which JupyterLab will run: -p flag
walltime=0:30 # How long the job will run: -t flag
account='birthright' # Account you belong to: -A flag
verbose=0 # Set to 1 if you want more print statements: -v flag

print_usage() {
  printf "Usage: \nscript_name -A <account to charge to> <optional flags - see below>\n"
  printf "-N <number of nodes>; optional; defaults to 1\n"
  printf "-p <port number>; optional; defaults to 5959\n"
  printf "-t <wall time>; optional; defaults to 0:30\n"
  printf "-v = verbose mode; optional; defaults to False\n"
}

# Note: If a character is followed by a colon (e.g. n:), that option is expected to have an argument.
while getopts 'A:n:p:t:v' flag; do
  case "${flag}" in
    A) account="${OPTARG}" ;;
    n) nnodes="${OPTARG}" ;;
    p) port="${OPTARG}" ;;
    t) walltime="${OPTARG}" ;;
    v) verbose=1 ;;
    *) print_usage
       exit 1 ;;
  esac
done

# Now validate each of the arguments:
re='^[0-9]+$'
if ! [[ $nnodes =~ $re ]] ; then
   echo "ERROR: Number of nodes specified with the '-n' flag was not valid"; exit 1
fi

re='^[0-9]+$'
if ! [[ $port =~ $re ]] ; then
   echo "ERROR: Port specified using the '-p' flag was not valid"; exit 1
fi

if [ -z "$account" ]; then
   echo "ERROR: Account not specified. Use the -A flag"; exit 1
fi

if [[ $verbose -eq 1 ]]; then
  echo "sending: sbatch -A ${account} -p ${queue} -N ${nnodes} -n ${nnodes} -c 32 -J Jupyter --mem=32G -t ${walltime}  start_jlab.sh ${port} ${HOSTNAME} ${verbose}"
fi

echo "Starting SLURM job requesting JupyterLab with ${nnodes} nodes for time: ${walltime}" > bout.txt
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "type 'cat bout.txt' for instructions on connecting to the JupyterLab"
echo "If you don't see a line with =====  END OF INSTRUCTIONS  ===== , you job has not yet started. Try 'cat bout.txt' in a few seconds."
echo "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"

sbatch -A ${account} -p ${queue} -N ${nnodes} -n ${nnodes} -c 32 -J Jupyter --mem=32G -t ${walltime}  -o ./%x-%j.o -e ./%x-%j.e start_jlab.sh ${port} ${HOSTNAME} ${verbose}
