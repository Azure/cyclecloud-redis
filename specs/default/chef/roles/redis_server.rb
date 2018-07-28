# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

name "redis_server"
description "Redis Server role"
run_list("recipe[redis-cluster::server]")

default_attributes(
  "cyclecloud" => { "discoverable" => true },
  "redis" => { "role" => "server",
               "ready" => true }
)
