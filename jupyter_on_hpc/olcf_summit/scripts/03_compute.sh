# This script will run on ALL ranks on all compute nodes:

# Authors: Shuto Araki, Suhas Somnath, Junqi Yin
# Arguments: Port number to run the Jupyter server

# First load the appropriate module that contains anaconda
module load python/3.7.0-anaconda3-5.3.0

# Run the jupyter lab ONLY on MPI Rank 0:
if [ $PMIX_RANK -eq 0 ]
then
  start-jupyter.sh $1
fi