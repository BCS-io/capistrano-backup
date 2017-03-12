require 'pathname'

module Capistrano
  module Backup
    # Paths
    #  - the directories and files used in the gem
    #
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
      #  ~/-- apps/<application>/shared/config/backup.rb  => app_config
      #    \
      #     - Backups -\                       => backups_root
      #               | \
      #               |  \ config.rb           => backup_config_full_path  ===> backups_config
      #                \
      #                 models - my_backup     => backup_model_file       ====> model_config
      #                                        => backup_model_full_path
      #
      # app_config
      #  - backup configuration path when deployed to the remote project
      #
      def app_config
        shared_path.join fetch(:app_config)
      end

      def backups_root
        fetch(:backups_root)
      end

      # backup_main_configuration
      #  - main remote configuration file
      #    - when backup runs this is the first file that is loaded
      #
      def backup_config_full_path
        "#{backups_root}/config.rb"
      end

      # backup_model_full_path
      #  - full path to the remote backup model file
      #
      def backup_model_full_path
        "#{backups_root}/models/#{fetch(:backup_model_file)}"
      end
    end
  end
end
