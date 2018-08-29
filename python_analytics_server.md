# Setting up a Python Analytics Server

**Suhas Somnath**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

10/9/2017

## Table of contents:
- [Introduction](#introduction)
	- [Support](#support)
	- [Best practices](#best-practices-and-ethical-use-of-the-cloud)
	- [Other notes](#other-notes)
0. [Getting a CADES Birthright account](#step-0-getting-a-cades-birthright-account)
1. [Creating and Launching an instance](#step-1-creating-and-launching-an-instance)
2. [Accessing the Instance](#step-2-accessing-the-instance)
	- Everyone - Get the IP address
	- Everyone - Get the public key
	- [ORNL Mac / Linux computers only](#1-ornl-mac--linux-computer)
	- [ORNL Windows computers only](#2-ornl-windows-computer)
	- [Personal computers](#3-from-your-personal-computer)
3. [Installing analytics packages on the instance](#step-3-installing-analytics-packages-on-the-instance)
4. [Starting the Jupyter server](#step-4-starting-a-jupyter-server)
5. [Accessing the Jupyter server](#step-5-accessing-the-jupyter-server)
	- [Mac / Linux](#mac--linux)
	- [Windows](#windows)
	- [Personal computers](#personal-computer)
6. [Shutting down the Jupyter server](#step-6-shutting-down-the-jupyter-server)

## Introduction:
-   R and python are two of the most popular languages for analyzing scientific data. However, it can be challenging for first-time users to set up these familiar languages on cloud computing resources for data analytics.
-   These self-service instructions will guide you through the process of creating a `virtual machine` (VM) on the [CADES Cloud](https://cades.ornl.gov/service-suite/cades-cloud/) cloud (comparable to a powerful desktop computer and scalable) that you could use instead of your personal computer for data analysis via a [Jupyter](http://jupyter.org) notebook [server](https://www.youtube.com/watch?v=HW29067qVWk).
-   The entire setup process (besides step 0) should take about 20 minutes. Once set up, connecting to the notebook server should only take a few button clicks.

### Support:
-   CADES provides the ability and support to create and use virtual machines. Users are free to use such VMs for a variety of purposes, such as running a Jupyter notebook server. **Users are responsible for maintaining the software installed on their own VMs** (e.g. - python packages, Jupyter server, etc.).
-   Please follow all steps in this guide to ensure a smooth setup of your analytics VM. For questions regarding the virtual machine itself (steps 0-2), please [contact CADES support](cades-help@ornl.gov). If you have any questions regarding the setup of anaconda, Jupyter, etc. (steps 3-6) please feel free to [contact me](somnaths@ornl.gov).

### Best Practices and ethical use of the cloud:
A virtual machine is like a public-use desktop or a laptop. It [costs](https://cloud.google.com/compute/pricing) [money](https://aws.amazon.com/ec2/pricing/on-demand/) to run VMs and reserving resources for your VM, precludes others from utilizing resources. Here are a few guidelines for using and managing VMs:
* If you are not using the VM for extended periods or are not using all the horsepower, consider resizing to a smaller flavor (fewer CPU cores and smaller RAM). Remember that you can always resize it back to something bigger whenever necessary. 
* Additionally, you can shut down your VM, just like you would shut down your personal computer
* Consider deleting VMs you will never use again 

### Other notes:
-   The remote machine runs the [Ubuntu](https://www.ubuntu.com/desktop) (Linux) operating system. You are recommended to take this [short tutorial](https://www.udacity.com/course/linux-command-line-basics--ud595) if you are new to Linux and/or the [command line interface](https://help.ubuntu.com/community/UsingTheTerminal).
- CADES has several helpful guides on [learning the basics of Linux](http://support.cades.ornl.gov/user-documentation/_book/linux/linux-intro.html) as well.
-   This document is limited to the instructions necessary for setting up a virtual machine for data analytics using python and is not intended to serve as a comprehensive manual for maintaining and administering your virtual Linux machine or implementing other advanced analytics features such as [JupyterHub](https://github.com/jupyterhub/jupyterhub). Please refer to other online resources for such topics.
-   Though you can set up a [VM for analytics using R](http://support.cades.ornl.gov/user-documentation/_book/openstack/user-tutorials/shiny/shiny.html), this is **NOT extendable to Matlab** and similar proprietary / paid software packages.
-   This virtual machine will be only be accessible within the ORNL network. You would need to use the VPN on an ORNL laptop when off campus or access the machine via Citrix on your personal computer.
-   Many thanks to the Chris Layton, Pete Eby, Ketan Maheshwari from CADES and Ondrej Dyck from CNMS.

## Step 0: Getting a CADES Birthright account:
1.  You will need to request for access to the CADES Birthright Cloud from the following the [instructions here](http://support.cades.ornl.gov/user-documentation/_book/openstack/start/request-cloud-allocation.html). You should receive a mail within a few minutes to 1-2 hours regarding the approval of your request.
2.  *OPTIONAL*: By default, everyone has access to virtual machines that have up to 8 GB of memory and 16 CPU cores. If you need more, you can request to have your quotas increased by [sending an email to CADES](cades-help@ornl.gov) including details such as your three character `UCAMS id`, justification, and duration for the increase in quota in the email.
3.  *OPTIONAL*: Consider joining the `#ornl_cloud` channel on the [CADES SLACK group](cades@slack.com) to communicate with other users of the CADES cloud.

## Step 1: Creating and Launching an instance:

You can follow the four steps in CADES’ documentation in the links below but pay attention to my notes:

1. `Log in to Horizon, name your VM` - follow the instructions on [this page](http://support.cades.ornl.gov/user-documentation/_book/openstack/create-vm/launch-vm-start.html) as is.
2. `Choose a flavor, image, and boot source` - follow [instructions here](http://support.cades.ornl.gov/user-documentation/_book/openstack/create-vm/launch-vm-configure.html) but pay attention to a few things:
	1. At the ``Source Tab``: 
	![](media/python_analytics_server/image002.png)
		1. ``Delete Volume on Instance Delete``: Set to No if you want to drive to be kept alive even though the instance is deleted. This is generally a good idea - you can always delete the volume (in addition to the instance) if you don't need it.
		2. ``Volume Size``: This is the size of the storage drive that will contain the operating system, data, python packages etc. You are recommended to set this to `16 GB` or larger. If you intend to use your birthright account exclusively for this analytics server, you can use up your entire quota (eg. 40 GB). Like any personal computer, you can always add volumes to your instance but starting off with a large enough volume can mitigate additional work. Please [see this document](./mount_drive.md) if you already created an instance but need to add a new storage volume.
	2. At the ``Flavor Tab``: This mainly determines the number of processor cores and memory. **You can change the flavor after creating the instance** so do not worry about this step very much. Pick the flavor that best suits your applications:
	      - Pick any flavor that begins with `m1.` if you do a lot of statistical analysis that requires a large RAM compared to the number of CPU cores
	      - Pick any flavor beginning with `c1.` if you tend to run a lot of small computations in parallel.
	      - For additional flavors request CADES to increase your quota. See Step 0.
	      - You can always run multiple machines in parallel. So you could distribute your memory / CPUs among two machines that fully utilize your quota.
3. [Set up a security group](http://support.cades.ornl.gov/user-documentation/_book/openstack/create-vm/launch-vm-security.html) as it says in the document
4. [Configure a key pair for accessing the VM](http://support.cades.ornl.gov/user-documentation/_book/openstack/create-vm/launch-vm-keys.html) as it says in the document

## Step 2: Accessing the Instance:

The instructions below are a simplification of the official CADES documentation:
* For [Mac / Linux](http://support.cades.ornl.gov/user-documentation/_book/openstack/access-vm/access-vm-ssh.html)
* For [Windows](http://support.cades.ornl.gov/user-documentation/_book/openstack/access-vm/access-vm-ssh-windows.html)

#### 1. Find the IP address of your machine.
1.  While in the `Horizon` interface you used for creating the instance to your VM, Click on the `Compute` tab, then the `Instances` sub-tab
2.  Copy the `IP address` listed for your instance
    ![](media/python_analytics_server/image001.png)

#### 2.  Get the public ssh key:
1.  Click on the `Access and Security` tab and then navigate to `Key Pairs`.
    ![](media/python_analytics_server/image003.png)
2.  Click on the key. In this case – CADESBirthrightKey
3.  Copy the contents of `Public Key` and paste into a text editor like `TextEdit` on MacOS or `Notepad` in Windows. **Read the next step before saving**:
    ![](media/python_analytics_server/image005.png)
4.  Before saving, make sure to change the format to `plain text`. This is especially true of `TextEdit` in Mac (in the Menu bar - Go to `Format` -> `Make Plain Text`) `Wordpad` (when saving, select `Text Document (.txt)` instead of the default `Rich text` in the pull down menu) in Windows for example.
5.  Save the file as `id_rsa.pub`

From here on follow instructions specific to your operating system:

### 1. ORNL Mac / Linux computer:

Before you begin: These instructions are for **ORNL computers only**. Instructions for personal computers will follow. If you are outside the ORNL network but working on an ORNL computer, you will need to connect to the ORNL VPN using your PIN and RSA token to get back into the network

#### 1. Moving the keys:
1. *OPTIONAL but Recommended*: If you are interested in accessing your instance from your personal computer, you are recommended to make a copy of your public and private keys and place the copies someplace on ``ORNLDATA`` (e.g. - My Documents). 
2.  Open the ``Terminal`` application and navigate to the directory where you stored your private key. 
3. Rename your private key from the original name (for example - CADESBirthrightKey) by typing:
```bash
$ mv CADESBirthrightKey id_rsa
```
4.  Move the private and public keys to `~/.ssh/`. For example, if you stored both the private and public keys in Documents.
```bash
$ cd Documents
$ mv id_rsa ~/.ssh/id_rsa
$ mv id_rsa.pub ~/.ssh/id_rsa.pub
```

#### 2. *OPTIONAL*: Shortcuts!

##### Aliases:
You can [set up aliases](./ssh_alias.md) that make it easier to refer to your remote machine. Aliases can turn commands like:
```bash
ssh cades@172.22.3.50
```
to:
```bash
ssh jupyterVM
```

##### Graphical interface for SSH:
The Mac `Terminal` application comes with utilities that simplify the ssh process with a graphical interface. If you are comfortable with the command line and do not mind typing `ssh` / `sftp` commands you can skip this step. 

If you are interested in this quick setup, follow the instructions [here](./mac_ssh_gui.md). Please only follow instructions till step 6 (set up the entries and do not follow any steps including and following those that expect you to click on the `Connect` button. We will get to this in `Step 4` below)

#### 3. Connecting to the instance
* Via the command line interface on the Terminal app:
```bash
ssh cades@172.22.3.50
```
* Via the graphical interface of the Mac Terminal app:
  1. Open the `Terminal` app.
  2.  Go to `Shell` → `New Remote Connection`
  3.  Ensure that `Secure Shell (ssh)` is selected on the left-hand column, then select the first entry you made (`cades@172.22.3.50` in my case) in the right-hand column, and click on the `Connect` button in the bottom right.

### 2. ORNL Windows computer:

Before you begin: These instructions are for **ORNL computers only**. Instructions for personal computers will follow. If you are outside the ORNL network but working on an ORNL computer, you will need to connect to the ORNL VPN using your PIN and RSA token to get back into the network. 

1. Install Putty
If you don’t have PuTTY installed, install it via the following links:
* [64 bit](https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe) (most computers)
* [32 bit](https://the.earth.li/~sgtatham/putty/latest/w32/putty.exe) (rare situations)
3. *OPTIONAL but Recommended*: If you are interested in accessing your instance from your personal computer, you are recommended to make a copy of your public and private keys and place the copies some place on ``ORNLDATA``. 
4. Configure PuTTY to connect to your instance:
	- Go to [CADES' instructions](http://support.cades.ornl.gov/user-documentation/_book/openstack/access-vm/access-vm-ssh-windows.html#connect-to-your-vm-instance-using-putty) 
	- Follow instructions starting from `Connect to Your VM Instance Using PuTTY` but **before clicking on the Open button to connect to your VM**, follow the step below
	- Type a name like `JupyterVM` and click on the Save button so that you don’t need to perform the setup procedure repeatedly. This name need not match the name on Horizon.
	  ![](media/python_analytics_server/image025.png)
5. Configure the tunneling to connect to the Jupyter notebook server by following the [instructions here](./tunnelling_remote_server.md#win-setup)

### 3. From your personal computer:
1. Log in via the [citrix page](https://gocitrix.ornl.gov/)
2. `PuTTY` setup:
	1. Select the `ORNL General Desktop` application
	2. Follow steps 2 and 3 in the instructions laid out for ORNL Windows computers above. 
3. You can access your VM through at least two routes:
	- *RECOMMENDED*:In Citrix, select the `PuTTY` application and use it as you would use an ORNL computer.
	- In Citrix, select the `ORNL General Desktop` application and use the `PuTTY` application to access your VM. This may be slow (bandwidth wasted on transporting the bits of the Windows machine) and tedious (you cannot forward the Jupyter notebook server to your personal computer - it would stay within the virtual Windows machine)
	 
## Step 3: Installing analytics packages on the instance:
1. Download [Anaconda](https://www.anaconda.com/download/) 5.2 -&gt; python 3.6. You can download a different version if you wish.

  ```bash
  $ mkdir temp
  $ curl https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh > temp/Anaconda3-4.2.0-Linux-x86_64.sh
  ```

2. Change privileges before installing Anaconda

  ```bash
  $ chmod +x temp/Anaconda3-4.2.0-Linux-x86_64.sh
  ```

3. Install Anaconda:
    1. Start the installer
        ```bash
		$ bash temp/Anaconda3-4.2.0-Linux-x86_64.sh
	    ```
    2. Follow the prompts to install Anaconda. Accept the license, say yes to installing to the default location, say yes to prepending anaconda to the path.
    3. Delete temporary installation folder:
        ```bash
        $ rm -r temp
        ```
4. Switch to anaconda environment:
	```bash
	$ source ~/.bashrc
	```
5. Install missing packages for wholesome Jupyter functionality:
	  
    1. Enable ability to export to pdf in Jupyter:
        ```bash
	    $ conda install -c anaconda-nb-extensions nbbrowserpdf
        ```

	2. Enable javascript for interactive elements in Jupyter:
	    ```bash
        $ jupyter nbextension enable --py --sys-prefix widgetsnbextension
        ```

6. *OPTIONAL:* To simplify the command to start up the Jupyter notebook:

	1. First create the configuration file:
    ```bash
    $ jupyter notebook --generate-config
    ```

	2. open up the notebook:
    ```bash
    $ nano ~/.jupyter/jupyter_notebook_config.py
    ```

	3. Use the key combination `Ctrl+W` to search for `.open_browswer`
	4. uncomment the line
	5. set the flag to `False`
	6. search for `NotebookApp.port = 8888` using `Ctrl+W`
	7. uncomment the line
	8. set the `port` number to `8889` (or any number &gt; 1024 for that matter)
	9. Close the editor with `Ctrl+X`
	10. Save the file

7. *OPTIONAL* - You can always install any python packages from this point on. You could install deep-learning frameworks like Keras or TensorFlow but you are recommended to use optimized Docker containers for this. Please refer to [this separate tutorial](./deep_learning_container.md) for this.

## Step 4: Starting a Jupyter server:

1. Ensure that you don’t leave room for accidental damage to the rest of the VM (such as the anaconda folder etc.) by starting the jupyter notebook in a new / separate folder. Perhaps this folder contains data + notebooks etc. For now, we will make an empty folder and start the notebook from there:
  ```bash
  $ mkdir workspace
  $ cd workspace
  ```
2. *OPTIONAL:* – **Persistent Jupyter server**: As it stands, if you close this ssh session, your command or operation (for example, a running jupyer server) will be aborted as well. In order to keep the jupyter server easily accessible, we will need to either use the [`screen`](http://dasunhegoda.com/unix-screen-command/263/) or the [`tmux`](https://robots.thoughtbot.com/a-tmux-crash-course) commands. We will be using [screen](https://uisapp2.iu.edu/confluence-prd/pages/viewpage.action?pageId=115540034) here. Note that this approach does **not** keep your *ssh connection to the jupyter server* (discussed in the next step) alive if your local computer goes to sleep or is shut down. IF you need your computation / analysis to run even after you shut down your local machine, you are recommend to run your analysis as a script on the remote machine instead of using the jupyter interface. If you decide to use `screen`, type the following command **BEFORE** you initiate the Jupyter server:
  ```bash
  $ screen
  ```

3. Starting the Jupyter server:
  * If you modified the configuration file that was optional in the previous step:
    ```bash
    $ jupyter notebook
    ```

  * If you did NOT follow the optional instructions, specify the port and no-browser flags
    ```bash
    $ jupyter notebook --no-browser --port=8889
    ```

4. *OPTIONAL*: If you ran the notebook with screen:
  1. you can now `detach` the screen using the following key sequence:
    ```bash
    Ctrl+A Ctrl+d
    ```

  2. You can now close the ssh session to the remote machine. This will NOT close your jupyter server.
    ```bash
    $ exit
    ```

## Step 5: Accessing the Jupyter server:

### Mac / Linux:
Connection in the Mac Terminal app:
1. Open the Terminal
2. Depending on which method you prefer (and have set up):
    - Command line interface:
      ```bash
      $ ssh -N -L localhost:8889:localhost:8889 cades@172.22.3.50
      ```

    - Graphical Interface: see [this document](./tunnelling_remote_server.md#mac-access) again

3. Open a browser (Chrome recommended for interactive widgets) and go to: <http://localhost:8889/>

### Windows:
1.  Close any open Putty connections to the VM
2.  Open Putty, load the configurations for your machine and connect. You will be presented with a new SSH connection to the VM. You can close this if you do not need it.
3.  Open a browser (Chrome recommended for interactive widgets) and go to: <http://localhost:8889/>

### Personal computer:
1. Log in via the [citrix page](https://gocitrix.ornl.gov/)
2. Select the `PuTTY` application 
3. Follow the same instructions for Windows computers.

## Step 6: Shutting down the Jupyter server:
Once you are done working on your jupyer server, you will need to:
*  If you used `screen` and closed your ssh connection to
    your virtual machine where you initiated the Jupyter server: ssh
    into your virtual machine:
    1.  Windows – use your saved putty profile
    2.  Mac / Linux: Use either the command line or graphical interface described in Step 2. For the command line interface - open the terminal and replace with your IP address:

      ```bash
      $ ssh cades@172.22.3.50
      ```

At this point, you should either have access to an existing ssh connection to the remote machine or you should have created a new connection in the preceding step.

*  If you used `screen`, re-attach the screen where your jupyer notebook server is running by typing:

    ```bash
    $ screen –r
    ```

You should be seeing the print logs of the Jupyter server on the remote machine now.

*  Press `Ctrl+C` twice to shut down the Jupyter server as you normally would on your local machine
