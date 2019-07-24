#!/bin/bash
if  [ -z "$1" ]
then
  echo "$0: you need to specify env: test, dev, stg, prod"
  exit 1
fi
"${1}eksctl.sh" create cluster --name="dev-analytics-kube-${1}" --nodes=3 --nodegroup-name="dev-analytics-ng-devstats-${1}" --node-labels "lfda=devstats,node=devstats" --node-type=m5.2xlarge --kubeconfig="/root/.kube/kubeconfig_${1}" --tags "env=${1}" --node-volume-type=gp2 --node-volume-size=20 --version=1.13 --node-ami=auto --ssh-access
"${1}eksctl.sh" create nodegroup --cluster="dev-analytics-kube-${1}" --nodes=5 --name="dev-analytics-ng-elastic-${1}" --node-type=i3.large --node-labels "lfda=elastic,node=elastic" --node-volume-type=gp2 --node-volume-size=20 --version=1.13 --node-ami=auto --ssh-access
"${1}eksctl.sh" create nodegroup --cluster="dev-analytics-kube-${1}" --nodes=2 --name="dev-analytics-ng-grimoire-${1}" --node-type=m5d.2xlarge --node-labels "lfda=grimoire,node=grimoire" --node-volume-type=gp2 --node-volume-size=20 --version=1.13 --node-ami=auto --ssh-access
"${1}eksctl.sh" create nodegroup --cluster="dev-analytics-kube-${1}" --nodes=2 --name="dev-analytics-ng-app-${1}" --node-type=t3.large --node-labels "lfda=app,node=app" --node-volume-type=gp2 --node-volume-size=20 --version=1.13 --node-ami=auto --ssh-access