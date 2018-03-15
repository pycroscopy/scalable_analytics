# Deep Learning on your VM

**Suhas Somnath**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences

10/9/2017

WHile it may be straightforward to install / configure popular analytics / visulization packages, it can be challenging to correctly install / configure deep learning frameworks like TensorFlow, MXNet etc. 
One could still manually install these frameworks via pip but such installation may not take full advantage of the hardware. 

The most popuar method for efficiently using these frameworks is by running inside a `Docker container <https://www.docker.com/what-container>`_. Here are the steps that need to be followed to easily and efficiently get started with deep learning:
1. Follow the standard instructions to create a virtual machine on the CADES Birthright cloud
2. `Install Docker <http://support.cades.ornl.gov/user-documentation/_book/openstack/user-tutorials/docker/docker.html>`_
3. Pull the Docker image of choice. In this example, we will pull the `official TensorFlow container <https://hub.docker.com/r/tensorflow/tensorflow/>`_ for CPUs:
```
$ sudo docker pull tensorflow/tensorflow
```
4. Run the container using the command below. 
```
$ sudo docker run -it -p 8888:8888 tensorflow/tensorflow
```
5. In this specific example, the container is set up to start a jupyter server on port 8888. Do not close this terminal window. You can either note down the token number or copy paste the complete web address. You will need this on step 7.
```
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=56c6fc44808e7ea290a08e0354186d285a6278e1ac459d43
```
6. On your local machine (laptop / desktop) - start an SSH tunnel via the following command on the Terminal. For more instructiosn on this step, please refer to my instructions on `setting up a python analytics VM <./python_analytics_server.md>`
```
$ ssh -N -L localhost:8888:localhost:8888 cades@ip-address-of-your-vm-here
```
7. Access the jupyter server running on your VM using your favorite internet browser (Internet explorer and Safari not recommended)- You can do this in one of two ways. 
  a. You can either copy paste the entire web address (http://localhost:8888/?token=a-giant-alpha-numeric-string from step 5) or 
  b. Go to: `http://localhost:8888 <http://localhost:8888>`_ and paste the token number (with the option of setting your own password). 
