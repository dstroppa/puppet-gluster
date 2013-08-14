# gluster::client example
# This is the recommended way of mounting puppet-gluster.
# NOTE: It makes sense to use the VIP as the server to mount from, since it
# stays HA if one of the other nodes goes down.

# mount a share on one of the gluster hosts (note the added require)
$gluster_server_ip = '192.168.1.70'

class gluster_icclab_client {
  gluster::client { '/mnt/gluster':
      server => "${gluster_server_ip}:/vol_icclab",
      rw => true,
      mounted => true,
      #require => Gluster::Volume['gshared'],	# TODO: too bad this can't ensure it's started
  }
}

