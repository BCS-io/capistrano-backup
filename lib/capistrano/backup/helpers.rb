module Capistrano
  module Backup
    # Helpers
    #  - embarrassingly I just copied the structure of other Capistrano gems
    #  - In my mind it is "Wrap ugly parts of none OO code"
    #
    module Helpers
      # error helpers - output error messages

      def local_config_missing
        puts
        puts "Error - local file '#{backup_local_file}' is missing, and it is required."
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
