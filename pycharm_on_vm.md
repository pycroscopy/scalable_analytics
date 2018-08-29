# Running PyCharm on a virtual machine using X-forwarding

**Samuel Williams**<br>
Scanning Probe Microscopy<br>
Center for Nanophase Materials Sciences<br>
Oak Ridge National Laboratory<br>

School of Materials Science and Engineering<br>
Georgia Institute of Technology<br>

6/20/2018


X-forwarding involves connecting an application running on a Linux system to a display server (known as the X server) running on a different system (such as a Windows computer through which the user is interfacing with the Linux system). In this guide, we will install an X server on your local computer, install PyCharm on the virtual machine, and then run PyCharm, displaying its graphical user interface through the X server. For more background information, read about the [X Window System](http://www.opengroup.org/tech/desktop/x-window-system/) and [X.Org](https://www.x.org/wiki/). 

## Before beginning this guide

* This guide assumes that you have completed the "Setting up a Python Analytics Server" guide available [here](https://github.com/pycroscopy/cades_birthright/blob/master/python_analytics_server.md).
* Close any running PuTTY sessions. 

## Setting up X-forwarding

We will have the virtual machine connect to a program running locally through X-forwarding to display PyCharm as a graphical user interface. 

### Windows

#### Install an X server

One possible X server to use is [Xming](http://www.straightrunning.com/XmingNotes/#head-12). On the Xming website linked, click "Xming" under "Public Domain Releases" in the Releases section. Download and install Xming, using all of the recommended settings.

Other X servers may work too. However, these servers may require different or additional configuration. 

#### Configuring PuTTY to use the X Server

1. Open PuTTY. 
2. `Load` your saved session.
3. Go to the `Connection` --> `SSH` --> `X11` category in the `Categories` field on the left. 
4. Check the box for `Enable X11 forwarding`. 
5. Go to the `Session` category again. Change the name of the session. For example, if your saved session was named "JupyterVM," you could name the new session "JupyterVM-X11." Then, click `Save` to save the session.
6. `Open` your new saved session.

### macOS

Install [XQuartz](https://www.xquartz.org/), and then start XQuartz. Connect to your virtual machine using SSH in a terminal window as you would normally, but include the `-Y` argument to enagle X-forwarding.

## Installing PyCharm

[PyCharm](https://www.jetbrains.com/pycharm/download/#section=linux) is available as a snap package. Run `sudo snap install pycharm-community --classic` to install it.

## Running PyCharm

Before running PyCharm, ensure that your X server on your local computer is running. By default, Xming is started in the last step of installation. If your X server is not running, start it.

Run PyCharm by running `pycharm-community` in your virtual machine. Wait a moment and the PyCharm splash screen should appear as a new window created by the X server. 

## Configuring PyCharm to manage repositories of interest

In this example, the goal is to work on a python package on GitHub for nanoscale image analysis - [pycroscopy](https://pycroscopy.github.io/pycroscopy/about.html). Follow [this guide](https://github.com/pycroscopy/pycroscopy/blob/master/docs/Using%20PyCharm%20to%20manage%20repository.pdf) starting from the third page, titled "Set-Up PyCharm."
