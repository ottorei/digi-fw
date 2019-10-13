#!/bin/bash

vlan_addr=10.44.99.1/24
vtep_addr=45.154.112.1
iface=enp5s0f1
vlan=99
vxlan=99


# MANAGEMENT VLAN
ip link add link ${iface} name ${iface}.${vlan} type vlan id ${vlan}

# Add bridge
ip link add name br${vlan} type bridge

# Add VLAN99 to the bridge
ip link set ${iface}.${vlan} master br${vlan}

# Add VXLAN99
ip link add vxlan${vxlan} type vxlan id ${vxlan} dstport 4789 local ${vtep_addr} nolearning

# Add VXLAN99 to the bridge
ip link set vxlan${vxlan} master br${vlan}

# Set interfaces up
ip link set dev ${iface}.${vlan} up
ip link set dev br${vlan} up
ip link set dev vxlan${vxlan} up

# Add IP-address
ip addr add ${vlan_addr} dev br${vlan}


