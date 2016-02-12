Scrum is an Agile Development methodology.

## Elements of Scrum in our Environment

### Sprints

We have settled into this pattern:

- sprints are two weeks long
- sprint meetings (in the DIT meeting room, Cameron Library 2-10B):
	- a sprint kickoff meeting, typically Monday 9:45-11:00
	- a sprint wrapup (combining the Scrum concepts of review and retrospective), typically Friday 10:00-12:00
	- a product backlog grooming meeting on alternate Wednesdays, 13:00-14:00 (in the week of a sprint kickoff) 
	- daily standups, 9:45-10:00, in the open seating area of DIT
	- a Birds of a Feather session, Fridays 14:00-15:00
- roles
	- the dev team (in Scrum terms) consists of the DITL, DIAL, and the four DIT developers, and for some purposes also the Metadata Team and the UNIX Team
	- the Scrum Master is the DITL (Peter Binkley)
	- the Product Owner is the AUL Information Resources and Digital Initiatives (Geoff Harder)
	- stakeholders include the other members of DIT and the Metadata Team in respect of their various areas of responsibility



### Product Backlog

The product backlog is managed in the Github repo using issues, milestones and labels. 

- Milestones are used for general groupings of issues, as well as for individual sprints
	- the current groupings are:
		- [Institutional Repository](https://github.com/ualbertalib/HydraNorth/milestones/Block:%20Institutional%20Repository)
		- [Digitization](https://github.com/ualbertalib/HydraNorth/milestones/Block:%20Digitization%20Phase)
		- [Future](https://github.com/ualbertalib/HydraNorth/milestones/Block:%20Digitization%20Phase)
		- [Technical Maintenance](https://github.com/ualbertalib/HydraNorth/milestones/Block:%20Technical%20Maintenance%20)
	- sprint milestones
		- have titles in the form "Sprint 34" (this is important since it is used by the burndown chart)
		- have a due date set to the date of the sprint wrapup meeting, normally the second Friday after the beginning of the sprint
		- contain all the issues to be worked on in that sprint, chosen in the sprint kickoff
- Burndown chart
	- javascript/D3-based chart using the Github API to pull milestone and issue metadata for the current sprint (see its [Github repo](https://github.com/pbinkley/burndown))
	- the current chart may be viewed at http://www.ualberta.ca/~pbinkley/burndown/?milestone=current
	- 
- Labels are used for other issue-level metadata. The most important are:
	- priority: we have labels priority:low, priority:medium, and priority:high, as well as priority:TBD
	- size: we have size:xsmall, size:small, size:medium, size:large, size:xlarge, as well as size:TBD
	- we also use epic for overviews of large blocks of work, which will be cut into several workable issues
- Flow
	- normally priority is set by the product owner and stakeholders, and size by the dev team
	- size is treated as a proxy for readiness for work: a large issue should not normally be put into a sprint to be worked on, but rather should be broken down into medium/small issues. The ideal sprint should consist of mostly (all?) small issues. 
	- at the sprint kickoff, issues to be worked on in that sprint are chosen based on: 
		- priority
		- readiness for work
		- sequencing dependencies
		- other considerations from the product owner, stakeholders, community and dev team (such as the desire to demonstrate a given feature etc. etc.)
	- families of issues that were broken out of a single large issue should be grouped by labels(?) and normally handled in the same sprint.
	- normally an issue is worked on in a branch whose name begins with the number of the issue, and leads to a pull request incorporating that branch. The PR should include a comment with "Fixes #xxx" so that the issue will automatically be closed when the PR is merged. When the PR is merged, the branch should be deleted (it can always be restored if needed).
