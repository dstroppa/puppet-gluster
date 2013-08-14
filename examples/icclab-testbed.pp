# gluster::wrapper example
# This is the recommended way of using puppet-gluster.
# NOTE: I have broken down the trees into pieces to make them easier to read.
# You can do it exactly like this, use giant trees, or even generate the tree
# using your favourite puppet tool.
# NOTE: These tree objects are actually just nested ruby hashes.

$brick11 = {
	dev => '/dev/sdb',	# /dev/sda
	labeltype => 'gpt',
	fstype => 'xfs',
	fsuuid => '1ae49642-7f34-4886-8d23-685d13867fb1',
	xfs_inode64 => true,
	xfs_nobarrier => true,
	areyousure => true
}

$brick12 = {
	dev => '/dev/sdc',	# /dev/sdb
	labeltype => 'gpt',
	fstype => 'xfs',
	fsuuid => '1c9ee010-9cd1-4d81-9a73-f0788d5b3e33',
	xfs_inode64 => true,
	xfs_nobarrier => true,
	areyousure => true
}

$brick21 = {
	dev => '/dev/sdb',	# /dev/sdc
	labeltype => 'gpt',
	fstype => 'xfs',
	fsuuid => '2affe5e3-c10d-4d42-a887-cf8993a6c7b5',
	xfs_inode64 => true,
	xfs_nobarrier => true,
	areyousure => true
}

$brick22 = {
	dev => '/dev/sdc',	# /dev/sdd
	labeltype => 'gpt',
	fstype => 'xfs',
	fsuuid => '2c434d6c-7800-4eec-9121-483bee2336f6',
	xfs_inode64 => true,
	xfs_nobarrier => true,
	areyousure => true
}

$brick31 = {
	dev => '/dev/sdb',	# /dev/sdc
	labeltype => 'gpt',
	fstype => 'xfs',
	fsuuid => '3b79d76b-a519-493c-9f21-ca35524187ef',
	xfs_inode64 => true,
	xfs_nobarrier => true,
	areyousure => true
}

$brick32 = {
	dev => '/dev/sdc',	# /dev/sdd
	labeltype => 'gpt',
	fstype => 'xfs',
	fsuuid => '3d125f8a-c3c3-490d-a606-453401e9bc21',
	xfs_inode64 => true,
	xfs_nobarrier => true,
	areyousure => true
}

$brick41 = {
    dev => '/dev/sdb',
    labeltype => 'gpt',
    fstype => 'xfs',
    fsuuid => '4bf21ae6-06a0-44ad-ab48-ea23417e4e44',
    xfs_inode64 => true,
    xfs_nobarrier => true,
    areyousure => true
}

$brick42 = {
    dev => '/dev/sdc',	# /dev/sdd
    labeltype => 'gpt',
    fstype => 'xfs',
    fsuuid => '4dfa7e50-2315-44d3-909b-8e9423def6e5',
    xfs_inode64 => true,
    xfs_nobarrier => true,
    areyousure => true
}

$nodetree = {
	'gluster-node1.test' => {
		'ip' => '192.168.1.61',
		'uuid' => '1f660ca2-2c78-4aa0-8f4d-21608218c69c',
		'bricks' => {
			'/mnt/brick11' => $brick11,
			'/mnt/brick12' => $brick12
		}
	},
#	'gluster-node2.test' => {
#		'ip' => '192.168.1.62',
#		'uuid' => '2fbe6e2f-f6bc-4c2d-a301-62fa90c459f8',
#		'bricks' => {
#			'/mnt/brick2a' => $brick2a,
#			'/mnt/brick2c' => $brick2c
#		}
#	},
#	'gluster-node3.test' => {
#		'ip' => '192.168.1.63',
#		'uuid' => '3f5a86fd-6956-46ca-bb80-65278dc5b945',
#		'bricks' => {
#			'/mnt/brick3b' => $brick3b,
#			'/mnt/brick3d' => $brick3d
#		}
#	},
    'gluster-node4.test' => {
        'ip' => '192.168.1.64',
        'uuid' => '4f8e3157-e1e3-4f13-b9a8-51e933d53915',
        'bricks' => {
            '/mnt/brick41' => $brick41,
            '/mnt/brick42' => $brick42
        }
    }
}

$volumetree = {
	'vol_icclab' => {
		'transport' => 'tcp',
		'replica' => 2,
		'clients' => ['192.168.1.100'],	# for the auth.allow and $FW
        'start' => true
		# NOTE: if you *don't* specify a bricks argument, the full list
		# of bricks above will be used for your new volume. This is the
		# usual thing that you want to do. Alternatively you can choose
		# your own bricks[] if you're doing something special or weird!
		#'bricks' => [],
	}
}

class { 'gluster::wrapper':
  nodetree => $nodetree,
  volumetree => $volumetree,
  vip => '192.168.1.80'
}

