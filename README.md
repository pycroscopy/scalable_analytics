# Scaling up data analysis
**Suhas Somnath**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

## Introduction
-   In this era of exploding data sizes and computationally expensive data analysis algorithms, analyzing data on your personal computer is becoming ever more infeasible. It is equally infeasible to expect each researcher to purchase / upgrade to powerful computers for their own research since such computers can quickly become prohibitively expensive to procure and maintain. [Cloud](http://support.cades.ornl.gov/index.php/birthright-cloud/), [clusters / high performance computers (HPC)s](http://support.cades.ornl.gov/index.php/shpc-condos/), and [leadership (top-of-the-line supercomputers)](https://www.olcf.ornl.gov/computing-resources/) computing resources are ideally suited for such problems.
- For most researchers, the jump from analyzing data on their personal computers directly to supercomputers can seem extremely  challenging. This steep learning curve can be substantially alleviated by breaking it down to intermediate milestones. Here is one possible (natural) progression:
  1. Personal computer - 1 computer
  2. [Single remote computer](http://www.linfo.org/remote_machine.html) / virtual machine
  3. [Small clusters](https://en.wikipedia.org/wiki/Computer_cluster) - up to a few hundred computers (formally referred to as "nodes") connected over a network
  4. [Leadership-class machines (supercomputers)](https://en.wikipedia.org/wiki/Supercomputer) like [Titan](https://www.olcf.ornl.gov/computing-resources/titan-cray-xk7/) and [Summit](https://www.olcf.ornl.gov/summit/) - thousands of nodes. Note that the number of nodes are no longer the only / obvious metric for distinguishing small clusters from leadership-class machines.
- Remote computers, clusters, and supercomputers are different from typical personal computers in a few important ways:
  1. They almost always run a Linux-based operating system which is [different from Mac OS and Windows](https://shiftwebsolutions.com/the-differences-between-mac-windows-and-linux/) typically used on personal computers.
  2. These computers do not come with the familiar [graphical interface](https://www.britannica.com/technology/graphical-user-interface) supplied by Windows and Mac OS and [instead](https://www.computerhope.com/issues/ch000619.htm) come with a [command line interface](https://en.wikipedia.org/wiki/Command-line_interface).

  Fortunately, there are several [tutorials](https://www.udacity.com/course/linux-command-line-basics--ud595) available that alleviate this challenge. You are also very likely to find multiple solutions readily available via Google for practically any problem you may encounter.
- Clusters and supercomputers tack on an additional set of differences from personal computers:
  1. These machines are always shared and are being used by multiple other users
  2. Users rarely have to careful and cognizant about file systems, privileges for installing / modifying software. Software is made available through `modules`
  3. Computationally intensive work is performed by submitting `jobs` to a `batch` `scheduler`. In other words, you request the computer to perform the desired operation on `N` nodes when the requested resources become available. Therefore, your code is **not** executed instantaneously as in a single remote / personal computer where you are the only user.
  4. The analysis codes developed on personal computers may work fine as is but will not be able to use more than a single computer / node. In order to use more than one node (and make full use of the cluster), the code needs to use `sockets` or the `message passing interface (MPI)` to enable the workload to be distributed amongst `N` nodes.
- As you may be (correctly) thinking, the transition from a personal computer to a supercomputer is a big jump for the average scientist. One would not only need to get used to a different operating system and a different way to interface with the computer (command-line), but also restructure the analysis code and usage pattern to match that of the supercomputers.
- This is exactly why, I am of the opinion that simple virtual machines are the next logical step up from personal computers. The challenge (for most researchers) in transitioning from personal computers with a familiar and user-friendly graphical interface to remote computers / virtual machines actually only lies in learning how to operate and communicate with the virtual machine. Considering that clusters and supercomputers are similar in this regard, the concepts learned from using remote computers / virtual machines will be directly applicable and necessary to use clusters and supercomputers. Note that I am aware that virtual machines will not scale to the extent necessary for the desired application - this step is *purely for education and training*.
## The Path to supercomputing
- I envision the path towards supercomputers as follows:
  1. **Virtual machine**:
        - The [Compute and Data Environment for Science (CADES)](https://cades.ornl.gov) has a cloud offering called [CADES Cloud](https://cades.ornl.gov/service-suite/cades-cloud/) where ORNL employees can try out Virtual machines for free via the `Birthright` allocation. Others are encouraged to use Amazon's / Google's / Microsoft's offerings.
        - Familiarize yourself with basics of CLI
        - Familiarize yourself with the basics of Linux
        - Familiarize yourself with interacting with a remote computer where you need to communicate with servers and services (e.g. - Jupyter notebook server), where you cannot plug in USB drives, etc.
        - Begin to transition yourself away from proprietary / Windows-only software to cross-platform and open-source alternatives
        - Put together the new set of tools necessary for interacting with remote machines from your personal computer
  2. **Small cluster**:
        - CADES offers scalable cluster computing via the [CADES SHPC Open Research Condo](https://cades.ornl.gov/service-suite/scalable-hpc/) for ORNL employees. Users can use the `Birthright` allocation for development if their division doesn't already have [dedicated resources](http://support.cades.ornl.gov/user-documentation/_book/condos/how-to-use/request-access.html).
        - Learn the basics of submitting jobs, file systems, etc.
        - Begin scaling your analytics code to use more than one node using MPI
  3. **Leadership computing** (Oak Ridge Leadership Computing Facility)
        - Start developing code that uses GPUs via Nvidia's CUDA
        - Scale up GPU code

## Tutorials
- This repository will be used to host guides to walk people through this process. If and where appropriate, the guides will be moved to [CADES](http://support.cades.ornl.gov/user-documentation/_book/SUPPORT.html) / [OLCF](https://www.olcf.ornl.gov/for-users/getting-started/) documentation.
- If you need help or have questions / want to report bugs or broken links, **please contact the author listed at the top of the specific tutorial page**
- **Virtual machines**
  - Start with [this guide](http://support.cades.ornl.gov/user-documentation/_book/user-contributed-tutorials/jupyter/python_analytics_server.html) to set up your own the **python analytics virtual machine**.
  - Full list of user-developed [tutorials](http://support.cades.ornl.gov/user-documentation/_book/user-contributed-tutorials/user-contributed-index.html)
  - Tutorials on the [basics of Linux](http://support.cades.ornl.gov/user-documentation/_book/linux/linux-intro.html)
- **Cluster / HPC computing**
  - Start [here](http://support.cades.ornl.gov/user-documentation/_book/quick-starts/condo-quick-start.html) to get started with the CADES SHPC Condo
- [Nvidia DGX machines](./dgx_guide.md) for deep learning
- Where did the many guides previously present here dissappear? See CADES [user-contributed documents](http://support.cades.ornl.gov/user-documentation/_book/user-contributed-tutorials/user-contributed-index.html) 
- If you have any guides that may benefit others, please feel free to contact me or make a pull request!
