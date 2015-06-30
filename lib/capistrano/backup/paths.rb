require 'pathname'

module Capistrano
  module Backup
    module Paths

      # backup_local_file
      #  - backup configuration file on local project
      #
      def backup_local_file
        Pathname.new fetch(:backup_local_file)
      end

      # Remote file structure
      #
      #  ~/-- apps/<application>/shared/config/backup.rb  => backup_remote_file
      #    \
      #     - Backups - config.rb => backup_main_configuration
      #               \
      #                models - my_backup =>  backup_model_file
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
      def backup_main_configuration
        fetch(:backup_main_configuration)
      end

      # backup_model_file
      #  - remote configuration file which describes the backup procedure
      #
      def backup_model_file
        "#{fetch(:backup_root)}/models/my_backup.rb"
      end
    end
  end
end
