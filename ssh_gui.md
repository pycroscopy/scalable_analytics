# Graphical Interface for SSH shortcuts in MacOS

**Suhas Somnath**<br>
Advanced Data and Workflows Group<br>
National Center for Computational Sciences<br>
Oak Ridge National Laboratory

10/9/2017

This is applicable for **MacOS ONLY**

The Mac `Terminal` application comes with utilities that simplify the ssh process with a graphical interface. If you are comfortable with the command line and do not mind typing ssh / sftp commands you do not need to follow the following steps.

## Simply accessing the VM
1.  Open the `Terminal` app
2.  Go to `Shell` → `New Remote Connection`
3.  Click on the `+` icon under the right-hand column (`Server`).
4.  Type the address of your instance like `cades@172.22.3.50` into the pop up window as shown in the image below
5.  Click `OK`.
  ![](media/python_analytics_server/image007.png)
6.  You should see a new entry in the `Server` column.
  ![](media/python_analytics_server/image009.png)
7. You can now click on the ``Connect`` button to connect to your VM
8. You can use the same entries for other services such as  `Secure File Transfer` ([sftp](./sftp.md)).
  
## Port forwarding for Jupyter
The former application does not make a particularly compelling case for setting up the GUI shortcut. 
However, it is very handy for setting up the port forwarding to your VM (already) running a Jupyter server.
1.  Open the `Terminal` app
2.  Click on the `+` icon under the right-hand column (`Server`).
3.  Type: `-N -L localhost:8889:localhost:8889 cades@172.22.3.50`. Replace the IP address with that of your machine. Click `OK`.
  ![](media/python_analytics_server/image011.png)
4. Once you start up your Jupyter server in your VM, you can click on the `Connect` button shown above to establish the connection with your jupyter server. 
   You will be presented with a new `Terminal` window once you click on `Connect`. Closing this terminal window will cause the connection to your Jupyter server to terminate.
   Therefore, close this terminal only when you want to close the port forwarding. 
5. To reestablish the connection to your Jupyter server, just follow step 4.
