include Capistrano::Backup::Paths
include Capistrano::Backup::Helpers

namespace :load do task :defaults do
    set :backup_local_file, 'config/backup.rb'
    set :backup_remote_file, 'config/backup.rb'
    set :backup_main_configuration, '~/Backup/config.rb'
    set :backup_model_file, -> { backup_model_file }
  end
end

namespace :backup do

  desc 'backup folder checks'
  task :check do
    invoke 'backup:check_backup_folder_exists'
    invoke 'backup:check_backup_main_configuration'
  end

  task :check_backup_folder_exists do
    next if File.exists?(backup_local_file)

    check_backup_file_exists_error
    exit 1
  end

  task :check_backup_main_configuration do
    on release_roles :all do
      next if test("[ -f #{backup_main_configuration} ]")

      check_backup_main_configuration_error
      exit 1
    end
  end

  desc 'Setup `backup` folder on the server(s)'
  task setup: [:check] do
    on release_roles :all do
      execute :mkdir, "-pv", File.dirname(backup_remote_file)
      sudo "ln -nfs #{File.dirname(backup_remote_file)} #{File.dirname(backup_model_file)}", recursive: true

      upload! backup_local_file.to_s, backup_remote_file.to_s
      sudo "ln -nfs #{backup_remote_file} #{backup_model_file}"
    end
  end

  # Update 'linked_files' after the deploy starts so that users
  # 'backup_remote_file' override is respected.
  task :backup_symlink do
    set :linked_files, fetch(:linked_files, []).push(fetch(:backup_remote_file))
  end
  after 'deploy:started', 'backup:backup_symlink'

end

desc 'Server setup tasks'
task :setup do
  invoke 'backup:setup'
end
