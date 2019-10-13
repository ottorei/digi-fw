#!/bin/bash

up_speed=9900
down_speed=9900
lan_iface=enp8s0f1
wan_iface=enp8s0f0

tc qdisc del dev ${lan_iface} root
tc qdisc del dev ${wan_iface} root

tc qdisc add dev ${lan_iface} root cake bandwidth ${down_speed}Mbit ethernet ether-vlan internet triple-isolate no-split-gso
tc qdisc add dev ${wan_iface} root cake bandwidth ${up_speed}Mbit ethernet ether-vlan internet triple-isolate no-split-gso
