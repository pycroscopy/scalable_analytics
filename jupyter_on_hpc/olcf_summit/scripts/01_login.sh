# Authors: Shuto Araki, Suhas Somnath

# This script will be executed at the login node
# All it does is get an allocation from the scheduler

nnodes=1
port=8887
walltime=0:30
account=''
verbose=0

print_usage() {
  printf "Usage: \nscript_name -A <account to charge to; equivalent to LSF's -P> <optional flags - see below>\n"
  printf "-N <number of nodes>; optional; defaults to 1\n"
  printf "-p <port number>; optional; defaults to 8887\n"
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

echo -e "\n" > bout.txt
echo "Waiting for the job to start..." >> bout.txt

# Resume regular operations:
if [[ $verbose -eq 1 ]]; then 
   echo "You will get an email when the job starts." >> bout.txt
   echo "bsub command will be submitted with the following arguments: -P ${account} -J jupyterlab -W ${walltime} -nnodes ${nnodes} -alloc_flags nvme -B -N" >> bout.txt
fi

bsub -P ${account} -J jupyterlab -W ${walltime} -nnodes ${nnodes} -alloc_flags nvme -B -N "./02_batch.sh ${port} $(hostname) ${nnodes} ${verbose}" 

tail -f bout.txt