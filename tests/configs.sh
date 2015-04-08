#!/bin/bash

VERSIONS="9.2 9.3 9.4"

function docker_rm {
  docker stop postgres > /dev/null 2&>1
  docker rm postgres > /dev/null 2&>1
}

for i in $VERSIONS;
do
  docker_rm
  docker run -d --name postgres postgres:$i
  sleep 10
  docker cp postgres:/var/lib/postgresql/data/postgresql.conf .
  mv postgresql.conf $i.conf
  grep ^#.*=.* $i.conf | sed 's/^#//' | sed 's/#.*$//' > $i-min.conf
  docker_rm
done

