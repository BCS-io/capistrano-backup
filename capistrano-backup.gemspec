# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "capistrano/backup/version"

Gem::Specification.new do |gem|
  gem.name          = "capistrano-backup"
  gem.version       = Capistrano::Backup::VERSION
  gem.authors       = ["Richard Wigley"]
  gem.email         = ["richard.wigley@github"]
  gem.description   = <<-EOF.gsub(/^\s+/, "")
    Capistrano tasks for automating `backup folders` for Rails 4+ apps.

    This plugins syncs contents of your local backup configuration and copies that to
    the remote server.
  EOF
  gem.summary       = "Capistrano tasks for automating `backup folders` for Rails 4+ apps."
  gem.homepage      = "https://github.com/bcs-io/capistrano-backup"

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "capistrano", ">= 3.1"
  gem.add_dependency "sshkit", ">= 1.2.0"

  gem.add_development_dependency "byebug"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
