#!/bin/bash

ports=(31130 31131 31132)

statusStr="rs.status()"
memberStr="db = db.getSisterDB('\$external');
           db.auth({
             mechanism: 'MONGODB-X509',
             user: 'C=US,ST=New York,L=New York City,O=MongoDB,OU=University2,CN=M310 Client'
           });
           var status = rs.status();
           var members = status.members.map((member) => (member.name));
           var statuses = status.members.map((member) => (member.stateStr)).sort();
           print(JSON.stringify({members, statuses}));"

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

for port in "${ports[@]}"; do
  getStatus $port
  getMembers $port
done
