name 'sentinel'
instance_eval(IO.read(File.expand_path('../_base.rb', __FILE__)))
run_list << 'redis::sentinel'
