# myenv
My console environment with fish, vim, tmux and others ...

All automation script are POSIX Shell Compliant, the bootstrap will follow XDG.

Trying to follow KISS

## Getting started

`curl -L github.com/jeremiejig/myenv/raw/master/bin/bootstrap | sh`

`wget -O - github.com/jeremiejig/myenv/raw/master/bin/bootstrap | sh`

## Project Structure

### Script dependencies

The fewer the better

Basic Unix dependencies `ls, mv, cp, awk, sed ...` using only posix definition

Bootstrapping need git.

### Directory Structure

Each folder is a module, `myenv` will do the heavy lifting.

#### Installation process of a module

foreach module files the following steps are followed: 

* install/ script will be launched
* copy from `copy/` 
* link against `link/` (each folder will be mkdir)
* And finally any executable .sh files will be launched from `init`

```
template/
├── README.md
├── copy
│   └── dot.programrc
├── init
│   └── initscript.sh
├── install
│   ├── apt
│   ├── yum
│   ├── pkg
│   └── yaourt
└── link
    └── dot.program.conf
```

#### The *myenv* module

This module will do most of the work, the goal is to have all other module with minimalist script.

The myenv module will read ".config/myenv/dotfiles" to get the list of modules to install.

```tree
├── bootstrap			(Bootstrap myenv with git clone)
├── copy
│   └── dot.config
│       └── myenv
│           └── dotfiles	(Default configuration)
├── init
│   └── install
└── install
    └── install
```
