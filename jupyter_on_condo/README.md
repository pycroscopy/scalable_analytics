# JupyterLab on the CADES SHPC Condo

**Suhas Somnath**<br>
Advanced Data and Workflow Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

10/3/2019

## Introduction:
-   Python, R and Julia are three of the most popular languages for analyzing scientific data. 
    People generally use interactive notebooks via the now ubiquitous - 
    [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html) to 
    explore their data and develop codes. 
-   Data sizes are exploding in every scientific domain and people need far more computational 
    horsepower than that offered by their personal computers. High performance computing (HPC)
    clusters offer the computational horsepower necessary to deal with large datasets and
    computationally intensive tasks. However, HPCs typically only offer a command line interface
    (CLI) to access the resource. The CLI is at odds with the interface most commonly desired by
    data scientists - JupyterLab. 
-   This guide and the codes associated greatly simplify the process of **correctly** spinning
    up a JupyterLab [server](https://www.youtube.com/watch?v=HW29067qVWk) on the 
    [CADES Scalable HPC Condos](https://support.cades.ornl.gov/user-documentation/_book/condos/overview.html)

### Why an HPC and not a VM?
There is indeed a similar guide for deploying a 
[Jupyter Notebook server on a virtual machine](https://support.cades.ornl.gov/user-documentation/_book/user-contributed-tutorials/jupyter/python-analytics-server.html)
(VM) offered by the CADES Cloud. However, deploying JupyterLab on the CADES Condos offers
several benefits over deploying on the VM:

1. **More compute by default** - A single node of the CADES SHPC Condo offers far more 
   [computational power](https://support.cades.ornl.gov/user-documentation/_book/condos/hardware.html)
   than the default virtual machine (~ 8GB memory + 4 CPU cores) and even offers GPUs that can
   significantly accelerate deep learning workloads.
2. **Scalable computing** - As the name ("Scalable") suggests, you could easily take advantage of 
   more computational power.
3. **Access to file systems** - The SHPC Condos are connected by default to the network file system (NFS)
   and Lustre (scratch space) which are far larger and faster than what one has access to on the VMs.
4. **File transfer** - The filesystems also have 
   [Globus endpoints](https://support.cades.ornl.gov/user-documentation/_book/data-transfer-storage/globus-overview.html) 
   that make it very easy to move large (TBs, PBs and larger) datasets quickly and reliably.
5. **Cost and ethics** - The overwhelming majority of users who run Jupyter servers on VMs tend to use
   the VMs only 1% of the time. This results in needless wastage of resources that power the VMs. 
   VMs [cost](https://cloud.google.com/compute/pricing) a non-trivial amount of man-power and 
   [money](https://aws.amazon.com/ec2/pricing/on-demand/) to run after all. With the Condos, users
   can spin up a JupyterLab server for the few minutes or hours that they actually need it. 
   The resources are freed up for others to use at all other times. 
6. **Software modules** - The Condos have a very large list of optimized software modules for a variety
   of purposes, especially large-scale simulations.

### Other notes:
-   Using JupyterLab on the SHPC Condos does **NOT** automatically mean that your codes will run efficiently 
    and utilize all available horsepower that the cluster offers. Other packages are necessary to actually
    develop and run scalable code. Here are just a few:
    - Python users - [Dask](https://dask.org) and [mpi4py](https://mpi4py.readthedocs.io/en/stable/), etc.
    - R users - [pbdR](https://pbdr.org)
-   The CADES SHPC Condos run a [Linux](https://www.ubuntu.com/desktop) operating system and not windows. 
    You are recommended to take this [short tutorial](https://www.udacity.com/course/linux-command-line-basics--ud595) 
    if you are new to Linux and/or the [command line interface](https://help.ubuntu.com/community/UsingTheTerminal).
    CADES has several helpful guides on [learning the basics of Linux](http://support.cades.ornl.gov/user-documentation/_book/linux/linux-intro.html) as well.
-   This document is limited to the instructions necessary for spinning up a JupyterLab server for your own use.
    This does not extend to the multi-user [JupyterHub](https://github.com/jupyterhub/jupyterhub).
-   As of this writing, these instructions will not include access to R, Julia, C++, and Matlab kernels.

## Configuration
### 0: One-time setup:
1. [Request access](https://support.cades.ornl.gov/user-documentation/_book/condos/how-to-use/request-access.html)
   to the Condos
2. Prepare [prerequisites](https://support.cades.ornl.gov/user-documentation/_book/condos/how-to-use/prerequisites.html)
   on your personal / lab computer
3. [Log into](https://support.cades.ornl.gov/user-documentation/_book/condos/how-to-use/access-shpc.html)
   the Condos 
4. *OPTIONAL*: Consider joining the `#condo` channel on the [CADES SLACK group](cades@slack.com) to 
   communicate with other users of the CADES SHPC Condos.
5. Download the `job_script.sh` and `start_jlab.sh` scripts in this folder onto the Condo
   
### 1. Running the server
1. Log into the portion of the Condos that runs the SLURM scheduler via: ``ssh <uid>@or-slurm-login01.ornl.gov``
2. Run the scripts as:

   .. code:: bash

       bash job_script.sh -A <account name that you typically pass>

   Additional flags you can pass to this script:

   * ``-n`` <number of nodes>; optional; defaults to ``1``
   * ``-p`` <port number>; optional; defaults to ``5959``
   * ``-t`` <wall time>; optional; defaults to 30 minutes. ``1:00`` will request 1 hour for example
   * ``-v`` = prints more statements
    
3. Read the instructions file via:

   .. code:: bash

       cat bout.txt
       
4. Follow instructions to connect to the JupyterLab server

**Note:**

  Currently, the JupyterLab server will not require a password. However, it is recommended
  to configure a password for security.