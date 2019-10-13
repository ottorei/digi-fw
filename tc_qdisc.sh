#!/bin/bash

wan_iface="enp8s0f0"
lan_iface="enp8s0f1"
up=9900
down=9900
tc=/sbin/tc
egress="fq_codel noecn flows 2048 target 5ms"
ingress="fq_codel noecn flows 2048 target 5ms"

echo Deleting old qdiscs ...
tc qdisc del dev ${wan_iface} root
tc qdisc del dev ${lan_iface} root

echo Adding new qdiscs ...

echo EGRESS ..
$tc qdisc add dev ${wan_iface} root handle 1:0 hfsc default 1
$tc class add dev ${wan_iface} parent 1:0 classid 1:1 hfsc ls rate ${up}mbit ul rate ${up}mbit
$tc qdisc add dev ${wan_iface} parent 1:1 handle 2: ${egress}

echo INGRESS ..
$tc qdisc add dev ${lan_iface} root handle 1:0 hfsc default 1
$tc class add dev ${lan_iface} parent 1:0 classid 1:1 hfsc ls rate ${down}mbit ul rate ${down}mbit
$tc qdisc add dev ${lan_iface} parent 1:1 handle 2: ${ingress}

