Developer-Handbook
==================

Single source of documentation for the University of Alberta Libraries developers common tools and practices

* [Version Control](#version-control)
  * [Github](Github/README.md)  
* [SSH Keys](#ssh-keys)
* [DevOps](#devops)
* [Configuration Management](#configuration-management)
  * [Ansible](Ansible/README.md)
  * [Docker](Docker/README.md)
* [Continuous Integration](Jenkins/README.md)
* [Rails](RubyonRails/README.md)
* [Miscellaneous](Miscellaneous/README.md)
  * [Personnel](Personnel/README.md)

Version Control
---------------
Version control is important to our operation
 * integration with other developers work
 * manages change history
 * can revert working copy to a previous working state
 * tag releases
 * backup

Github https://github.com/ualbertalib  
Ops managed Github https://code.library.ualberta.ca/gitweb/ -- requires Network login / Windows credentials

SSH Keys
--------
The Secure Shell (SSH) Protocol is a protocol for secure remote login and other secure network services over an insecure network. [[The Secure Shell (SSH) Protocol Architecture](http://www.ietf.org/rfc/rfc4251.txt)]

The recommended way to authenticate and communicate over ssh is through public/private key pairs. You share your public key with a server and it is stored in .ssh/authorized_keys.  Keep your private key secret and on your desktop machine (in your ~/.ssh/ directory).

These keys can be created with Linux command-line tools. In a Windows environment, they can be created using the equivalent tools in [[Cygwin](https://www.cygwin.com/)].  If you have already created a key pair with PuttyGen and shared it with the sysadmins, you can convert it to the necessary OpenSSH-style keys by following [these instructions](http://stackoverflow.com/questions/2224066/how-to-convert-ssh-keypairs-generated-using-puttygenwindows-into-key-pairs-use#answer-2224204).

To create your keys: 

```ssh-keygen -t rsa ```

They are located 

```
ls ~/.ssh
id_rsa id_rsa.pub
```

To use these as credentials:

1. share your public key (**id_rsa.pub**) with your friendly neighborhood systems administrator
2. before attempting to login for the first time in a session, you must start the ssh agent and add your key (hint add this to your bash profile):
 
  ```
  eval `ssh-agent -s`
  ssh-add
  ``` 

3. to see which keys are currently loaded 

  ```
  ssh-add -l
  ```

In Windows you can [[use Pageant](http://the.earth.li/~sgtatham/putty/0.60/htmldoc/Chapter9.html#pageant)] to load your key for use by Putty.

DevOps
------
DevOps means different things to different people.  To us it means Developers and Operations working together (Dev+Ops=DevOps) towards the same goal of putting quality applications in production as efficiently and painlessly as possible.

###Dev/Test/Production
Once an application is 'working' it is deployed in dev, test, and prod environments. This facilitates the hand off between the Developer and Operations, by giving the Developer a production-like environment to build in, a test environment for developers and Operations to collaborate and practice on, and a production environment that is a known quantity to Operations because it's been proven.

####Development Environment
 * developers have sudo privileges
 * some software probably installed from version control
 * if depends on services like MySQL, these probably exist on the same machine
 * working towards headless installation/configuration using configuration management software
 * may be 'golden' vm on Developer desktop or vm provided by Operations for this purpose
 * no backups!

####User Acceptance Testing (UAT) Environment
 * developers may have sudo privileges
 * provisioned using Docker Images
 * may point to services (like MySQL) on external test server
 * primary purpose is to provide a platform to demo to stakeholders for acceptance and performance

####Production Environments
 * developers do not have sudo privileges
 * software installed from RPM
 * installed using configuration management software
 * point to services (like MySQL) on external production server (with backups and security)

When a bug or feature is identified which requires a change.

1. Identify which component(s) are affected.
2. Write test which identifies bug.
3. Write code which fixes bug.
4. Tests pass.
5. Update documentation
6. Commit to version control. (Everything is in version control!)
7. Build component 
  * this varies depending on component affected
    * ks requires rebuild of server
    * package requires rebuild of package
    * last mile script/recipe doesn't really require this step
8. Deploy/update component in 'test' environment
9. Tests pass
10. Change request for anything big (in accordance with ITIL principles)
11. Deploy/update component in 'prod' environment

