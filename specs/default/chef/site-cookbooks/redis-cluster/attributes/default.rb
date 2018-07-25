# Redis Cluster for clients to use
default['redis']['cluster_name'] = node['cyclecloud']['cluster']['id']

# Client configuration file (alternately use: jetpack config redis.hostlist)
default['redis']['hostlist'] = []
default['redis']['hostfile'] = File.join(node['cyclecloud']['home'], "config", "redis_hosts.txt")


# Server settings
default['redis']['home'] = "/mnt/scratch/redis"
default['redis']['version'] = '3.2.6'
default['redis']['source'] = "redis-3.2.6.tar.gz"


default['redis']['cluster_size'] = 1
default['redis']['base_port'] = 7000
default['redis']['server_slots'] = 4
default['redis']['replicas'] = nil
default['redis']['mb_per_slot'] = 4000
default['redis']['cluster-node-timeout'] = 5000

default['redis']['sysctl']['vm']['overcommit_memory'] = 1
default['redis']['sysctl']['net']['core']['somaxconn'] = 512
