JupyterLab on Rhea
==================
**Note**:

    This is NOT official OLCF documentation

We provide a set of scripts that simplify the process of running a JupyterLab server
on one or more compute nodes on Rhea.

**Note:**

    JupyterLab itself does not facilitate any existing code to scale on a cluster.
    You will need to use tools such as Dask, mpi4py, TensorFlow, pyTorch etc. to
    effectively use more than one node.

When they are run, the scripts will take care of getting an allocation from the scheduler and
spin up the Jupyter server on a compute node correctly.

The scripts will provide instructions for connecting the JupyterLab server
to a browser running on a personal computer using SSH tunnels


Instructions
------------
1. Download the ``job_script.sh`` and ``start_jlab.sh`` files in this folder onto Rhea
2. Set a password for the Notebook server:

   a. Load the Anaconda module first via:

      .. code:: bash

        module load python/3.7.0-anaconda3-2018.12

   b. Set the password by entering and re-entering the password upon executing this line:

      .. code:: bash

         jupyter notebook password

2. Set / reset the default values for the flags in lines ``6`` to ``11`` in ``job_script.sh``
3. Start the scripts as:

   .. code:: bash

       bash .sh -A <account name that you typically pass to sbatch or srun>

   Additional flags you can pass to this script:

   * ``-N`` <number of nodes>; optional; defaults to ``1``
   * ``-p`` <port number>; optional; defaults to ``8887``
   * ``-t`` <wall time>; optional; defaults to 30 minutes
   * ``-v`` = prints more statements

   **Note:**

      The ``start_jlab.sh`` script will provision an entire node of Rhea
      for the Jupyter server. Feel free to edit the ``sbatach`` command in ``job_script.sh`` to change this.
4. View and follow the instructions for creating the tunnels via:

   ``cat bout.txt``

**Note:**

  Currently, the communications between the JupyterLab server and the browser are not encrypted.
  However, it is recommended to fortify communications.