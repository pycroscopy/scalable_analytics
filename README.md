# Python analytics using ORNL CADES Birthright Cloud

## Preface
-   In this era of exploding data sizes and computationally expensive data analysis algorithms, analyzing data on your personal computer is becoming ever more infeasible. It is equally infeasible to expect each researcher to purchase / upgrade to powerful computers for their own research since such computers can quickly become prohibitively expensive to procure and maintain. [Cloud](http://support.cades.ornl.gov/index.php/birthright-cloud/), [cluster](http://support.cades.ornl.gov/index.php/shpc-condos/), and [leadership (supercomputers)](https://www.olcf.ornl.gov/computing-resources/) computing resources are ideally suited for such problems.
- For most researchers, the jump from analyzing data on their personal computers directly to supercomputers can seem extremely  challenging. This steep learning curve can be substantially alleviated by breaking it down to intermediate milestones. Here is one possible (natural) progression: 
  1. Personal computer - 1 computer (think CPU for simplicity)
  2. [Remote computer](http://www.linfo.org/remote_machine.html) / virtual machine - typically 1 computer (CPU)
  3. [Cluster](https://en.wikipedia.org/wiki/Computer_cluster) - up to a few hundred computers (formally referred to as "nodes") connected over a network
  4. [Leadership-class machines (supercomputers)](https://en.wikipedia.org/wiki/Supercomputer) like [Titan](https://www.olcf.ornl.gov/computing-resources/titan-cray-xk7/) and Summit - thousands of nodes.
- Unlike supercomputers or clusters, the data analysis code and the process of analyzing data on virtual machines remains similar to that on personal computers. This is why virtual machine are the next logical step up from personal computers.
- The challenge (for most researchers) in transitioning to remote computers / virtual machines actually only lies in learning how to operate and communicate with the virtual machine. Considering that clusters and supercomputers are similar in this regard, the concepts learned from using remote computers / virtual machines will be directly applicable and necesary to use clusters and supercomputers
- Remote computers, clusters, and supercomputers almost always run a Linux-based operating system which is [different from Mac OS and Windows](https://shiftwebsolutions.com/the-differences-between-mac-windows-and-linux/) typically used on personal computers. Furthermore, these remote computers often do not come with the familar [graphical interface](https://www.britannica.com/technology/graphical-user-interface) supplied by Windows and Mac OS and [instead](https://www.computerhope.com/issues/ch000619.htm) come with a [command line interface](https://en.wikipedia.org/wiki/Command-line_interface). Fortunately, there are several [tutorials](https://www.udacity.com/course/linux-command-line-basics--ud595) available that alleviate this challenge. You are also very likely to find multiple solutions readily available via Google for practically any problem you may encounter. 
- The guides below will help you in setting up a remote machine that you can use instead of your personal machine for your data analytics (or other) needs. These remote / virtual machines are completely **FREE** for ORNL employees and will not count against any allocation meant for supercomputers. 
- I intend to follow up with guides on using [CADES' cluster](http://support.cades.ornl.gov/index.php/shpc-condos/) for computing 

## Tutorials

**Start with [this guide](python_analytics_server.md) to set up your own the python analytics virtual machine.**

Self-help guides on additional topics:
* [Transferring files between your local and virtual machines](sftp.md)
* [Adding additional storage volumes for your data](mount_drive.md)
* [Deep learning](deep_learning_container.md)
* [Configuring ssh shortcuts](ssh_alias.md)

If you have any guides that may benefit others, please feel free to add them here.
