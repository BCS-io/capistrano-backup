# Capistrano::backup

Capistrano tasks for handling database backups when deploying Rails 4+ apps.

### Install

Add this to `Gemfile`:

    group :development do
      gem 'capistrano', '~> 3.2.1'
      gem 'capistrano-backup', '~> 1.0.0'
    end

And then:

    $ bundle install

### Setup and usage

- populate database configuration `config/backup/models/my_file.rb`:
   
   -- as documented in: [backup gem](http://meskyanichi.github.io/backup/v4/)

- add to `Capfile`:

        require 'capistrano/backup'

- create `shared/config/backup` files on the remote server by executing this task:

        $ bundle exec cap production setup

You can now proceed with other deployment tasks.

#### What if a backup config is altered?

- update the local `shared/config/backup`:
  
  - re-run the setup task


### How it works

When you execute `$ bundle exec production setup`:

- backup files from your local `config/backup` are copied to the server.<br/>
- on the server backup folder is located  in `#{shared_path}/config/backup/`

On deployment:

- config/backup folder is automatically symlinked to `#{current_path}/config/backups/`

### Configuration

None.


### License

[MIT](LICENSE.md)
