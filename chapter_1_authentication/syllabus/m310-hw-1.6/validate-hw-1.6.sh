#!/bin/bash

ports=(31160 31161 31162)

username="adam"
password="webscale"

statusStr="rs.status()"
memberStr="db = db.getSisterDB('\$external');
           db.auth({
             mechanism: 'PLAIN',
             user: '$username',
             pwd: '$password',
             digestPassword: false
           });
           var status = rs.status();
           var members = status.members.map((member) => (member.name));
           var statuses = status.members.map((member) => (member.stateStr)).sort();
           print(JSON.stringify({members, statuses}));"

function mongoEval {
  local port=$1
  local script=$2
  echo `mongo --quiet --port $port --eval "$script"`
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
