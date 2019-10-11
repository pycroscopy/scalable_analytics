JupyterLab on Summit
====================
**Note**:

    This is NOT official OLCF documentation

We provide a set of `scripts <./scripts/>`_ that simplify the process of running a JupyterLab server
on one or more compute nodes on Summit. 

**Note:**

    JupyterLab itself does not facilitate any existing code to scale on a cluster.
    You will need to use tools such as Dask, mpi4py, TensorFlow, pyTorch etc. to 
    effectively use more than one node.

When they are run, the scripts will take care of getting an allocation from the scheduler and
spin up the Jupyter server on a compute node correctly via ``jsrun``.

The scripts will provide instructions for connecting the JupyterLab server
to a browser running on a personal computer using two SSH tunnels as shown below:

.. image:: ./Tunnelling.png


Instructions
------------
1. Download all the files in the ``scripts`` onto Summit
2. Start the scripts as:

   .. code:: bash

       bash 01_login.sh -A <account name that you typically pass via the -P flag to bsub>

   Additional flags you can pass to this script:

   * ``-N`` <number of nodes>; optional; defaults to ``1``
   * ``-p`` <port number>; optional; defaults to ``8887``
   * ``-t`` <wall time>; optional; defaults to 30 minutes
   * ``-v`` = prints more statements

   **Note:**

      The ``jsrun`` command in `02_batch.sh <./scripts/02_batch.sh>`_ will provision an entire
      Summit node for the Jupyter server. Feel free to edit the ``jsrun`` command to change this.
    
3. Follow the resultant instructions

**Note:**

  Currently, the JupyterLab server will not require a password. However, it is recommended
  to configure a password for security.