require 'pathname'

module Capistrano
  module Backup
    module Paths

      def backup_local_file
        Pathname.new fetch(:backup_local_file)
      end

      def backup_remote_file
        shared_path.join fetch(:backup_remote_file)
      end

      def backup_model_file
        fetch(:backup_model_file)
      end

    end
  end
end
