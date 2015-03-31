[[Github](https://github.com)] is our code repository. All of our code should be managed in Github
repositories. 
Our Organization Account
==============
The Libraries' GitHub organization account is [ualbertalib](https://github.com/ualbertalib). 

Within this account we set up teams. The [owners](https://github.com/orgs/ualbertalib/teams/owners) team has full permissions on all repositories in the account. The [ualbertalib](https://github.com/orgs/ualbertalib/teams/ualbertalib) team contains every member of the organization, and has read-write permissions. It should normally be assigned to a new repository, unless there is a need to limit permissions for some members of the organization.

For special purposes, smaller teams can be created and used. Under GitHub's model, permissions are assigned to teams, and then teams are assigned to repositories, and an individual's permissions on a repo depend on membership in assigned teams. For the ansible repository, for example, we have a sysadmins team with read-write permissions and a developers team with only read permissions. By assigning these two teams instead of the default ualbertalib team, we assign the appropriate permissions to the appropriate people.

Our account allows us a certain number of private repositories (currently 20). These should be used for sensitive projects, or legacy projects where public exposure is useless. Our default position should be open, so normally repos will be public unless there is a specific reason to keep them private.

Note that private repositories are only visible when you are logged in (otherwise you will get a 404). If you fork a private repository into your personal account, your fork will also be private and will not count against our quota. If a member is deleted from the organization account, any forks of private repos they have in their personal account will be deleted immediately. It is therefore important to make sure that any work in that repo be merged up into the main repo before the user is deleted.

Tools
========
* Command line tools
* GitHub for Windows
* GitHub for Mac

Common Tips
===========
Developing HydraNorth on a Vagrant VM with the Ansible playbook applied we're finding we need a workaround in order to checkout branches while maintaining config mangement values
* ignore permissions ```git config core.fileMode false```
* stash playbook changes ```git stash```
* checkout existing ```git checkout <branchname>``` or new ```git branch -b <branchname>``` branch you want to work on 
* apply stashed changes ```git stash apply```
* get latest branches from github ```git fetch```
* set user name(```git config --global user.name "your name"```) and email(```git config --global user.email your.email```) for new vm  
* set url for commits ```git remote set-url origin  https://your.login@github.com/ualbertalib/your.repository.git```

Checklist for merging Pull Requests
===================================
* do existing tests pass?
* is it tied to an issue and has a commit that closes that issue?
* are there tests for new functionality?
* does it meet the style guide for [ruby](https://github.com/bbatsov/ruby-style-guide) and [rails](https://github.com/bbatsov/rails-style-guide)?
* does it pass the [opportunistic OWASP checklist](https://www.owasp.org/images/5/58/OWASP_ASVS_Version_2.pdf) for security?

Working Principles
=========
##Branch frequently; most branches are short-lived

A normal repository will have a "master" branch, a "development" branch, and multiple short-lived "feature" branches. Developers work on feature branches, commiting as often as they like.

When features are completed, they are merged into the development branch with a pull request (PR). When it is time to release a version of the software, the development branch is merged into the master branch using a PR. PRs allow for another pair of eyes on a merge, without requiring a single authoritative gatekeeper.

When merging from feature to development, commits *can* be squashed (but
don't have to be). When merging from development into master, commits
should be squashed in order to maintain clear, readable history.

When merging branches, communication is key. Developers need to know
when a feature has been merged into development, so they can pull the
feature into their own codebase.

We need to figure out good practices around GitHub notifications, so
that we can filter out irrelevant information.

##Commit early and often to feature branches

We commit early so that our work is available to our peers for use and review as soon as possible.  We commit often because our work is organized into atomic units of incremental change.

##Use meaningful commit messages

Commit messages document the changes that we are introducing to the code base.  They should use present tense to describe why not what and include enough detail that someone unfamiliar to the project understands our change.

##Squash commits into meaningful units

It is good practice to squash commits when merging from a feature branch into a development branch, but there is no hard rule: some features may best be kept as a series of commits.

Squashing before pushing prevents problems. Pushing unsquashed commits to a feature branch is safe unless someone branches from a commit that subsequently gets squashed: so the working agreement has to be that feature branches are not intended to be the source of other branches (ie. branch from master or development branches).

Use "amend" and "-p" (patch) when appropriate.

How two or more developers can best work on a single feature will have to be worked out over time (we can imagine various scenarios).
 
##We use GitHub issues to manage code changes

GitHub issues allow us to communicate ideas and solutions in diagrams and plain language before and during development of features. This is a useful feature to solicit feedback from the team at all stages of development.

We maintain links between commits and issues to enable the history of changes and decisions to be traced.

##We, the Team, are responsible for the health of the code base

The entire team is responsible for the health of the code in version control.  That means that if we notice something is broken, out of date or wrong it is our responsibility to fix it or at least ensure that it is tracked by submitting an issue. Communication is very important. 

We will prevent developing an unhealthy code base by not knowingly committing and pushing broken code.  We should be running the accompanying test suite before pushing our changes to check for regresssions.  We should be writing tests for any functionality that we add. 

A continuous integration server like [Jenkins](http://cardiff.library.ualberta.ca/) could be a hub to monitor the health of the code base as each commit or merge is made.

##We use tags to denote the end of a release cycle

Our current thinking is that we will use Scrum and have two week Sprints.  Features completed during the sprint are merged to development and then master via pull requests.  The accepted PRs will be demoed at the sprint review. The decision to tag is the team’s, at the end of the sprint.

##When we use other people's code, we fork their repo and push changes back whenever possible

We acknowledge that we get further faster and longer by joining communities with similar interests. We will fork their code but stay in communication about issues and contribute upstream new features and bug fixes that are useful to the community whenever possible.
