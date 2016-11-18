# M310: MongDB Security
## Chapter 1: homework 1.1

In this first homework exercise we'd like for you to demonstrate that you're able to get a standalone server up and running with authentication enable.

Throughout this course we'll be using Vagrant as our environment for homework exercises.

Vagrant requires an hypervisor or virtual environment provider to operate. For this purpose we use VirtualBox.

Please check the installation and dependancy documentation or follow the getting started Vagrant tutorial for more information.

You'll also need to install the vagrant plugin `vagrant-vbguest`.

Let's bring up our Vagrant machine, available as part of the lesson handouts.

```
$ cd m310-vagrant-env
$ vagrant up
$ vagrant plugin install vagrant-vbguest
$ vagrant ssh database
```

For this exercise we want you to perform the following set of tasks:
- Launch `mongod` with no authentication enabled
- Create user `alice` with password `secret` on **admin** database and role **root**
- Relaunch `mongod` with authentication enabled
- Run command `db.runCommand({getParameter: 1, authenticationMechanism: 1})`

Which of the following statements will successfully run the above command on the standalone server that you've set up?
(Check all that apply)

- [x] `mongo admin -u alice -p secret --eval "db.runCommand({getParameter: 1, authenticationMechanism: 1})"`
- [ ] `mongo --eval "db.runCommand({getParameter: 1, authenticationMechanism: 1})"`
- [ ] `mongo -u alice -p secret --eval "db.runCommand({getParameter: 1, authenticationMechanism: 1})"`
- [ ] `mongo -u alice -p secret --eval "db.runCommand({getParameter: 1, authenticationMechanism: 1})" --authenticationDatabase admin`
- [x] `mongo admin --eval "db.auth('alice', 'secret');db.runCommand({getParameter: 1, authenticationMechanism: 1})"`
- [x] `mongo -u alice -p secret --eval "db=db.getSisterDB('admin');db.runCommand({getParameter: 1, authenticationMechanism: 1})" --authenticationDatabase admin`