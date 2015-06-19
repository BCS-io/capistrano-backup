module Capistrano
  module Backup
    module Helpers

      # error helpers

      def check_backup_folder_exists_error
        puts
        puts "Error - '#{fetch(:backup_local_path)}' folder does not exists, and it's required."
        puts
      end

    end
  end
end
