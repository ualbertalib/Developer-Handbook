[[Jenkins](https://jenkins.io)] is our continuous integration server. It is used to test builds, run unit test, deploy (to a VM) and run integration/performance tests. The instructions that follow are targeted to the Jenkins server running on the DI standup workstation.

Installation
===
Can/should be installed from your OSes package manager.  There are frequent updates so be sure to keep on top of these!

Plugins
===
 * GitHub Authentication plugin
 * GitHub Pull Request Builder
 * Rvm (depends on RVM installed for the jenkins user, other rails dependencies ie. sqlite/mysql, js runtime, bundler)

Authentication
===
Enable Global Security because it's just a good idea. Use the [Github Authentication Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Github+OAuth+Plugin).  This required a github user (@ditech-jenkins) to set up an [OAuth application in Github](https://github.com/settings/applications/new) and copy the requested values into the Global GitHub OAuth Settings. Select Matrix-based security and use the ualbertalib organization groups to assign permissions (hint ualbertalib*Developers can admin, any ualbertalib can configure and run jobs, and Anonymous is read only)


Configuring Jobs
===
Creating and configuring jobs can be done easily from the web ui. Jobs (new item) are useful for responding to changes in the software and environment to establish baselines and testing changes. It is typical to set up a job per-project which builds the project and runs at least unit tests. Jobs can be set up to store artifacts created from the builds or alert developers of unexpected results.
Typically
* our projects are GitHub projects and our source code can be found in https://github.com/ualbertalib
* to build pull requests the Refspec is ```+refs/pull/*:refs/remotes/origin/pr/*``` the branch specifier is ${ghprbActualCommit} (or ${sha1})
* we run the build in a RVM-managed environment
* execute shell to run builds
    
    ```
    bundle install
    bundle exec rake db:migrate RAILS_ENV=test
    bundle exec rake rubocop
    bundle exec rake spec
    ```

GitHub Pull Request Builder
===
[This plugin](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+pull+request+builder+plugin) builds pull requests in github and report results. 

To set this up for use
* created @ditech-jenkins github user who is a member of the ualbertalib org and Developer team
* configure jenkins system
 * create token for Github API (and test credentials)
* configure job
 *  to use the "Github pull request builder" build trigger
   *  whitelist the ualbertalib org for the job
 *  to use the "Set status for GitHub commit" post build action

When this is configured correctly new pull requests will run the jobs automatically and report the results in the pull request on github. The @ditech-jenkins user will also respond to the following commands

* When a new pull request is opened in the project and the author of the pull request isn't white-listed, builder will ask "Can one of the admins verify this patch?".
* "ok to test" to accept this pull request for testing
* "test this please" for a one time test run
* "add to whitelist" to add the author to the whitelist
* If the build fails for other various reasons you can rebuild: "retest this please" to start a new build


