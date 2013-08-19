#!/bin/bash

set -x
set -e

# add hosts to /etc/hosts
grep -q "gluster-node1" /etc/hosts || echo "192.168.1.61	gluster-node1 gluster-node1.test" >> /etc/hosts
#grep -q "gluster-node2" /etc/hosts || echo "192.168.1.62	gluster-node2 gluster-node2.test" >> /etc/hosts
#grep -q "gluster-node3" /etc/hosts || echo "192.168.1.63	gluster-node3 gluster-node3.test" >> /etc/hosts
grep -q "gluster-node4" /etc/hosts || echo "192.168.1.64	gluster-node4 gluster-node4.test" >> /etc/hosts