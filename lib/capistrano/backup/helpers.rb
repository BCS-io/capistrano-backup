module Capistrano
  module Backup
    # Helpers
    #  - embarrassingly I just copied the structure of other Capistrano gems
    #  - In my mind it is "Wrap ugly parts of none OO code"
    #
    module Helpers
      # error helpers - output error messages

      def check_backup_file_exists_error
        puts
        puts "Error - local file '#{fetch(:backup_local_file)}' does not exist, and it's required."
        puts
      end

      def check_backup_config_full_path_error
        puts
        puts "Error - remote file #{fetch(:backups_config)}' does not exist, and it's required"
        puts
      end
    end
  end
end
