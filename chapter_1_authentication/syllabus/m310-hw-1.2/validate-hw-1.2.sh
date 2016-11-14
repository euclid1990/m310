#!/bin/bash

ports=(31120 31121 31122)

username="admin"
password="webscale"

statusStr="rs.status()"
memberStr="db = db.getSisterDB('admin');
           db.auth('$username', '$password');
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
