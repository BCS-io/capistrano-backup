include Capistrano::Backup::Paths
include Capistrano::Backup::Helpers

namespace :load do
  task :defaults do
    set :app_config,               -> { 'backup.rb' } # name of app config file local & remote

    set :backups_root,             -> { '~/Backup' }  # backup configuration under this
    set :backups_config,           -> { 'config.rb' } # name of backup config file
    set :backups_model_config,     -> { "#{fetch(:application)}.rb" }
  end
end

namespace :backup do
  desc 'backup folder checks'
  task :check do
    invoke 'backup:check_backup_folder_exists'
    invoke 'backup:check_backup_config_full_path'
  end

  task :check_backup_folder_exists do
    next if File.exist?(backup_local_file)

    check_backup_file_exists_error
    exit 1
  end

  task :check_backup_config_full_path do
    on release_roles :all do
      next if test("[ -f #{backups_config} ]")

      check_backup_config_full_path_error
      exit 1
    end
  end

  desc 'Setup `backup` folder on the server(s)'
  task setup: [:check] do
    on release_roles :all do
      execute :mkdir, '-pv',  File.dirname(app_config)

      # symlink app model file into backup directory
      upload! backup_local_file.to_s, app_config.to_s
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
