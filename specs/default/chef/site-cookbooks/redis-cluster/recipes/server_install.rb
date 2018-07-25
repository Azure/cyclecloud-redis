include_recipe 'redis-cluster::default'

log "Configuring kernel for high memory redis application..." do level :info end
include_recipe 'sysctl::default'

execute "disable transparent_hugepage" do
  command "echo never > /tmp/transparent_hugepage.enabled; mv /tmp/transparent_hugepage.enabled /sys/kernel/mm/transparent_hugepage/enabled"
  only_if "grep -qv never /sys/kernel/mm/transparent_hugepage/enabled"
end

# rc.local is deprecated in centos, find something better
include_recipe 'line'
append_if_no_line "disable transparent_hugepage via rc.local" do
  path "/etc/rc.local"
  line "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
end

sysctl_param 'vm.overcommit_memory' do
    value node['redis']['sysctl']['vm']['overcommit_memory']
end

sysctl_param 'net.core.somaxconn' do
    value node['redis']['sysctl']['net']['core']['somaxconn']
end


