#!/bin/bash

# Author: Suhas Somnath

module purge
module load PE-gnu

nnodes=1
queue='testing'
port=5959
walltime=0:30
account='ccsd'
verbose=1

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

echo "type 'cat Jupyter-<JOBNUMBER>.o to view the instructions"

sbatch -A ${account} -p ${queue} -N ${nnodes} -n ${nnodes} -c 32 -J Jupyter --mem=32G -t ${walltime}  -o ./%x-%j.o -e ./%x-%j.e start_jlab.sh ${port} ${HOSTNAME} ${verbose}