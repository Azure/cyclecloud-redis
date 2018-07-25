name "redis_server"
description "Redis Server role"
run_list("recipe[redis-cluster::server]")

default_attributes(
  "cyclecloud" => { "discoverable" => true },
  "redis" => { "role" => "server",
               "ready" => true }
)
