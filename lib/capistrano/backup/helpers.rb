module Capistrano
  module Backup
    module Helpers

      # error helpers

      def check_backup_file_exists_error
        puts
        puts "Error - '#{fetch(:backup_local_file)}' does not exists, and it's required."
        puts
      end

    end
  end
end
