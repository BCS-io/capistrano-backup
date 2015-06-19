include Capistrano::Backup::Paths
include Capistrano::Backup::Helpers

namespace :load do task :defaults do
    set :backup_local_path, 'config/backup'
    set :backup_remote_path, 'config/backup'
    set :backup_file_system_dir, '~/Backup'
    set :backup_env, -> { fetch(:rails_env) || fetch(:stage) }
  end
end

namespace :backup do

  desc 'backup folder checks'
  task :check do
    invoke 'backup:check_backup_folder_exists'
  end

  task :check_backup_folder_exists do
    next if File.directory?(backup_local_path)
    check_backup_folder_exists_error
    exit 1
  end

  desc "Setup `backup` folder on the server(s)"
  task setup: [:check] do
    on release_roles :all do
      execute :mkdir, "-pv", File.dirname(backup_remote_path)
      upload! backup_local_path.to_s, backup_remote_path.to_s, recursive: true
      sudo "ln -nfs #{backup_remote_path} #{backup_file_system_dir}"
    end
  end

  # Update `linked_dirs` after the deploy starts so that users'
  # `backup_remote_path` override is respected.
  task :backup_symlink do
    set :linked_dirs, fetch(:linked_dirs, []).push(fetch(:backup_remote_path))
  end
  after 'deploy:started', 'backup:backup_symlink'

end

desc 'Server setup tasks'
task :setup do
  invoke 'backup:setup'
end
