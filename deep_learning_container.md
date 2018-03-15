# Deep Learning on your VM

**Suhas Somnath**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences

10/9/2017

WHile it may be straightforward to install / configure popular analytics / visulization packages, it can be challenging to correctly install / configure deep learning frameworks like TensorFlow, MXNet etc. 
One could still manually install these frameworks via pip but such installation may not take full advantage of the hardware. 

The most popuar method for efficiently using these frameworks is by running inside a [Docker container](<https://www.docker.com/what-container>). Here are the steps that need to be followed to easily and efficiently get started with deep learning:
1. Follow the official [instructions to create a virtual machine](http://support.cades.ornl.gov/index.php/birthright-cloud/) on the CADES Birthright cloud
2. [Install Docker](http://support.cades.ornl.gov/user-documentation/_book/openstack/user-tutorials/docker/docker.html)
3. Pull the Docker image of choice. In this example, we will pull the [official TensorFlow container](https://hub.docker.com/r/tensorflow/tensorflow/) for CPUs:
    ```bash
    $ sudo docker pull tensorflow/tensorflow
    ```
    You can find containers for other deep learning frameworks on Docker too such as:
        
    * [MXNet](http://support.cades.ornl.gov/index.php/birthright-cloud/)
    * [Caffe2](https://hub.docker.com/r/caffe2ai/caffe2/)
    * [PyTorch](https://hub.docker.com/r/digitalgenius/ubuntu-pytorch/) etc.
4. Get your data from your local machine via SCP or SFTP. Please refer to [this guide](./sftp.md) for instructions. Let us assume that the data and code sits in a folder with absolute path: `/home/cades/deep_learning`
5. Run the container using the command below. 
    ```bash
    $ sudo docker run -it -p 8888:8888 -v /home/cades/deep_learning:/notebooks/my_data tensorflow/tensorflow
    ```
    * The `-i` flag requests the container to run in `interactive` mode
    * The `-p` flag forwards the `8888` port on the container to the `8888` port on your VM. You will need to connect the port on your VM to your local machine in a later step to access the jupyter notebook. 
    * The `-v` flag tells your container to mount your folder at `/home/cades/deep_learning` on your VM containing all your deep learning data + code to `/notebooks/my_data`. Note that absolute paths must be provided. The folder `my_data` will be clearly visible and accessible when you are on the jupyter server on your local machine's browser.
    * for more information and other options on running the container, type: 
    ```bash 
    $ sudo docker run --help
    ```
6. In this specific example, the container is set up to start a jupyter server on port `8888`. Do not close this terminal window. You can either note down the token number or copy paste the complete web address. You will need this on step 9.
    ```bash
        Copy/paste this URL into your browser when you connect for the first time,
        to login with a token:
            http://localhost:8888/?token=a-giant-alpha-numeric-string
    ```
7. On your local machine (laptop / desktop) - start an SSH tunnel via the following command on the Terminal. I've shown instructions for Linux / Mac here. For more instructions on this step + simplifications, please refer to my instructions on [setting up a python analytics VM](./python_analytics_server.md)
    ```
    $ ssh -N -L localhost:8888:localhost:8888 cades@ip-address-of-your-vm-here
    ```
8. Access the jupyter server running on your VM using your favorite internet browser (Internet explorer and Safari not recommended)- You can do this in one of two ways:

    * You can either copy paste the entire web address (http://localhost:8888/?token=a-giant-alpha-numeric-string from step 6) or 
    * OR go to: [http://localhost:8888](http://localhost:8888) and paste the token number (with the option of setting your own password). 
  
9. Once you are done working on the VM and want to shut down the container: 

    a. Use `Ctrl + C` twice to kill the jupyter server on your VM
    
    b. Check to make sure that your container has been killed via: 
    
    ```bash
    $ sudo docker container ls
    ```
    
    If you see something like:
        
    ```bash

    CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                                                  NAMES

    77e04f817e88        tensorflow/tensorflow   "/run_jupyter.sh -..."   2 minutes ago       Up 2 minutes        6006/tcp, 0.0.0.0:8888->8888/tcp   jovial_albattani
    ```
        
    Kill the container via: 
    ```bash
    $ sudo docker container kill 77e04f817e88
    ```
    
    c. You are now free to type `$ exit` to close your ssh connection to your VM
