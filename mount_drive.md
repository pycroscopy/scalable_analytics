# Adding additional volumes (storage drives):

You cannot resize the boot volume size after your instance is created.
Two solutions to this are:

1.  Expanding your existing volume – If you ensured that your volume
    would not be deleted upon deletion of your instance and do not mind
    losing the IP address of your machine:
    1.  Delete your instance on Horizon
    2.  Go to the Volumes section and resize your volume.
    3.  Create a new instance and use this existing volume instead of
        creating a new one.
    4.  You would have to delete your instance

2.  Adding an additional volume – this requires you to do some sys admin
    work on your instance and is similar to working on a local Linux
    machine
    1.  Go to Horizon
    2.  Create a new volume
    3.  Attach it to your existing instance
    4.  Follow sys admin procedures to mount this volume (see below).


1.  Create a new volume on Horizon
    1.  Go to Horizon → Compute tab → Volumes sub-tab
        ![](media/image019.png){width="6.490680227471566in"
        height="3.2182961504811898in"}
    2.  Click on the Volumes tab...

2.  Attach this volume to your instance on Horizon
3.  [Format and mount the volume in your instance](https://docs.oracle.com/cloud/latest/computecs\_common/OCSUG/GUID-7393768A-A147-444D-9D91-A56550604EE5.htm\#OCSUG196):
\# Instructions from


\# Find out the name of the new volume:

lsblk

\# You should see something like:

\# NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT

\# vda 253:0 0 8G 0 disk

\# └─vda1 253:1 0 8G 0 part /

\# vdb 253:16 0 80G 0 disk

\# Here vdb is the volume we want to mount

sudo fdisk /dev/vdb

\# in the prompts type: c and hit enter

\# in the prompt, type: u and hit enter

\# type w and hit enter

\# find out what file system is being used on the boot drive, let’s use
the same:

mount | grep "\^/dev"

\# this should show you something like:

\# /dev/vda1 on / type ext4 (rw,relatime,data=ordered)

\# make the file system on the new volume:

sudo mkfs -t ext4 /dev/vdb

\# if asked to overwrite the partition table, type: y and hit enter

\# make a new folder which is where the data will be stored.

cd \~

mdkir data

\# Finally mount the volume:

sudo mount /dev/vdb /home/cades/data

\# you should see two lines now:

\# /dev/vda1 on / type ext4 (rw,relatime,data=ordered)

\# /dev/vdb on /home/cades/data type ext4 (rw,relatime,data=ordered)

\# check mounting:

lsblk

\# You should see something like:

NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT

vda 253:0 0 8G 0 disk

└─vda1 253:1 0 8G 0 part /

vdb 253:16 0 80G 0 disk /home/cades/data

\# Check to see that data is indeed on the new volume:

df anaconda/

\# You should see:

\# Filesystem 1K-blocks Used Available Use% Mounted on

\# /dev/vda1 8065444 5962536 2086524 75% /

df data

\# You should see:

\# Filesystem 1K-blocks Used Available Use% Mounted on

\# /dev/vdb 82438832 57088 78171056 1% /home/cades/data

\# Clearly, the new folder data is actually on the new volume /dev/vdb
while the other folder anaconda was on the boot drive /dev/vda1

\# Moving any data from your fixed sized boot volume to the new volume:

sudo mv old/folder/on/boot/volume/\* data/

1.  Adding aliases to the instance
