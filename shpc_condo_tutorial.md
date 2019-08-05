
# Creating a PBS Script for SHPC Condo
**Emily Costa**
08/01/2019
***
This tutorial is meant to introduce a CADES user to creating a PBS script in order to submit and run jobs on the SHPC Condo at Oak Ridge National Laboratory. In order to properly complete this tutorial, please open JupyterLab in the Condo.

First, let's write some code to run on the cluster.We will be writing python and PBS scripts and creating new files to submit on the Condo.
***
The following is an example of how scripts can be written from a Jupyter Notebook:


```python
%%writefile hello_world.py
print("Hello world")
```

    Writing hello_world.py


Now, we are going to ***write a simple 'Hello World' program for MPI.***

Using mpi4py, find and print of the size, rank, and processor name.


```python
from mpi4py import MPI
import sys

# Your code

sys.stdout.write(
    "Hello, World! I am process %d of %d on %s.\n"
    % (rank, size, name))
```

Now **check your answer**. Make sure to run this cell after loading the answer, as we want to save the script to a new file.


```python
%load solutions/PBS_file00
```

Now that we have a basic Python script to run on the Condo, we need to create the PBS script. There are two main components to creating a PBS script:
1. Create and fill out flags for submitting the job.
2. Write script to prepare for and run your python script.

Let us begin.

## Flags for Submitting a Job on the Condo

The first part of the PBS script needs to contain all the flags needed to run your Python script. They will be written to the script in the following format:

> `#PBS -flag argument`
***

> `-N job_name`, set the job name. Your output files will share this name.

> `-M email_address`, errors will be emailed to this address.

> `-l nodes=##:ppn=##`, node specs (number of node:processors per node)

> `-l walltime=D:HH:MM:SS`, anticipated runtime for the job

> `-W group_list=LDAP_group_list`, ex. cades-birthright.

> `-A account_type`, ex. birthright.

> `-l qos=quality_of_service`, ex. burst or std.

## Write Main Program of PBS Script

> `module purge`, remove old modules to ensure a clean slate.

> `module load ...` or `source /path/to/script`, load modules to set up your programming environment.

> `script_path /path/to/files` or `data_path /path/to/data`, set paths that are needed to copy scripts or data to current path. This is optional and only if the files are not in your current directory. For the hello_world example, we will not need to set paths.

> `cp $script_path/script .` or `cp $data_path/data .`, copy the need scripts and data to your current directory. Again, this is not necessary if what you need is already there.

> `mpirun ... python ...` or `mpiexec ... python ...`, run the Python script.

> Done!

Now, let us create a PBS file to run our "Hello World" python script. You will need to fill out the flags with your information.


```python
%%writefile hello_world.pbs
#!/bin/bash

#PBS -N HelloWorld
#PBS -M your_email@ornl.gov
#PBS -l nodes=1:ppn=4
#PBS -l walltime=0:00:01:00
#PBS -W group_list=cades-birthright
#PBS -A birthright
#PBS -l qos=burst

module purge

module load python/3.6.3

mpiexec --map-by ppr:1:node python hello_world_mpi.py
```

Finally, we want to submit the job. In the same directory as your PBS and Python scripts, run the following Linux command:

> `qsub hello_world.pbs`

The following are useful qsub arguments:

> `checkjob job_number`, check status of jobs.

> `qdel job_number`, cancel pending job.

> `more job_name.ojob_number`, contains the results of the executed binary.

> `more job_name.ejob_number`, contains any errors that occurred during execution.

For more information:

https://cades.ornl.gov/service-suite/scalable-hpc/
