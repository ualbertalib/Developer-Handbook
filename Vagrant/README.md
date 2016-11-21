Vagrant is is a tool to create and configure lightweight, reproducible, and portable development environments.

Installation for Windows 7 (64 bit)
============
1. Install VirtualBox.  The latest as of writing is VirtualBox 5.0.26 and is available from: 
http://download.virtualbox.org/virtualbox/
2. Install Vagrant. The latest as of writing is Vagrant 1.8.4 and is available from: 
http://www.vagrantup.com/downloads.html
3. The 'Default Machine Folder' for Virtualbox is 'VirtualBox VMs' in your user directory.  Since, at our place of work,
our user directory is on a shared drive that is synced on startup/shutdown this is a less than ideal to be storing 
files associated with our VMs.  If you notice disk space warnings or really slow logins this could be the problem.  To set
the 'Default Machine Folder' open a command line terminal (i.e. go to the Start menu and enter 'cmd'.  [Cygwin](../Ansible#installation-for-windows-7) works well for this purpose as well.)  Open the application.  At the prompt enter 
```
'c:\Program Files\Oracle\VirtualBox\VBoxManage.exe setproperty machinefolder C:\VMs'
```

Installation for Ubuntu
====================

* ```Ubuntu 16.10``` (Yakkety): As of 2016-11-21, Vagrant will not boot CentOS images for this Ubuntu version. Avoid this version of Ubuntu for now.
* ```Ubuntu 16.04``` (Xenial): Just do ```apt-get install virtualbox vagrant```. This installs VirtualBox 5.0.24 and vagrant 1.8.1.
* ```Older```: The following notes likely apply:
 1. Install VirtualBox. The latest as of writing is VirtualBox 5.0.8 and is available from:
https://www.virtualbox.org/wiki/Linux_Downloads. There are instructions there for adding the source repo to your ```/etc/apt/sources.list```. (note: don't install Ubuntu's packaged version, which is 4.3.26)
 2. Install vagrant. The latest in the public repository is 1.7.3. ```sudo apt-get install vagrant```


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
    vagrant init ual/centos6.7 http://129.128.46.152/vagrantboxes/centos67.json
    ```  
4. Create the development environment.  Since this is the first time, the most recent vagrant box listed in the metadata file will be copied from 
  http://129.128.46.152/vagrantboxes/ to your machinefolder/centos6.7*  This snapshot will   be reused anytime your refer to ual/centos6.7 in this or future Vagrantfiles.  A copy of the snapshot that is now in your 
  machinefolder will be made and called something like '_default_1402698355768_83024' in your machinefolder.  This is the 
  virtual machine that Vagrant is currently bringing up for you.

    ```
    vagrant up
    ```  
5. Go play.  I'm assuming you have a ssh client on your path.

    ```
    vagrant ssh
    ```
6. When you're done suspend the VM if you want to come back to it's state later ```vagrant suspend``` or destroy the VM if you never want to see this incarnation ever again ```vagrant destroy```  When you want the VM again ```vagrant up```

Other things to know
====================
1. If you turn off your computer without suspending your Vagrant machines, that's like a hard poweroff of the VM and state may be lost.
 * ```vagrant global-status --prune``` will show you which vagrant boxes are currently known and their state
 * ```vagrant box list``` will show you a list of the base boxes that are available on your local machine
 * VBoxManage is the command line tool that comes with VirtualBox (C:\Program Files\Oracle\Virtualbox\VBoxManage.exe)
 * ```VBoxManage list vms``` and ```VboxManage list runningvms``` are also useful for seeing the state of your machines
 * In a worst case scenario and a VM is inaccessible 
 ```
 VBoxManage list vms
 ``` 
 ```
 VBoxManage controlvm {uuid} poweroff
 ```
 ```
 VBoxManage unregistervm {uuid} --delete
 ```

 More information can be found at the Vagrant website [http://docs.vagrantup.com/v2/]

2. Pay attention to vagrant box versions.  It's useful to always have the latest
 ```
 ==> dmp: Checking if box 'ual/centos6.5' is up to date...
 ==> dmp: A newer version of the box 'ual/centos6.5' is available! You currently
 ==> dmp: have version '0.1.0'. The latest is version '0.5.0'. Run
 ==> dmp: `vagrant box update` to update.
 ```
 If 'vagrant box update' doesn't work for you try
 ```
 vagrant box remove 'ual/centos6.7'
 vagrant up dmp # a good Vagrantfile will have the info about the base box included
 
 ```
 If 'vagrant box update' or 'vagrant up' gives you following error message:
 ```
The "metadata.json" file for the box 'ual/XXXXX' was not found.
Boxes require this file in order for Vagrant to determine the
provider it was made for. If you made the box, please add a
"metadata.json" file to it. If someone else made the box, please
notify the box creator that the box is corrupt. Documentation for
box file format can be found at the URL below:

http://docs.vagrantup.com/v2/boxes/format.html

```
try below to refer to the json versioning file:
```
vagrant box add ual/hydranorth http://129.128.46.152/vagrantboxes/XXXXX.json
```



3. You can pass through files from the vm to the project directory on your desktop via the ```/vagrant``` directory on the vm. Alternately you can explicitly set shared folders:
 ```
 config.vm.synced_folder "./", "/etc/ansible",
     owner: "root",
     group: "root",
     mount_options: ["dmode=775,fmode=664"]
 ```
 
 4. In Ubuntu, to map to ITS_Share and access (older) golden images:
    1. add the line to the end of the /etc/fstab file with ```sudo vi /etc/fstab```

    ```//libroot/ITS_Share  /libroot/ITS_Share  cifs  credentials=/home/wshi/.smbcredentials,sec=ntlm  0  0```
    2. create directory for mounting location: /libroot/ITS_Share
    3. create a smb credential file at /home/username/.smbcredentials, and have the following lines:
    ```
    username=$username
    domain=UALIBRARY
    password=$password
    ```
    remember no additional whitespaces or blank lines other than the three lines above

    4. do a ```sudo mount -a```
    
5. In Ubuntu 14.04, sometimes vagrant/VirtualBox gives the following error message:
    "VirtualBox is complaining that the kernel module is not loaded. Please
    run `VBoxManage --version` or open the VirtualBox GUI to see the error
    message which should contain instructions on how to fix this error."

    To fix the error do: ```sudo /etc/init.d/vboxdrv setup```
    (Reference: https://github.com/lynnaloo/xtuple-vagrant/issues/13)
    
Vagrantizing a box
==================
1. Create a vm to redistribute (for example from [kickstart](https://github.com/ualbertalib/vagrant-centos) or an [existing vagrant box](https://github.com/ualbertalib/vagrant-centos/releases) that [you modify](https://github.com/ualbertalib/sufia-ansible-vagrant))
2. Invoke ```vagrant package [name]```
3. Test that the vm worked as expected. Do this after package so that testing history and vagrant built ssh credentials don't cause problems later.
4. Rename package.box which was generated in the package step to something descriptive and put it somewhere that it can be shared
5. If using vagrant versioning, update the box metadata json file

  ```
  {
    "name": "ual/hydranorth",
    "description": "This box contains ruby 2.1.5, hydranorth (from sufia engine), passenger/httpd, mysql, redis, fits, and jetty/solr/fedora.",
    "versions": [{
      "version": "1.5.0",
      "providers": [{
        "name": "virtualbox",
        "url": "http://129.128.46.152/vagrantboxes/hydranorth_centos67-x86_64-20161005.box",
        "checksum_type": "sha1",
        "checksum": "c77c8ea7e42d1df91d5ff890a5309192bf1ab540"
      }]
    }]

  }
  ```
  hint: ```openssl dgst -sha1 <filename>``` to generate checksum
6. Test that there isn't any problems with the vagrant metadata json file and the box itself

  ```
  vagrant box update ual/hydranorth
  ```
  or 
  ```
  vagrant box remove ual/hydranorth # because my machine is finicky and won't update
  vagrant box add ual/hydranorth file:////path/to/vagrant/metadata.json
  ```
  and
  ```
  vagrant init ual/hydranorth file:////path/to/vagrant/metadata.json # creates a new Vagrantfile with box and box_url, skip if redundant
  vagrant up # should see vagrant reading metadata.json, recognizing the latest version in that file, and downloading
  vagrant ssh
  vagrant destroy
  ```
7. Edit CHANGES.txt
8. Let your collegues know about your useful new box
  
  
 
