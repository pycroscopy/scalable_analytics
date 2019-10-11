# JupyterLab on the CADES SHPC Condo

**Suhas Somnath**<br>
Advanced Data and Workflow Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

10/3/2019

Please [get in touch](somnaths@ornl.gov) with me if you have any questions regarding this document

## Introduction
Please see general introduction [here](../README.md)

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

### Troubleshooting
**Cannot connect because the port is already in use**

Consider changing the port at which the Jupyter server is running via the ``-p`` flag and try running ``job_script.sh`` again.

## Other notes
Please see the parent [readme](../README.md) for notes on troubleshooting, accessing the server from outside the ORNL network, etc.