# Transferring Files

With the exception to file transfers, most other topics regarding the operation of this VM are related to routine operation and administration of conventional Linux computers and you are recommended to refer to numerous online resources for these topics.

## Basic file transfers to / from the remote machine:
You will often need to transfer files to the remote server to start
computing and vice versa to download results.
-   You can always upload files via the Jupyter server itself but try to
    limit this to small files.
-   Use [`Secure File Transfer Protocol`](https://kb.wisc.edu/cae/page.php?id=32991) (SFTP) to transfer large files to and from the remote machine instead.

Note that You cannot use the `SFTP` session to unzip, open, modify the files etc. For this you will need a new / existing SSH session. Alternatively, you can access the terminal on the remote machine via the Jupyter notebook server.

### Initiating SFTP:

#### Linux / Mac OS:
1.  Open a new terminal. This should put you in the `home` directory of your local machine by default (one level above Documents, Downloads etc.).
2.  Navigate to the folder of interest on your local machine using the `cd` command.
3.  Type the following command (replace with your remote machine’s IP address). Using the graphical interface automatically starts the `sftp` session in the home directories of both your local and remote machines.
    ```bash
    $ sftp cades@172.22.3.50
    ```

4.  Follow the steps below for transferring files

#### Windows:
1.  Access the command prompt by clicking on the `Start` button and typing `cmd`. Hit `Enter`.
2.  Navigate to the local folder you want to transfer files from using the `cd` command.
3.  Connect to the remote machine via the command below. Replace the IP address with that of your remote machine and *JupyterVM* with the name you gave to your `putty profile` in step 2.
    ```bash
    $ pstfp <cades@172.22.3.50> -load JupyterVM
    ```

4.  Follow the steps below for transferring files

### Transferring files - Linux / Mac / Windows:
1.  Transfer a file from your local machine to the remote / virtual machine via:
    ```bash
    $ put ./Desktop/my/local/file.zip ./remote/folder/my_file.zip
    ```

2.  Transfer entire folders to the virtual machine:
    ```bash
    $ put –r ./path/to/local_folder ./path/to/remote_dir/
    ```

3.  Download a file:

    ```bash
    $ get ./remote/folder/remote_file ./path/to/local/folder/
    ```
