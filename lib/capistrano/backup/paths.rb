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
      #               |  \ config.rb           => backups_config
      #                \
      #                 models - my_backup     => backups_model_config
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

      # backups_config
      #  - main remote configuration file
      #    - when backup runs this is the first file that is loaded
      #
      def backups_config
        "#{backups_root}/#{fetch(:backups_config)}"
      end

      # backups_model_config
      #  - full path to the remote backup model file
      #
      def backups_model_config
        "#{backups_root}/models/#{fetch(:backups_model_config)}"
      end
    end
  end
end
