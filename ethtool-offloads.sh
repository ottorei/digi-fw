#!/bin/bash

/sbin/ethtool -K enp5s0f0 rxvlan on txvlan on rx on tx on tso off gso off gro off lro off
/sbin/ethtool -K enp5s0f1 rxvlan on txvlan on rx on tx on tso off gso off gro off lro off
