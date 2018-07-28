# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

directory node['redis']['home'] do
  mode "0755"
  recursive true
end

if node['platform_family'] == 'rhel'
  ['redis', 'redis-trib'].each {|p| package p}
else

  # the redis version on ubuntu is ancient, this one is more up-to-date
  apt_repository 'redis-server' do
    uri 'ppa:chris-lea/redis-server'
    distribution node['lsb']['codename']
  end
  
  ['redis-server', 'ruby'].each {|p| package p}

  gem_package 'redis'

  # sadly, this file is not available in a debian package
  cookbook_file '/usr/bin/redis-trib' do
    # using http, classy!
    source 'redis-trib.rb'
    mode '0755'
  end
  
end



