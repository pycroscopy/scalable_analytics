# Accessing Remote Files via a GUI

Suhas Somnath<br>
12/8/2017

This is for Linux and MacOS **ONLY**

For this, we will be using a popular open-source command called `sshfs`

Mac users will need to visit [OSXFuse](https://osxfuse.github.io) and install `FUSE` followed by `SSHFS`.

This tutorial was adapted from [DigitalOcean.com](https://www.digitalocean.com/community/tutorials/how-to-use-sshfs-to-mount-remote-file-systems-over-ssh)

Below is a bash script to connect to a specific remote machine. 
Modify **ONLY** the first three lines of this script and leave the last two lines as is

```bash
localdir=/Users/syz/Desktop/deep_dir
remotedir=/home/syz/atom_ai/test
remote_address=syz@deep.ornl.gov
mkdir $localdir
sudo sshfs -o allow_other,defer_permissions $remote_address:$remotedir $localdir
```
Run this bash script as
```bash
$ bash fuse_script
```

Now, your computer should see a new volume mounted. Open this volume to operate on the files on the remote machine's folder

Once you are done working on your files, you can eject this volume and delete the temporary local folder.
