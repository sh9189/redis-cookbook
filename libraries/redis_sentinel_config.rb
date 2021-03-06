#
# Cookbook: redis
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
require 'poise'

module RedisCookbook
  module Resource
    # A `redis_sentinel_config` resource to manage the Redis Sentinel
    # configuration of a node.
    # @provides redis_sentinel_config
    # @action create
    # @action delete
    # @since 2.0
    class RedisSentinelConfig < Chef::Resource
      include Poise(parent: :redis_instance, fused: true)
      provides(:redis_sentinel_config)

      attribute('', template: true, default_source: 'redis.conf.erb')
      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:owner, kind_of: String, default: lazy { parent.user })
      attribute(:group, kind_of: String, default: lazy { parent.group })
      attribute(:mode, kind_of: String, default: '0440')

      # @see: https://github.com/antirez/redis/blob/3.2/sentinel.conf
      attribute(:directory, kind_of: String, default: lazy { parent.directory })
      attribute(:logfile, kind_of: String, default: lazy { parent.logfile })
      attribute(:sentinel_port, kind_of: Integer, default: 26_379)
      attribute(:sentinel_master_name, kind_of: String, default: 'mymaster')
      attribute(:sentinel_monitor, kind_of: String, default: '127.0.0.1 6379 2')
      attribute(:sentinel_auth, kind_of: String, default: 'changeme')
      attribute(:sentinel_down, kind_of: Integer, default: 30_000)
      attribute(:sentinel_parallel, kind_of: Integer, default: 1)
      attribute(:sentinel_failover, kind_of: Integer, default: 180_000)
      attribute(:sentinel_notification, kind_of: [String, NilClass], default: nil)
      attribute(:sentinel_client_reconfig, kind_of: [String, NilClass], default: nil)

      action(:create) do
        file new_resource.path do
          content new_resource.content
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
        end
      end

      action(:delete) do
        file new_resource.path do
          action :delete
        end
      end
    end
  end
end
