default_source :community
default_source :chef_repo, '..'
cookbook 'redis', path: '../../..'
run_list 'redis::default'
named_run_list :centos, 'yum::default', run_list
named_run_list :debian, 'apt::default', run_list
named_run_list :freebsd, 'freebsd::default', run_list