# Adding Additional Volumes (Storage Drives)

**Suhas Somnath and Whitney Nelson**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

Updated: 06/12/2018


You cannot resize the boot volume size after your instance is created. Refer to the two options below:

**Option 1: Expand your existing volume**

Pros:
 <li> Requires no system admin work</li><br>

Cons:
 <li> Must create a new Virtual Machine</li>
 <li>Generates a new IP address for Virtual Machine</li><br>

**Option 2: Add an additional volume**

Pros:
<li> Keeps your IP address </li>
<li>Add as many volumes as you like</li><br>

Cons:
<li> Requires  fair amount of system admin work </li>


## Option 1

**Deleting your instance means that you must create a new one.** Proceed only if you ensured that your volume would not be deleted upon deletion of your instance and do not mind losing the IP address of your machine.<br>

**Prerequisite: Ensure that your volume is a bootable type.**

- Go to Horizon at <http://cloud.cades.ornl.gov/>.

- Login with your UCAMS credentials.

- Navigate to `Project` &#8594; `Compute` &#8594; `Volumes`.

![](/media/mount_drive_screenshots/volumesNavigation.png)

- Check the Bootable column for your volume. It should read "Yes" in the cell.

![](https://github.com/pycroscopy/cades_birthright/blob/master/media/mount_drive_screenshots/bootable.PNG)

- If the volume is not bootable, click `Edit Volume`.

- In the resulting dialog, check the `Bootable ` box then click submit. The cell under the Bootable column should now read "Yes".

**Expanding your existing volume:**

1. Navigate to `Project` &#8594; `Compute` &#8594; `Instances`.

![](/media/mount_drive_screenshots/instancesNavigation.png)

2. Select the box next to your instance name, then click `Delete Instances`.

![](https://github.com/pycroscopy/cades_birthright/blob/master/media/mount_drive_screenshots/deleteInstance.PNG)

3. Navigate to the `Volumes` tab.

4. Resize your volume by clicking the down arrow next to `Edit Volume` then select `Extend Volume`.

![](https://github.com/pycroscopy/cades_birthright/blob/master/media/mount_drive_screenshots/extendVolume.PNG)

5. In the resulting dialog, enter the desired size in the New Size (GiB) field.

6. Click `Extend Volume`. The new volume size should appear in the Size column of your volume.

7. Click the down arrow next to `Edit Volume` again, then select `Launch as Instance`.

![](https://github.com/pycroscopy/cades_birthright/blob/master/media/mount_drive_screenshots/volumeLaunchInstance.PNG)

8. Fill out the tabs in the resulting dialog box for your new instance.

* Under the Source Tab, ensure that your volume appears under the Allocated table with the correct size.

![](https://github.com/pycroscopy/cades_birthright/blob/master/media/mount_drive_screenshots/allocated.PNG)

9. Once you have entered all required fields, click `Launch Instance`. The instance will have a new IP address which will change the way you access your Virtual Machine. Refer to [Access Your VM Instance Running in OpenStack](http://support.cades.ornl.gov/user-documentation/_book/openstack/access-vm/access-vm.html) for additional help.


## Option 2

Add an additional volume – this requires you to do some system admin work on your instance and is similar to working on a local Linux machine.

1.  Go to Horizon at <http://cloud.cades.ornl.gov/> and login with your UCAMS credentials.

2.  Navigate to `Project` &#8594; `Compute` &#8594; `Volumes`.

![](/media/mount_drive_screenshots/volumesNavigation.png)

3.  In the Volumes screen, click `+ Create a New Volume`.

![](https://github.com/pycroscopy/cades_birthright/blob/master/media/mount_drive_screenshots/createVolume.PNG)

4.  In the resulting Create Volume dialog, fill out the required field by entering the size of your new volume.
 - `Volume Name`: a case-sensitive sequence of characters naming the volume.
 - `Description`: short description of the volume
 - `Volume Source`: the default value is "No source, empty value".
 - `Type`: the type is default to "Net Type". However, if your requires a higher volume of data, utilize "Large_Data_Store".
 - **(Required)** `Size`: Enter the desired size in GiB.
 - Availability Zone: The default value is set to "nova".

5.  Select `Create Volume` in the bottom right dialog to continue. The new volume should appear under the `Volumes` tab.

6.  Next, attach it to your existing instance by selecting the down arrow next to `Edit Volume` then select `Manage Attachments`.

![](https://github.com/pycroscopy/cades_birthright/blob/master/media/mount_drive_screenshots/manageAttachments.PNG)

 7. In the resulting Manage Volume Attachments dialog, fill out the required field by selecting the appropriate instance.

 8.   Click `Attach Volume` to continue.

 9.  [Format and mount the volume in your instance](https://docs.oracle.com/cloud/latest/computecs\_common/OCSUG/GUID-7393768A-A147-444D-9D91-A56550604EE5.htm\#OCSUG196) (see below) :

    - Access your VM instance's bash terminal (for additional help refer to [Access VM Instances Running in Open Stack](http://support.cades.ornl.gov/user-documentation/_book/openstack/access-vm/access-vm-ssh-windows.html)).

    - Then, find out the name of the new volume:

        ```bash
        $ lsblk
        ```
    - You should see something like:

      ```bash
      # NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
      # vda    253:0    0   8G  0 disk
      # └─vda1 253:1    0   8G  0 part /
      # vdb    253:16   0  80G  0 disk
      ```
    - In our case, *vdb* is the volume we want to mount. In the bash type the following:

      ```bash
      $ sudo fdisk /dev/vdb
      ```

    - In the prompts do the following to set the correct flags:

      * type: *c* and hit *enter*
      * type: *u* and hit *enter*
      * type: *w* and hit *enter*
      </br>
      </br>
    - Next, find out what file system is being used on the boot drive, let’s use the same:

      ```bash
      $ mount | grep "\^/dev"
      ```
    - This should show you something like:

      ```bash
      # /dev/vda1 on / type ext4 (rw,relatime,data=ordered)
      ```
    - Make the file system on the new volume:

      ```bash
      $ sudo mkfs -t ext4 /dev/vdb
      ```
    - If asked to overwrite the partition table, type: *y* then hit *enter*.

    - Make a new folder. This is where the data will be stored.

      ```bash
      $ cd \~
      $ mdkir data
      ```
    - Finally, mount the volume.

      ```bash
      $ sudo mount /dev/vdb /home/cades/data
      ```

    - You should see two lines now:

      ```bash
      # /dev/vda1 on / type ext4 (rw,relatime,data=ordered)
      # /dev/vdb on /home/cades/data type ext4 (rw,relatime,data=ordered)
      ```
    - Verify that the mounting was done correctly:

      ```bash
      $ lsblk
      ```
    - You should see something like:

      ```bash
      # NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
      # vda 253:0 0 8G 0 disk
      # └─vda1 253:1 0 8G 0 part /
      # vdb 253:16 0 80G 0 disk /home/cades/data
      ```
   - Check to see that data is indeed on the new volume:

      ```bash
      $ df anaconda/
      ```
   - You should see something like:

      ```bash
      # Filesystem 1K-blocks Used Available Use% Mounted on
      # /dev/vda1 8065444 5962536 2086524 75% /
      ```
    - This indicates that anaconda is on the boot drive (_/dev/vda1_). Let's do the same for the newly mounted volume at _/data/_:

      ```bash
      $ df data/
      ```
    - You should see something like:

      ```bash
      # Filesystem 1K-blocks Used Available Use% Mounted on
      # /dev/vdb 82438832 57088 78171056 1% /home/cades/data
      ```
    - Clearly, the new folder data is actually on the new volume */dev/vdb*
while the other folder anaconda was on the boot drive */dev/vda1*.

   - Move any data from your fixed sized boot volume to the new volume.

      ```bash
      $ sudo mv old/folder/on/boot/volume/\* data/
      ```
