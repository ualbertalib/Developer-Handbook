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

Working Principles
=========
* Branch frequently; most branches are short-lived
* Use meaningful commit messages
* Squash commits into meaningful units
* When we use other people's code, we fork their repo and push changes back whenever possible
* We use GitHub issues to manage code changes
* We maintain links between commits and issues to enable the history of changes and decisions to be traced
* We use tags to manage the release cycle


