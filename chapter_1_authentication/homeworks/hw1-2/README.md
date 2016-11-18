# M310: MongDB Security
## Chapter 1: homework 1.2

For this lab you are going to take a running replica set (that doesn't have authorization enabled) and are going to enable authorization on it.

Continue to use the VM we've provided via Vagrant from Homework 1.1.
You do not neet to re-provision the VM.
This time we've provided you with some scripts.
You'll need to copy those to the shared folder created by Vagrant.

To start up and connect to the VM run the following commands:

```
$ cd m310-vagrant-env
$ vagrant up
$ vagrant ssh database
```

One of the provided scripts creates a replica set with authorization disabled.

After you've copied the handout scripts into the shared folder, run the following commands inside the VM in order to start the replica set.

```
$ cd ~/shared
$ ./setup-hw-1.2.sh
```

You can inspect `setup-hw-1.2.sh` to see the parameters used to set up the replica set, but for convenience here's that information.

| Type | Primary | Secondary | Secondary |
| --- | --- | --- | --- |
| Port | 31120 | 31121 | 31122 |
| DBPath | ~/M310-HW-1.2/r0 | ~/M310-HW-1.2/r1 | ~/M310-HW-1.2/r2 |
| LogPath | ~/M310-HW-1.2/r0/mongodb.log | ~/M310-HW-1.2/r1/mongodb.log | ~/M310-HW-1.2/r2/mongodb.log |

In order to enable authentication on this running replica set you're going to need to figure out how to perform the following tasks.

- Create a keyfile to use for internal authentication between the members of the replica set.
- Safely shutdown each member of the replica set, starting with the secondaries to prevent any rollbacks.
- Starting with the primary, restart each member using the shared keyfile you generated.
- Finally, create a user with the root role with the username **admin** and the password **webscale** on the admin database.

Note: If you don't create a user with these credentials, you will not get the correct output for submitting your answer.

After you've enabled authentication on the replica set you can run the following script and copy the output into the submission area below.

```
$ cd ~/shared
$ ./validate-hw-1.2.sh
```

Note: At least one of the lines of the **correct output** will contain an `errmsg`.
This is expected.
Also, make sure that there are 6 lines of output.
If you have one single line of output you'll need to add line breaks after each object to make it 6 seperate lines.

*Answer: dsa*