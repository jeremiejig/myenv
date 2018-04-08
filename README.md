# myenv
My console environment with fish, vim, tmux and others ...

All automation script are POSIX Shell Compliant, the bootstrap will follow XDG.

## Script dependencies

Basic Unix dependencies `ls, mv, cp, awk`

## Install
`curl -L github.com/jeremiejig/myenv/raw/master/bin/bootstrap | sh`

`wget -O - github.com/jeremiejig/myenv/raw/master/bin/bootstrap | sh`

## Directory Structure

Each folder is a module, `myenv` will do the heavy lifting

## Installation process of a module

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

