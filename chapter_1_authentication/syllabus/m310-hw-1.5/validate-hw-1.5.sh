#!/bin/bash

ports=(31150 31151 31152)

username="will"
password="\$uperAdmin"

statusStr="rs.status()"
memberStr="db = db.getSisterDB('admin');
           db.auth('$username', '$password');
           var status = rs.status();
           var members = status.members.map((member) => (member.name));
           var statuses = status.members.map((member) => (member.stateStr)).sort();
           print(JSON.stringify({members, statuses}));"
userStr="db = db.getSisterDB('\$external');
         db.auth({
           mechanism: 'MONGODB-X509',
           user: 'C=US,ST=New York,L=New York City,O=MongoDB,OU=University2,CN=M310 Client'
         });
         db = db.getSisterDB('admin');
         var users = db.system.users.find().toArray();
         var userData = users.map((user) => ({_id: user._id, roles: user.roles}));
         print(JSON.stringify(userData));"

function mongoEval {
  local port=$1
  local script=$2
  echo `mongo --quiet --host database.m310.mongodb.university --ssl --sslPEMKeyFile ~/shared/certs/client.pem --sslCAFile ~/shared/certs/ca.pem --port $port --eval "$script"`
}

function getStatus {
  local port=$1
  echo $(mongoEval $port "$statusStr")
}

function getMembers {
  local port=$1
  echo $(mongoEval $port "$memberStr")
}

function getUsers {
  local port=$1
  echo $(mongoEval $port "$userStr")
}

for port in "${ports[@]}"; do
  getStatus $port
  getMembers $port
done

getUsers ${ports[0]}
