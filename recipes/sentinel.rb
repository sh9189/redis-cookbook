#
# Cookbook: redis
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
poise_service_user node['redis']['service_user'] do
  shell '/bin/bash'
  group node['redis']['service_group']
end

redis_installation node['redis']['service_name'] do
  version ''
end

config = redis_sentinel_config node['redis']['sentinel']['config']['path'] do
  owner node['redis']['service_owner']
  group node['redis']['service_group']
  node['redis']['sentinel']['config'].each_pair { |k, v| send(k, v) }
end

redis_instance node['redis']['sentinel']['service_name'] do
  config_file config.path
  command "#{install.sentinel_program} #{config_file}"

  user node['redis']['service_user']
  group node['redis']['service_group']
end
