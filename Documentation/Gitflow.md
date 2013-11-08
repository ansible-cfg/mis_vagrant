# Gitflow and Vincent Driessen's branching model

### What you need to do after reading this:

  1. Look at [Vincent Driessen's branching model](http://nvie.com/posts/a-successful-git-branching-model/)
  2. Install [Gitflow](https://github.com/nvie/gitflow)
  3. Bookmark Gitflow [cheat sheat](http://danielkummer.github.io/git-flow-cheatsheet/)
  4. Bookmark all gitflow [arguments](https://github.com/nvie/gitflow/wiki/Command-Line-Arguments)


### We use gitflow to organize our git repo into the following groups of branches:

  - **origin/feature/my-feature:** 
    - Feature-specific development branch
    - Branch off from **develop**
    - Merge to **develop**
  - **origin/develop:**
    - tie up all features and other dev code. This is the factory where products get made
    - Merge to **release**
  - **origin/master:**
    - This is the live version, the end of production chain
  - **origin/release/my-version:**
    - Official release points
    - Branch off from **develop**
    - Merge to **master** and, if there's a fix, **develop**
  - **origin/hotfix/my-hotfix:**
    - Critical fixes to live version
    - Branch off from **master**
    - Merge to **master** and **develop**
    
You will find terminal commands to easily create, update, and push these branches on their [github page](https://github.com/nvie/gitflow)      
**NOTE**: Branch names should all be in **snake-case**, for instance: **DIR-506-wxnode-bg-integration**

### What we do with the branches:

- As soon as a feature is identified, an associated **feature** branch is created. `git flow feature start my-feature`
	- If you want somebody else to work on this feature as well, you can publish it to the repo:
		`git flow feature publish my-feature`
	- If you want to checkout a remote feature branch, these are the steps:
		- `git fetch; git checkout feature/my-feature`
	- If someone has made changes to your published feature and you want to get those changes in your local copy
		- `git fetch; git rebase origin/feature/my-feature`
- After a feature implementation is completed, we use gitflow to **finish** the branch and, thereby, merge it into the **develop** branch. 
	`git flow feature finish my-feature`
- From the **develop** branch, developers can choose which version to branch off to a **release**. 
	- to release a point in time of **develop**: `git flow release start version-name-like-1.0.0 some-commit-sha1-id`
	- to release the current state of **develop**: `git flow release start version-name-like-1.0.0`
	- to publish a release branch to repo: `git flow release publish version-name-like-1.0.0`
	
- On the **release** branch that hasn't gone live, bugs can be identified and sorted out by QA before going live. If bugs are found: 
	1. track the remote release branch by: `git flow release track version-name-like-1.0.0`
	2. apply the fix directly to the **release** branch and push back to **origin**

- From the **release** branch, if anything goes well, we move codes to **master** branch and get ready to go live. 
	1. `git tag release-name` 
	2. `git flow release finish my-release` will merge back to **develop** and **master**
	3. When the changes are pushed, we should use `git push --tags` to ensure the tags are pushed.
- If a critical issue occurs on the live version: 
 	
   1. create a **hotfix** branch to tackle that issue, `git flow hotfix start version-name-like-v1.0.0.1.2`.
   2. `git flow hotfix finish version-name-like-v1.0.0.1.2` will merge the fix to **master** to fix the crack that went live and then merges it back to **develop** to reflect the change.
   3. When the changes are pushed, we should use `git push --tags` to ensure the tags are pushed.
 
 
##### Things you need to know about git flow commands:

  - If using a git-flow command the name of the branch is not preceded by the command name like `feature/my-feature`:
    - git-flow: `git flow feature start my-feature`
    - git: `git checkout develop; git checkout -b feature/my-feature`

### Here's the visual presentation

  ![alt text](http://nvie.com/img/2009/12/Screen-shot-2009-12-24-at-11.32.03.png "Vincent Driessen branching")



