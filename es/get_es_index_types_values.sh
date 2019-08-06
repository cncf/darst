#!/bin/bash
if  [ -z "$1" ]
then
  echo "$0: you need to specify env: test, dev, stg, prod"
  exit 1
fi
if [ -z "$2" ]
then
  echo "$0: please provide index name as a second argument"
  exit 1
fi
if [ -z "$3" ]
then
  echo "$0: please provide type name as a thirs argument"
  exit 2
fi
if [ -z "${ES_URL}" ]
then
  ES_URL='elasticsearch-master.dev-analytics-elasticsearch:9200'
fi
"${1}k.sh" run --generator=run-pod/v1 curl-test-es -i --tty --restart=Never --rm --image="radial/busyboxplus:curl" -- /usr/bin/curl -XGET "${ES_URL}/${2}/${3}/_search?pretty"
