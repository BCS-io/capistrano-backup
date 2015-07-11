require 'pathname'

module Capistrano
  module Backup
    module Paths

      # Local file structure
      #
      # application-root/config/backup.rb  => backup_local_file
      #
      #
      # backup_local_file
      #  - backup configuration file on local project
      #  - file kept on the machine running the deployment
      #
      def backup_local_file
        Pathname.new fetch(:backup_local_file)
      end

      # Remote file structure
      #
      #  ~/-- apps/<application>/shared/config/backup.rb  => backup_remote_file
      #    \
      #     - Backups -\                       => backup_folder
      #               | \
      #               |  \ config.rb           => backup_config_full_path
      #                \
      #                 models - my_backup     => backup_model_file
      #                                        => backup_model_full_path
      #
      # backup_remote_file
      #  - backup configuration path when deployed to the remote project
      #
      def backup_remote_file
        shared_path.join fetch(:backup_remote_file)
      end

      # backup_main_configuration
      #  - main remote configuration file
      #    - when backup runs this is the first file that is loaded
      #
      def backup_config_full_path
        "#{fetch(:backup_folder)}/config.rb"
      end

      # backup_model_full_path
      #  - full path to the remote backup model file
      #
      def backup_model_full_path
        "#{fetch(:backup_folder)}/models/#{fetch(:backup_model_file)}"
      end
    end
  end
end
