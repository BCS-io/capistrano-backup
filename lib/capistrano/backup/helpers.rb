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

      def backups_config_missing
        puts
        puts "Error - remote file #{backups_config}' is missing, and it's required."
        puts "Have you installed Backups Gem and configuration file?"
        puts "BCS uses the backups cookbook to install and configure"
        puts
      end
    end
  end
end
