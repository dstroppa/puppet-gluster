#
#	example of a distributed-replicate with four hosts, and two bricks each
#	NOTE: this should be put on *every* gluster host
#

class icclab_testbed_node {

	gluster::host { '${fqdn}':
		# use uuidgen to make these
		uuid => '1f660ca2-2c78-4aa0-8f4d-21608218c69c',
	}

	gluster::brick { '${fqdn}:/mnt/brick1':
		dev => '/dev/sdb',	# /dev/sda
		labeltype => 'gpt',
		fstype => 'xfs',
		fsuuid => '1ae49642-7f34-4886-8d23-685d13867fb1',
		xfs_inode64 => true,
		xfs_nobarrier => true,
		areyousure => true,
	}

	gluster::brick { '${fqdn}:/mnt/brick2':
		dev => '/dev/sdc',	# /dev/sdb
		labeltype => 'gpt',
		fstype => 'xfs',
		fsuuid => '1c9ee010-9cd1-4d81-9a73-f0788d5b3e33',
		xfs_inode64 => true,
		xfs_nobarrier => true,
		areyousure => true,
	}
}
