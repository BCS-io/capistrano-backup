require "pathname"

module Capistrano
  module Backup
    module Paths

      def backup_local_path
        Pathname.new fetch(:backup_local_path)
      end

      def backup_remote_path
        shared_path.join fetch(:backup_remote_path)
      end

      def backup_file_system_dir
        fetch(:backup_file_system_dir)
      end

    end
  end
end
