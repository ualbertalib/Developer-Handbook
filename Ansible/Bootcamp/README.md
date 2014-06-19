Ansible Bootcamp
================

##Preamble

We're going to use a simple PHP guestbook application as the exemplar for writing and running Ansible playbooks. Forgive its crude nature. It's purpose is to allow visitors to a site to leave comments.  The application takes values that are POSTed from a form and writes them to a datastore.  Any stored comments are printed on the guestbook.php page. 

Create a directory on your desktop called 'ansible'.  We'll assume that this is your current working directory.  We think it's a really good idea to practice version control.  Initialize this as a git working directory ```git init```

We'll assume that you have access to a running VM.  One will be assigned to you at the bootcamp.  You may choose to create and manage a VM on your desktop.  One way to do this is to:


```
vagrant init centos6.5 //libroot/ITS_Share/vagrantboxes/golden_centos65-x86_64-20140609.box
sed -i'' '27 s/^#//' Vagrantfile # uncomment the private_network line
vagrant up
```

In this case you will be working with a VM with the IP 192.168.33.10

To destroy and start fresh

```
vagrant destroy
vagrant up
```

##Tasks

###1. Install basic php application by hand ([[Solutions](solutions/1)](solutions/1))

  Before you write your first playbook it will be really useful to understand what we're trying to accomplish.  Deploy [guestbook-1.0.tar.gz](https://github.com/pgwillia/guestbook/releases/tag/v1.0) in Apache (httpd).

  Success is when you can visit http://hostname/guestbook.php and interact with the application.  Bonus marks for writing an acceptance test suite.

  Save your history ```history -w /path/to/somewhere/useful``` Now might be a good time to commit your work to git.

###2. Install basic php application with playbook ([Solutions](solutions/2))

  Okay, great! You know how to install this php application.  Now we need to automate this process so that anyone in our group from any workstation can repeat this process.  We're going to use Ansible. 

 * You'll need an [inventory file](http://docs.ansible.com/intro_inventory.html) [dev].
 * You'll need a [playbook](http://docs.ansible.com/playbooks_intro.html#playbook-language-example) [guestbook.yml].
 * Hints ([loops](http://docs.ansible.com/playbooks_loops.html#standard-loops), [yum](http://docs.ansible.com/yum_module.html), [file](http://docs.ansible.com/file_module.html), [get_url](http://docs.ansible.com/get_url_module.html), [unarchive](http://docs.ansible.com/unarchive_module.html), [git](http://docs.ansible.com/git_module.html), [service](http://docs.ansible.com/service_module.html))

 Success is when you can run ``` ansible-playbook -i dev guestbook.yml ``` and pass the test suite from part 1. 
 
 Now might be a good time to commit your work to git.

###3. Install mysql php application by hand ([Solutions](solutions/3))

  We're going to make this a little more complicated and introduce a MySQL backing store. You can start from a fresh VM or use your playbook -- your choice.

  Success is when you can visit http://hostname/guestbook.php and interact with the application.  Bonus marks for modifications to the test suite from 1. 

  Now might be a good time to commit your work to git.

###4. Install mysql php application with playbook ([Solutions](solutions/4))
  Cool!  Now automate it using Ansible.  Ignoring best practices doesn't cut it anymore either.  You'll have to refactor your guestbook.yml if you haven't already.

  * You'll need at least httpd, mysql, php and guestbook [roles](http://docs.ansible.com/playbooks_roles.html#roles)
  * You'll need at least one [handler](http://docs.ansible.com/playbooks_intro.html#handlers-running-operations-on-change)
  * You'll need at least one [template](http://docs.ansible.com/playbooks_variables.html#using-variables-about-jinja2) 
  * Hints ([mysql_db](http://docs.ansible.com/mysql_db_module.html), [mysql_user](http://docs.ansible.com/mysql_user_module.html))

  Success is when you can run ``` ansible-playbook -i dev guestbook.yml ``` or site.yml and pass the test suite from part 3.

  Now might be a good time to commit your work to git.

###5. Advanced Topics
  * [group/host](http://docs.ansible.com/playbooks_best_practices.html#group-and-host-variables) [variables](http://docs.ansible.com/intro_inventory.html#splitting-out-host-and-group-specific-data) or [role variables](http://docs.ansible.com/playbooks_variables.html#variable-file-separation)
  * [tags](http://docs.ansible.com/playbooks_tags.html)
  * encryption with [ansible-vault](http://docs.ansible.com/playbooks_vault.html)
  * [ansible-galaxy](http://docs.ansible.com/galaxy.html)
