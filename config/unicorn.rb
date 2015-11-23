# process count
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)

# 15秒でWorkerをkillしてタイムアウト
timeout 15

# trueにしておくとダウンタイムが発生しないらしい
preload_app true

# 使用するポート番号を指定
# 同一マシンでNginxとプロキシ組むならsocketのが高速らしい
# listen /path/to/rails/tmp/unicorn.sock
listen '127.0.0.1:3000'

# Capistranoを使うときに設定
# pid /path/to/rails/tmp/pids/unicorn.pid

# ログの設定方法.
stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])

before_fork do |server, _worker|
  old_pid = "#{ server.config[:pid] }.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i) # 古いプロセスをkill
    rescue Errno::ENOENT, Errno::ESRCH
      # エラー処理
    end
  end

  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end

def rails_root
  require "pathname"
  Pathname.new(__FILE__) + "../../"
end
