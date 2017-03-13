require 'bundler/setup'
Bundler.setup

require 'rake'
require "capistrano/deploy"
require "capistrano/all"
require 'capistrano/backup'

RSpec.configure do |config|
  # some (optional) config here
end
