module Capistrano
  module Backup
    module Helpers

      # error helpers - output error messages

      def check_backup_file_exists_error
        puts
        puts "Error - local file '#{fetch(:backup_local_file)}' does not exist, and it's required."
        puts
      end

      def check_backup_main_configuration_error
        puts
        puts "Error - remote file #{fetch(:backup_main_configuration)}' does not exist, and it's required"
        puts
      end
    end
  end
end
