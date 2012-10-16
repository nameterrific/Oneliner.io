root = "/home/deployer/apps/oneliner.io"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.oneliner.io.sock"
worker_processes 4
timeout 30
preload_app true
