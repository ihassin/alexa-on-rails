working_directory '/home/pi/alexa/current'
pid '/home/pi/alexa/current/tmp/pids/unicorn.pid'
stderr_path '/home/pi/alexa/current/log/unicorn.log'
stdout_path '/home/pi/alexa/current/log/unicorn.log'

listen '/tmp/unicorn.alexa.sock', :backlog => 64
worker_processes 2
timeout 30
