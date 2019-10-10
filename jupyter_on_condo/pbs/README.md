# JupyterLab on the CADES SHPC Condo

**Suhas Somnath**<br>
Advanced Data and Workflow Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

10/10/2019

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

   ``ssh <uid>@or-condo-login.ornl.gov``
4. On the Condos, navigate to a desired directory and then download the script via the following command:
   
   ``wget https://raw.githubusercontent.com/pycroscopy/scalable_analytics/master/jupyter_on_condo/pbs/job_script.pbs``
   
5. Change the PBS flags in lines ``4`` to ``16`` in ``job_script.pbs`` to adjust the user group, email address, etc.
   
6. Set a password for your JupyterLab server via:

   1. First load the Anaconda module by typing: 
      
      ``module load anaconda3/5.1.0-pe3``
   
   2. Next, set and confirm a password of your choice after typing:
     
      ``jupyter notebook password``
      
7. *OPTIONAL*: [Install Dask Dashboard plugins](https://jobqueue.dask.org/en/latest/interactive.html#install-jupyterlab)
   so that the Dask Dashboard can be transmitted over the same port as that
   used by JupyterLab. This should save extra tunnelling:
   
   1. Install NodeJS (which we'll need to integrate Dask into JLab):
   
      ``conda install nodejs -c conda-forge -y``

   2. Install server-side pieces of the Dask-JupyterLab extension:

      ``pip install dask_labextension``

   3. Integrate ``Dask-Labextension`` with Jupyter (requires NodeJS)

      ``jupyter labextension install dask-labextension`` 
   
8. *OPTIONAL*: Consider joining the `#condo` channel on the [CADES SLACK group](cades@slack.com) to 
   communicate with other users of the CADES SHPC Condos.

   
### 2. Running the server
1. Run the scripts as:

   ``qsub job_script.pbs``
   
   You may want to set or reset the default values for how long the server should be up (30 mins), how many nodes to allocate (1 by default) by editing lines ``4`` to ``16`` in ``job_script.pbs``
    
2. Read the instructions file via:

   ``cat jupyter_instructions.txt``
   
   This file should present a few dozen lines of instructions. 
   If you do not see instructions on ssh etc., chances are that the scheduler has not 
   run this job just yet. Please wait for 30 seconds to a minute and try again.
       
3. Follow instructions provided in ``jupyter_instructions.txt`` to connect to the JupyterLab server from your personal computer.
   Note that you may need to log in with your password to the compute node in `Step 1`. 

### 3. Shutting down
1. To shut down JupyterLab (and this job), click on ``File`` in the top menu bar in JupyterLab 
   and select ``Shut Down``. Confirm and you are done. 
2. You will still need to press ``Ctrl``+``C`` in the terminal(s) you used to connect to the Condos login node form your personal computer

## Other notes
Please see the parent [readme](../README.md) for notes on troubleshooting, accessing the server from outside the ORNL network, etc.