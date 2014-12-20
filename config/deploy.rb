# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'comiguide'
set :repo_url, 'git@github.com:umatoma/comiguide.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/apps/comiguide'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :use_sudo, false
set :rbenv_type, :user
set :rbenv_ruby, '2.1.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc "Copy the database.yml"
  task :copy_database_yml do
    on roles(:app, :db) do
      execute 'cp', "#{shared_path}/config/database.yml", "#{release_path}/config/database.yml"
    end
  end

  desc "Copy the .env"
  task :copy_dotenv do
    on roles(:app, :db) do
      execute 'cp', "#{shared_path}/.env", "#{release_path}/.env"
    end
  end

  after :updating, :copy_database_yml
  after :updating, :copy_dotenv
end

namespace :unicorn do
  task :environment do
    set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
    set :unicorn_config, "#{current_path}/config/unicorn.rb"
  end

  def start_unicorn
    within current_path do
      execute :bundle, :exec, :unicorn_rails, "-c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -p 3000 -D"
    end
  end

  def stop_unicorn
    execute :kill, "-s QUIT $(< #{fetch(:unicorn_pid)})"
  end

  def reload_unicorn
    execute :kill, "-s USR2 $(< #{fetch(:unicorn_pid)})"
  end

  def force_stop_unicorn
    execute :kill, "$(< #{fetch(:unicorn_pid)})"
  end

  desc "Start unicorn server"
  task start: :environment do
    on roles(:app) do
      start_unicorn
    end
  end

  desc "Stop unicorn server gracefully"
  task stop: :environment do
    on roles(:app) do
      stop_unicorn
    end
  end

  desc "Restart unicorn server gracefully"
  task restart: :environment do
    on roles(:app) do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        reload_unicorn
      else
        start_unicorn
      end
    end
  end

  desc "Stop unicorn server immediately"
  task force_stop: :environment do
    on roles(:app) do
      force_stop_unicorn
    end
  end
end

namespace :log do
  desc 'Tail application log'
  task :tail do
    on roles(:app) do
      tail "#{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end

  def with_verbosity(output_verbosity)
    old_verbosity = SSHKit.config.output_verbosity

    begin
      SSHKit.config.output_verbosity = output_verbosity
      yield
    ensure
      SSHKit.config.output_verbosity = old_verbosity
    end
  end

  def tail(path)
    with_verbosity(Logger::DEBUG) do
      execute "tail -f #{path}"
    end
  end
end
