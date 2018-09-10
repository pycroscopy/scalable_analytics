# Quick guide to Nvidia DGX machines

**Suhas Somnath**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

1/9/2018

## What are DGX machines?
These are high performance computers designed for developing and deploying deep-learning networks using multiple state-of-art Nvidia Volta V100 GPUs. These machines come in the [desktop](https://www.nvidia.com/en-us/data-center/dgx-station/) and [server](https://www.nvidia.com/en-us/data-center/dgx-1/) flavors with 4 and 8/16 GPUs respectively.

## Accessing these DGX machines
These machines will rarely be physically accessible at ORNL and you will need to **access these machines remotely** via SSH, SCP, SFTP. [Tutorials on accessing and using virtual machines](./README.md) are already available and you can use those to learn the basics for accessing the DGX machines.

You will be accessing the machine via ssh as:
```bash
$ ssh user_id@dgx-dl01.ornl.gov
```
You will need to:
- Replace the `user_id` with your 3 character `UCAMS` ID.
- Ask the system administrator for the exact IP address of the machine you have access to

## Docker Images and Containers
The preferred method of using these DGX machines is through the use of [Docker containers](https://www.docker.com/resources/what-container). The concept of containers is perhaps the biggest new topic to [familiarize oneself](https://docker-curriculum.com) in. As their name implies, these containers contain the necessary software (configured in the most appropriate manner) for a particular application. Consequently, the burden of installing software and drivers is lifted off the end-users (yourself). In general, one can create Docker images easily however, the deep learning containers are [provided by Nvidia](https://hub.docker.com/r/nvidia/) directly with all necessary optimizations to make best of their hardware.

`Images` are the binary files that contain the software stack for the desired application. One-use `Containers` are manifestations of the `Images` that are created by Docker in order for the user to actually use the software of interest. For simplicity, think of `Images` as the recipe and `Containers` as something like a another 'virtual computer' you go into to use the desired application (e.g. - TensorFlow). This temporary 'computer' is deleted once you exit out of the container.

### Seeing the available images
If you are not the first person to use this machine, there is a good chance that someone has already downloaded or `pull`ed the image for the application you desire. First, check if the image you need is already on the machine:
```bash
$ sudo nvidia-docker image ls
```
You may see something like:
```bash
REPOSITORY                    TAG                     IMAGE ID            CREATED             SIZE
nvidia/cuda                   8.0-devel-ubuntu16.04   a3a91ecb5688        4 weeks ago         1.69GB
nvidia/cuda                   9.2-devel-ubuntu16.04   82c2f434d506        2 months ago        2.25GB
nvidia/cuda                   9.0-devel-ubuntu16.04   943880547a6a        2 months ago        1.95GB
image-dash-tf-jn-keras        latest                  265ae09e4871        2 months ago        3.77GB
image-dash                    latest                  a2e823aab2b6        2 months ago        11.1GB
ubuntu                        16.04                   5e8b97a2a082        3 months ago        114MB
nvcr.io/nvidia/tensorflow     18.04-py2               cde12c8f5411        5 months ago        3.5GB
nvcr.io/nvidia/tensorflow     18.04-py3               d72736ef6edb        5 months ago        3.49GB
```
If you don't see anything when you type this command or if the image you are looking for is not listed here, you will need to [download the appropriate image](downloading-docker-images) from the instructions below.

Note a few things:
- Tutorials you may find online may use `docker image ls` instead of `nvidia-docker`. You should use the `nvidia-` prefix in order to use the containers on the DGX machines
- There are multiple containers named `tensorflow` but the `TAG` explains that one of them is for python 2 while the other is for python 3
- There are multiple `nvidia/cuda` containers but the `TAG` explains that they correspond to different versions
- The age of the image is something to watch for under the `CREATED` column. This corresponds to the age of the image online and not on this machine.

### Downloading Docker images
1. Sign up [here](https://ngc.nvidia.com/)
2. Go to the `Configurations` tab
3. Follow instructions to get an `API Key`.
4. Follow Nvidia's instructions to set up your API key in the DGX machine
5. You can now `pull` images on the computer as:

  ```bash
  $ sudo nvidia-docker pull nvcr.io/nvidia/tensorflow:18.04-py3
  ```

  You can replace the `18.04-py3` with `latest` to download the latest available image

Note that you may find images that not blessed by Nvidia on DockerHub and while they may work on your machine, they are not guaranteed to give you the best performance.

## Starting up a container
The recommended command to create and launch a container is often quite long. You will typically need to specify some flags as recommended by Nvidia in addition to forwarding ports and mounting your data. Therefore, you are recommended to create a shell script.

Here is what you may use if you were using Nvidia's TensorFlow image:

```bash
user_name=3_character_id
docker_image=nvcr.io/nvidia/tensorflow:18.04-py3
external_folder=/home/$user_name/my_dl_code_and_data
internal_folder=/workspace/my_dl_code_and_data
container_name=$user_name-TF1804P2

sudo nvidia-docker run --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 -it -v $external_folder:$internal_folder $docker_image --name $container_name
```

### Docker flags explained:
- `--shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864` are added since this is what Nvidia recommends
- `-t` : Allocate a pseudo-tty
- `-i` : Keep STDIN open even if not attached
- `-v $external_folder:$internal_folder` : mounts a folder on the DGX machine as a folder within the container. You will most certainly need this since you cannot get your data and code into the container easily otherwise.
- `--name $container_name`: assigns a custom name for the container. This will make it easy to identify one's own containers and also to attach to the container. Ideally we should be able to use `$USER` instead of manually specifying `$user_name`, however, `$USER` becomes `root` within the container and this is not a great way to distinguish users. Note that hard-coding the name will make it impossible to launch another container with the same name.

Other useful flags:
- `-e CUDA_VISIBLE_DEVICES=“1,3,5,7”` : exports an environment variable. This example is specific to using only a subset of the available GPUs in the machine.
- `-p 8888:8888` : forwards / connects the ports between the DGX and the container. This example is specific to those containers that automatically launch jupyter notebook servers within the container.

You can now launch the container as:

```bash
$ sudo bash tf_container_start_script
```

### Setting up an alias
While the desired containers can be launched as specified above, one can also create an `alias` in `.bashrc`  by adding the following text to `.bashrc`:

```bash
export user_name=3_character_id
export docker_image=nvcr.io/nvidia/tensorflow:18.04-py3
export external_folder=/home/$user_name/my_dl_code_and_data
export internal_folder=/workspace/my_dl_code_and_data
export container_name=$user_name-TF1804P2

alias tf_container_start sudo nvidia-docker run --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 -it -v $external_folder:$internal_folder $docker_image --name $container_name
```

So, the container can be launched simply via

```bash
$ tf_container_start
```

### Using specific GPUs
Often, one may need to share the machine (GPUs) with multiple other users or benchmark networks as a function of GPUs. It is possible use specific GPUs by setting an environment variable. The variable is best set within the container.

For example, here is the command for using odd-numbered GPUs in an 8 GPU DGX-1:

```bash
$ export CUDA_VISIBLE_DEVICES=“1,3,5,7”
```

## Persisting Containers
Often, we may need to close the terminal without killing the training / other computation running within a container. There are multiple ways to have the container persist. Here, are two methods:

### 1. Detaching and attaching to containers
From [Nvidia's documentation](https://docs.docker.com/engine/reference/commandline/attach/):
1. Detach the tty without exiting the shell, using the key combination sequence `Ctrl`+`P` + `Ctrl`+`Q`. This should bring you back to the DGX's shell prompt. You can now even close the ssh connection to DGX.
2. Once you are ready to resume working within the container, figure out the container you want to attach by listing all the containers:

  ```bash
  $ sudo nvidia-docker container ls
  ```

  You should see:

  ```bash
  CONTAINER ID        IMAGE                                  COMMAND                  CREATED             STATUS              PORTS                                        NAMES
d5c3045fcf19        nvcr.io/nvidia/tensorflow:18.04-py2    "/usr/local/bin/nvid…"   12 seconds ago      Up 11 seconds       6006/tcp                                     xyz-TF1804P2
b86de3ef64b0        nvcr.io/nvidia-hpcvis/index:1.0        "nvidia-index-init"      5 days ago          Up 5 days           1935/tcp, 8080/tcp                           unruffled_hypatia
b86473608155        optix_mem_test:8.0-devel-ubuntu16.04   "bash"                   10 days ago         Up 10 days                                                       hardcore_lovelace
  ```

3. Now, attach to the desired container as:

  ```bash
  sudo nvidia-docker attach xyz-TF1804P2
  ```

  Note that if you did not specify the `--name` flag when creating the container, you will need to identify your container via the `IMAGE` and use the  corresponding `CONTAINER ID` or `NAMES`.
4. You should be able to continue using the container as though you never left.

### 2. Screen
1. Before you start your container, start a screen via:

  ```bash
  $ screen -S my_dl_container_screen
  ```

2. Now start your container as shown above
3. Use the following key-combination to detach from this screen: `Ctrl`+`A`, `Ctrl`+`D` and return to the DGX's shell. You are now free to close the ssh connection to the DGX
4. Once you are ready to shut down the Jupyter server and the container, if you did not name your screen or forgot the name of the screen, find the screen you need to attach to via:

  ```bash
  $ screen -ls
  ```

5. You can reattach the appropriate `screen` via:

  ```bash
  $ screen -r my_dl_container_screen
  ```

## Modifying within containers
### Code and data
Any modifications to files within the folder mounted via the `-v` flag when creating the container will persist even after the container is killed.
### Packages
Any packages you pip install while within the container will **not** persist once you close the current container and start up a new container. Tech-savvy users are encouraged to create a Docker image over the the base package to include the missing packages, etc. Others are recommended to install additional packages / software each time the container is spun up or run a script that automates the addons.

For example, you may observe that the very popular `Keras` package is not available as its own nvidia-docker image and it is not included within Nvidia's TensorFlow container. Since Keras sits on top of TensorFlow anyway, it can easily be installed via `pip install keras`. The same applies for the `jupyter` packages.
