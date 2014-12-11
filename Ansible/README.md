Ansible is an IT automation tool. It can configure systems, deploy software, and orchestrate more advanced IT tasks such as continuous deployments or zero downtime rolling updates.

Installation for Windows 7
==========================
WARNING!!! Anisble does not technically support Windows as a control machine.  Here is the best workaround I've found:

1. Download and install **Cygwin for 32-bit versions of Windows** [https://cygwin.com/install.html]. Cygwin is a brilliant command line interface for Windows.  It gives you access to all Windows utilities on your PATH and provides some missing useful linux tools compiled for Windows.  If you're familar with the Linux command line then you will feel right at home with this on your desktop. You will need at least the following packages:
 * curl
 * python (2.7.x)
 * python-crypto
 * python-openssl
 * python-paramiko
 * python-setuptools
 * git (1.7.x)
 * vim
 * openssh
 * openssl
 * openssl-devel

 Ansbile installed in Cygwin for 64-bit versions of Windows has been shown to fail without any output.  If you experience this problem try 32-bit Cygwin.
2. Download and install PyYAML and Jinja2 separately. I couldn't find them in Cygwin's installer: 
 1. Open Cygwin
 2. Download PyYAML:
    
    ```
      curl -O https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.10.tar.gz  
    ```
 3. Download Jinja2:
    
    ```
      curl -O https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.6.tar.gz  
    ```
 4. Untar both downloads:
    
    ```
    tar -xvf PyYAML-3.10.tar.gz && tar -xvf Jinja2-2.6.tar.gz  
    ```
 5. Change directory into each of the expanded folders and run python setup.py install to install each package.
    
    ```
    cd PyYAML-3.10 && python setup.py install && cd ..  
    cd Jinja2-2.6 && python setup.py install && cd ..  
    ```
3. Clone ansible from its repository on GitHub:

    ```
    git clone https://github.com/ansible/ansible /opt/ansible  
    ```
4. Checkout v1.6.10 (the latest available late July 2014 in Ansible repo) *note* Ansible version<=1.6.6 has an arbitrary code execution vulnerability. Details [here](http://www.ocert.org/advisories/ocert-2014-004.html)
     
    ```
    cd /opt/ansible && git checkout v1.6.10 
    ```
5. Add the following lines into your Cygwin .bash_profile.  Use ```vim ~/.bash_profile``` or edit C:\cygwin\home\username\.bash_profile in your favourite editor.

    ```
    # Ansible settings  
    ANSIBLE=/opt/ansible  
    export PATH=$PATH:$ANSIBLE/bin  
    export PYTHONPATH=$ANSIBLE/lib  
    export ANSIBLE_LIBRARY=$ANSIBLE/library  
    ```
6. Ansible relies on SSH for authentication and communication with the target machine(s).  There is no magic, if you don't have access to a machine there isn't any good reason for you to be running playbooks on it.  Follow these instructions to setup a [SSH keypair](../README.md#ssh-keys). Follow these instructions to disable buggy [OpenSSH ControlMaster](README.md#1-connection-closes-early)
7. Either close and reopen Cygwin or ```source ~/.bash_profile``` to pick up the changes you just made
8. Test to see that ansible is working

     ```
     ansible --version  
     ```
[https://servercheck.in/blog/running-ansible-within-windows]

Alternately you can use a linux VM as your control machine to run Ansible playbooks.

Installation for Linux
======================
Install 'ansible' from your favourite package manager.  Really, that's it!

Configuring Logging
===================
Ansible also has built-in support for logging. Add the following lines to your ansible configuration file:

```
[defaults] 
log_path=/path/to/logfile
```
Ansible will look in several places for the config file:


* ansible.cfg in the current directory where you ran ansible-playbook
* ~/.ansible.cfg
* /etc/ansible/ansible.cfg

Known Issues
============
## 1. Connection closes early
Occassionally you'll see
```
GATHERING FACTS ***************************************************************
fatal: [192.168.33.11] => SSH encountered an unknown error during the connection. We recommend you re-run the command using -vvvv, which will enable SSH debugging output to help diagnose the issue
```
or something like
```
fatal: [192.168.33.11] => failed to transfer file to /root/.ansible/tmp/ansible-tmp-1404920107.71-206926197576774/yum:

mm_send_fd: sendmsg(2): Broken pipe
mux_client_request_session: send fds failed
Connection closed
```
This appears to be temporary so a naive workaround is to just try again.  If you experience this continuously with Cygwin it seems to be caused by a [known issue with OpenSSH on Windows](https://bugzilla.mindrot.org/show_bug.cgi?id=1278).

The solution is to turn off the ControlMaster in ssh.  You can set that in your ansible configuration file:
```
[ssh_connection]
ssh_args = -o ControlMaster=no
```
Ansible will look in several places for the config file:
* ansible.cfg in the current directory where you ran ansible-playbook
* ~/.ansible.cfg
* /etc/ansible/ansible.cfg

## 2. Timing vulnerabilities when used with pycrypto
If you run Ansible from a Centos 6.5 control you may see
```
[WARNING]: The version of gmp you have installed has a known issue regarding
==> dmp: timing vulnerabilities when used with pycrypto. If possible, you should update
==> dmp: it (ie. yum update gmp).
```
At the time of writing the latest gmp available on Centos 6.5 does not solve the problem.
