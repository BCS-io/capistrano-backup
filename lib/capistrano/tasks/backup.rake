include Capistrano::Backup::Paths
include Capistrano::Backup::Helpers

namespace :load do
  task :defaults do
    set :template_app_config,      -> { 'backup.erb' } # name of config template
    set :app_config,               -> { 'backup.rb' }  # name of remote app config file

    set :backups_root,             -> { '~/Backup' }   # backup configuration under this
    set :backups_config,           -> { 'config.rb' }  # name of backup config file
    set :backups_model_config,     -> { "#{fetch(:application)}_#{fetch(:rails_env, 'production')}.rb" }
  end
end

namespace :backup do
  desc 'backup folder checks'
  task :check do
    invoke 'backup:backup_installed?'
  end

  task :backup_installed? do
    on release_roles :all do
      next if test("[ -f #{backups_config} ]")

      backups_config_missing
      exit 1
    end
  end

  desc 'Copy `backup` config to the remote server(s) and symlink to it from backups folder'
  task setup: [:check] do
    on release_roles :all do
      execute :mkdir, '-pv', File.dirname(app_config)
      # symlink app model file into backup directory
      upload! eval_template(template_app_config), app_config
      sudo "ln -nfs #{app_config} #{backups_model_config}"
    end
  end

  # Update 'linked_files' after the deploy starts so that users
  # 'app_config' override is respected.
  task :backup_symlink do
    set :linked_files, fetch(:linked_files, []).push(fetch(:app_config))
  end
  after 'deploy:started', 'backup:backup_symlink'
end

desc 'Server setup tasks'
task :setup do
  invoke 'backup:setup'
end
