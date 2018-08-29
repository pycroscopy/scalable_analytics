# Accessing a Remote Jupyter Notebook Server

**Suhas Somnath**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

10/9/2017

The guides below walk you through setting up the port-forwarding / tunnelling to access a Jupyter Notebook server running on a remote machine at port 8889. For the sake of simplicty, we will assume that the jupyter server is running on a virtual machine on CADES Cloud.

The same instructions can be used for connecting to other remote severs such as a TensorBoard server. 

## Windows:
### Win Setup
This guide assumes that you have already followed [CADES' instructions](http://support.cades.ornl.gov/user-documentation/_book/openstack/access-vm/access-vm-ssh-windows.html#download-and-install-putty) to set up basic SSH access using `PuTTy` and have saved the configuration (For example `JupyterVM` in this example)
1. Open `PuTTy`
2. Under `Load, save or delete a stored session`, select your saved configuration and then click `Load`. You should see the value inside the `Host Name (or IP address)` box at the top change and reflect the address for your remote machine. 
   ![](media/python_analytics_server/image031.png)
3. On the left-hand pane (`Category`), Go to `SSH` → `Tunnels`
4.  Set the following:
  1. `Source port`: `8889`
  2. `Destination`: `127.0.0.1:8889`
    ![](media/python_analytics_server/image027.png)
  3. Click on the `Add` button. You should see the following under `Forwarded ports`:
  ![](media/python_analytics_server/image029.png)

5. Go back to `Session` on the left-hand pane. Highlight the name of the configuration (`JupyterVM` in this case) under `Saved Sessions`. and click on the `Save` button.
  ![](media/python_analytics_server/image031.png)
6.  You can verify that the tunneling settings have been saved by:
    1. Closing Putty,
    2. Reopening Putty,
    3. Loading the configuration `JupyterVM`
    4. Navigating to `SSH` → `Tunnels`
    5. The line containing the port forwarding should still be there.
    6. If it is not, re-do the appropriate steps above.
### Win Access
Once you start the jupyter server correctly on your remote machine:
1. Open `PuTTy`
2. Select the correct configuration (`JupyterVM` in this case) 
3. Click `Load`. You should see the IP address update in the box at the top.
4. Click on the `Open` button in the bottom. You will be presented with a new SSH connection to the VM. You can close this if you do not need it.
5. Open a browser and go to: http://localhost:8889/

## MacOS
### Mac Setup
1.  Open the `Terminal` application and go to `Shell` → `New Remote Connection`
2.  Click on the `+` icon under the right-hand column (`Server`).
3.  Type: `-N -L localhost:8889:localhost:8889 cades@172.22.3.50`. Replace the IP address with that of your machine. Click `OK`.
  ![](media/python_analytics_server/image011.png)
### Mac Access
Once you start the jupyter server correctly on your remote machine:
1. Open the `Terminal` application and go to `Shell` → `New Remote Connection`
2. Click on the correct configuration on the right-hand pane
3. Click on the `Connect` button shown above to establish the connection with your jupyter server. 
   You will be presented with a new `Terminal` window once you click on `Connect`. Closing this terminal window will cause the connection to your Jupyter server to terminate.
   Therefore, close this terminal only when you want to close the port forwarding. 
4. To reestablish the connection to your Jupyter server, just follow steps 1-3.
