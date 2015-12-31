namespace :svr do
  desc "TODO"
  task stop: :environment do
    pid_file = 'tmp/pids/server.pid'
    pid = File.read(pid_file).to_i
    Process.kill 9, pid
    File.delete pid_file
    puts 'Server has been killed ^_^'
  end

end
