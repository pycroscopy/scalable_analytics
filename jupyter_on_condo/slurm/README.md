# JupyterLab on the CADES SHPC Condo

**Suhas Somnath**<br>
Advanced Data and Workflow Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

10/3/2019

Please [get in touch](somnaths@ornl.gov) with me if you have any questions regarding this document

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
   than the **default** virtual machine (~ 8GB memory + 4 CPU cores) and even offers GPUs that can
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
### 1: One-time setup:
1. [Request access](https://support.cades.ornl.gov/user-documentation/_book/condos/how-to-use/request-access.html)
   to the Condos
2. Prepare [prerequisites](https://support.cades.ornl.gov/user-documentation/_book/condos/how-to-use/prerequisites.html)
   on your personal / lab computer
3. Log into the Condos via:

   ``ssh <uid>@or-slurm-login01.ornl.gov``
4. On the Condos, navigate to a desired directory and then download two scripts via the following commands:
   
   ``wget https://raw.githubusercontent.com/pycroscopy/scalable_analytics/master/jupyter_on_condo/slurm/job_script.sh``
   
   and
   
   ``wget https://raw.githubusercontent.com/pycroscopy/scalable_analytics/master/jupyter_on_condo/slurm/start_jlab.sh``
   
5. Set a password for your JupyterLab server via:

   1. First load the Anaconda module by typing: 
      
      ``module load anaconda3/5.1.0-pe3``
   
   2. Next, set and confirm a password of your choice after typing:
     
      ``jupyter notebook password``
      
5. *OPTIONAL*: [Install Dask Dashboard plugins](https://jobqueue.dask.org/en/latest/interactive.html#install-jupyterlab)
   so that the Dask Dashboard can be transmitted over the same port as that
   used by JupyterLab. This should save extra tunnelling:
   
   1. Install NodeJS (which we'll need to integrate Dask into JLab):
   
      ``conda install nodejs -c conda-forge -y``

   2. Install server-side pieces of the Dask-JupyterLab extension:

      ``pip install dask_labextension``

   3. Integrate ``Dask-Labextension`` with Jupyter (requires NodeJS)

      ``jupyter labextension install dask-labextension`` 
   
6. *OPTIONAL*: Consider joining the `#condo` channel on the [CADES SLACK group](cades@slack.com) to 
   communicate with other users of the CADES SHPC Condos.

   
### 2. Running the server
1. Run the scripts as:

   ``bash job_script.sh -A <account name that you typically pass - e.g. - ccsd, cnms, birthright, etc.>``

   For the ``-A`` flag: check to see if 
   [your division owns](https://support.cades.ornl.gov/user-documentation/_book/condos/how-to-use/request-access.html) 
   resources in Condos that you could access. Otherwise, you could use ``-A birthright``.
   
   Additional flags you can pass to this script:

   * ``-n`` <number of nodes>; optional; defaults to ``1``
   * ``-p`` <port number>; optional; defaults to ``5959``
   * ``-t`` <wall time>; optional; defaults to 30 minutes. ``1:00:00`` will request 1 hour for example
   * ``-v`` = prints more statements
   
   You may want to set or reset the default values (e.g. the account) for the flags by editing lines ``6`` to ``11`` in ``job_script.sh``
    
2. Read the instructions file via:

   ``cat bout.txt``
   
   This file should present a few dozen lines of instructions. 
   If you do not see instructions on ssh etc., chances are that the scheduler has not 
   run this job just yet. Please wait for 30 seconds to a minute and try again.
       
3. Follow instructions provided in ``bout.txt`` to connect to the JupyterLab server from your personal computer.
   Note that you may need to log in with your password to the compute node in `Step 1`. 

### 3. Shutting down
1. To shut down JupyterLab (and this job), click on ``File`` in the top menu bar in JupyterLab 
   and select ``Shut Down``. Confirm and you are done. 
2. You will still need to press ``Ctrl``+``C`` in the terminal(s) you used to connect to the Condos login node form your personal computer

### Allocation Consumption
Running such a JupyterLab server on the compute node(s) **does** consume your CADES Condos allocation.
In other words, your division will be charged the typical rate as you run the JupyterLab server.
Therefore, please use such a deployment judiciously. Use it to crunch numbers
rather than using it like a text editor. Consider shutting down the server if you are not actively using it. 
It is perhaps the best practice to
do interactive development work on a local jupyter instance and then run a
dedicated python script in a batch job to make the most efficient use of your
allocation.

### Troubleshooting
**Cannot connect because the port is already in use**

Consider changing the port at which the Jupyter server is running via the ``-p`` flag and try running ``job_script.sh`` again.

**A message on JupyterLab on the browser asks you to use a different workspace**

This message appear on the browser if there is another instance of the JupyterLab running on another tab on the browser.
Consider trying a different workspace name to enter the JupyterLab interface. If that does not work, you may have to
close the other tabs running JupyterLab. 
Typically, one sees this message only if the JupyerLab servers on the other browser tabs are running on the same port.

**Login password is rejected even though it is entered correctly**

This is a symptom of multiple users attempting to access different servers
through the same login node and port number. The connection will succeed
but the password will be rejected because the server you are accessing is
someone else's. 

### Accessing outside the ORNL network
If you are outside the ORNL network, you would need to tunnel a little differently:
 
1. Follow `step 1` of the instructions from ``bout.txt`` *as is* to make the tunnel
   between the SHPC login node and the compute node where JupyterLab is running.
   It should look something like:
   
   ``ssh -N -L <port>:localhost:<port> <name of compute node>``

2. `Step 2` of the instructions in ``bout.txt`` will be replaced by two steps.
    Open a new terminal on your personal computer. 
    Establish a tunnel from your personal computer to the CADES External Login node via:

   ``ssh -N -L localhost:<port>:localhost:<port> <userid>@cades-extlogin1.ornl.gov``

3. Finally, open a new terminal on your personal computer. 

   1. Log into the CADES External Login node via:
   
      ``ssh <userid>@cades-extlogin1.ornl.gov``
   
   2. Now, establish a tunnel between this CADES External Login node and the CADES SHPC Condos' login node via:
   
      ``ssh -N -L localhost:<port>:localhost:<port> <userid>@or-slurm-login01.ornl.gov``

4. Proceed to `Step 3` and `Step 4` of the instructions from ``bout.txt``, which remain unchanged.

### Server Uptime
Depending on the requested wall-time via the ``-t`` flag and the maximum time allowed by the queue,
the jupyter server will be killed at least once the job expires (30 mins by default), so you will want to **make sure
your work is saved often**. 

You can add a flag to the ``sbatch`` command at the end of `job_script.sh`` 
to resubmit the job automatically to keep a server up like:

``--dependency=afternotok:$SLURM_JOB_ID keep_server_up.slurm``

Note that you will still need to re-establish the tunnel each time it goes down.
This is something that has not yet been tested.

**Note:**

  Currently, the setup above does not encrypt communications between the Condo and JupyterLab.