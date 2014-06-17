Ansible is an IT automation tool. It can configure systems, deploy software, and orchestrate more advanced IT tasks such as 
continuous deployments or zero downtime rolling updates.

Installation for Windows 7
==========================
WARNING!!! Anisble does not technically support Windows as a control machine.  Here is the best workaround I've found:
1. Download and install Cygwin [https://cygwin.com/install.html].  Cygwin is a brilliant command line interface for Windows.  
It gives you access to all Windows utilities on your PATH and provides some missing useful linux tools compiled for Windows.  
If you're familar with the Linux command line then you will feel right at home with this on your desktop. You will need at 
least the following packages:
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
2. Download and install PyYAML and Jinja2 separately. I couldn't find them in Cygwin's installer: 
 1. Open Cygwin
 2. Download PyYAML:
    curl -O https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.10.tar.gz
 3. Download Jinja2:
    curl -O https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.6.tar.gz
 4. Untar both downloads:
    tar -xvf PyYAML-3.10.tar.gz && tar -xvf Jinja2-2.6.tar.gz
 5. Change directory into each of the expanded folders and run python setup.py install to install each package.
    cd PyYAML-3.10 && python setup.py install && cd ..
    cd Jinja2-2.6 && python setup.py install && cd ..
 6. Clone ansible from its repository on GitHub:
    git clone https://github.com/ansible/ansible /opt/ansible
 7. Checkout v1.6.2 (the latest available June 2014 in Centos6.5 repo)
    cd /opt/ansible && git checkout v1.6.2
 8. Add the following lines into your Cygwin .bash_profile.  Use ```vim ~/.bash_profile``` or 
 edit C:\cygwin\home\username\.bash_profile in your favourite editor.
    # Ansible settings
    ANSIBLE=/opt/ansible
    export PATH=$PATH:$ANSIBLE/bin
    export PYTHONPATH=$ANSIBLE/lib
    export ANSIBLE_LIBRARY=$ANSIBLE/library
 9. Either close and reopen Cygwin or ```source ~/.bash_profile``` to pick up the changes you just made
 10. Test to see that ansible is working
     ansible --version
[https://servercheck.in/blog/running-ansible-within-windows]

Alternately you can use a linux VM as your control machine to run Ansible playbooks.

Installation for Linux
======================
Install 'ansible' from your favourite package manager.  Really, that's it!
