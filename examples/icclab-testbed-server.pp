#
#	example of a distributed-replicate with four hosts, and two bricks each
#	NOTE: this should be put on *every* gluster host
#
$gluster_server_vip = '192.168.1.80'	# vip
$gluster_node_ip_1 = '192.168.1.61'
$gluster_node_ip_2 = '192.168.1.62'
$gluster_node_ip_3 = '192.168.1.63'

$some_client_ip = '192.168.1.100'

class gluster_icclab_testbed {

	class { 'gluster::server':
		hosts => ['gluster-node1.test', 'gluster-node2.test', 'gluster-node3.test'],
		ips => ["${gluster_node_ip_1}", "${gluster_node_ip_2}", "${gluster_node_ip_3}"],
		#vip => "${gluster_server_vip}",
		clients => [$some_client_ip],
		zone => 'loc',
		shorewall => true,
	}

	$brick_list = [
		'gluster-node1.test:/mnt/brick1',
		'gluster-node2.test:/mnt/brick1',
		'gluster-node3.test:/mnt/brick1',
		'gluster-node1.test:/mnt/brick2',
		'gluster-node2.test:/mnt/brick2',
		'gluster-node3.test:/mnt/brick2'
	]

	# TODO: have this run transactionally on *one* gluster host.
	gluster::volume { 'vol_icclab':
		replica => 3,
		bricks => $brick_list,
		start => true,
	}

	# namevar must be: <VOLNAME>#<KEY>
	gluster::volume::property { 'vol_icclab#auth.allow':
		value => '192.168.1.100',
	}

}
