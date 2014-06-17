Vagrant is is a tool to create and configure lightweight, reproducible, and portable development environments.

Installation for Windows 7 (64 bit)
============
1. Install VirtualBox.  The latest as of writing is VirtualBox 4.3.12 and is available from: 
http://download.virtualbox.org/virtualbox/4.3.12/VirtualBox-4.3.12-93733-Win.exe
2. Install Vagrant. The latest as of writing is Vagrant 1.6.3 and is available from: 
https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3.msi via http://www.vagrantup.com/downloads.html
3. The 'Default Machine Folder' for Virtualbox is 'VirtualBox VMs' in your user directory.  Since, at our place of work,
our user directory is on a shared drive that is synced on startup/shutdown this is a less than ideal to be storing 
files associated with our VMs.  If you notice disk space warnings or really slow logins this could be the problem.  To set
the 'Default Machine Folder' open a command line terminal (i.e. go to the Start menu and enter 'cmd'.  [Cygwin](../Ansible#installation-for-windows-7) works well for this purpose as well.)  Open the application.  At the prompt enter 
```
'c:\Program Files\Oracle\VirtualBox\VBoxManage.exe setproperty machinefolder C:\VMs'
```

Simple Walkthrough
==================
Now you're ready to create your first Vagrant based project.

1. Open the command line (i.e. go to the Start menu and enter 'cmd'.  [Cygwin](../Ansible#installation-for-windows-7) works well for this purpose as well.)
2. Create a directory for your project

    ```
    cd c:\  
    mkdir project  
    cd project
    ```  
3. Create a Vagrantfile. Vagrantfiles are a simple configuration file using Ruby to define your development environment.

    ```
    vagrant init centos6.5 //libroot/ITS_Share/vagrantboxes/golden_centos65-x86_64-20140609.box
    ```  
4. Create the development environment.  Since this is the first time, the vagrant box will be copied from 
  //libroot/ITS_Share/vagrantboxes/golden_centos65-x86_64-20140609.box to your machinefolder/centos6.5  This snapshot will   be reused anytime your refer to centos6.5 in this or future Vagrantfiles.  A copy of the snapshot that is now in your 
  machinefolder will be made and called something like '_default_1402698355768_83024' in your machinefolder.  This is the 
  virtual machine that Vagrant is currently bringing up for you.

    ```
    vagrant up
    ```  
5. Go play.  I'm assuming you have a ssh client on your path.

    ```
    vagrant ssh
    ```

More information can be found at the Vagrant website [http://docs.vagrantup.com/v2/]
