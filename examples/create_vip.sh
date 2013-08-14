#!/bin/bash

set -x
set -e

echo -e "BOOTPROTO=static\nBROADCAST=192.168.1.255\nIPADDR=192.168.1.80\nNETMASK=255.255.255.0\nNETWORK=192.168.1.0\nONBOOT=yes\nTYPE=Ethernet" > /etc/sysconfig/network-scripts/ifcfg-eth1:0

/etc/init.d/network restart