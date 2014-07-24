Developer-Handbook
==================

Single source of documentation for the University of Alberta Libraries developers common tools and practices

Version Control
---------------
Version control is important to our operation
 * integration with other developers work
 * manages change history
 * can revert working copy to a previous working state
 * tag releases
 * backup

Github https://github.com/ualbertalib  
Mercurial https://code.library.ualberta.ca/hg/ -- requires Network login / Windows credentials

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
DevOps means different things to different people.  To use it means Developers and Operations working together (Dev+Ops=DevOps) towards the same goal of putting quality applications in production as efficiently and painlessly as possible.

###Dev/Test/Production
Once an application is 'working' it is deployed in dev, test, and prod environments. This facilitates the hand off between the Developer and Operations, by giving the Developer a production-like environment to build in, a test environment for developers and Operations to collaborate and practice on, and a production environment that is a known quantity to Operations because it's been proven.

####Development Environment
 * developers have sudo privileges
 * some software probably installed from version control
 * if depends on services like MySQL, these probably exist on the same machine
 * working towards headless installation/configuration using configuration management software
 * may be 'golden' vm on Developer desktop or vm provided by Operations for this purpose
 * no backups!

**Using [Vagrant](Vagrant/README.md) to create a development environment on your workstation is recommended.**

####Test Environment
 * developers may have sudo privileges
 * software installed from RPM
 * installed using configuration management software
 * may point to services (like MySQL) on external test server
 * primary purpose is to run a battery of tests for acceptance and performance

####Production Environments
 * developers do not have sudo privileges
 * software installed from RPM
 * installed using configuration management software
 * point to services (like MySQL) on external production server (with backups and security)

###Configuration Management
The first time

1. Developer installs the application in a headless, automated way. This might be by writing a shell script, post-install section of [[Kickstart](http://www.centos.org/docs/5/html/Installation_Guide-en-US/ch-kickstart2.html)], or Ansible.  This is accompanied by a test suite.  This assumes the Developer starts from a 'golden' vm provided by or approved by the Operations team and recording EVERY step required for installation. This vm will likely be destroyed and built again from first principles several times.  In the end nothing will be done by hand. Installation is started and finished using only one command.
2. Developer demonstrates headless installation to Systems Administrator.  They have discussion about re-factoring this script and hardware requirements
   * what can/should use existing infrastructure or software
   * what can/should be packaged
     * source or binaries for a package should be published and available from a trusted source: official project home page, institution version control release tag
   * can/should be broken up further, what is the dependency tree?
   * what are the final mile steps that can't/shouldn't be packaged
     * probably contain username/passwords
     * probably use machine names/IP/hostnames
3. As re-factoring is completed the initial script from 1. is adjusted to reflect the current, working reality.  This could mean moving functionality from the installation script/recipe to the kickstart, or spec for an rpm.  Tests should continue to pass or be re-evaluated. 
4. When all discussed re-factoring is done (or it's time to ship) the work products should include a kickstart (ks), one or more spec files and supporting content to build rpms, a final mile configuration script/recipe (what remains of the inital script from 1) and a test suite. Developers and Operations should both be able to build and test from these product.  Operations owns the kickstart, Dev/Ops share ownership of rpms, Developers own the tests and final mile?

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

**Writing and running [Ansible](Ansible/README.md) playbooks is the recommended practice for deployment of applications.**

TODO
----
* Patterns
* GitHub - Peter's working on this in branch pb-github
* Code Style
* Testing
* Continuous Integration
