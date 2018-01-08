# Creating SSH shortcuts 

**Suhas Somnath**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences

10/9/2017

This is applicable to Mac OS and Linux **ONLY**

Often you may need to connect to multiple remote machines each with its own public, private keys, usernames etc. 
Accessing remote machines can be simplified substantially using aliases.

1. Create the configuration file if it doesn't already exist:

`sudo touch ~/.ssh/config`

2. Edit the file:

`sudo nano ~/.ssh/config`

3. Add details regarding your machines. Here is how I have set up my Jupyter / Python VM:

```bash
Host jupyterVM
  HostName 172.22.3.50
  User cades
```

4. Access the remote machine:

`ssh jupyterVM` instead of `ssh cades@172.22.3.50`

Other communication protocols including `sftp` are also simplified in the same way

I do not have an answer yet on how to set up an alias for port forwarding. If you do, please feel free to share!
