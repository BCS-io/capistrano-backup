# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

### v0.2.0  2017-5-10
 - Backup Model Config name contains rails_env by default

### v0.1.0  2017-3-14
- Added Feature
  - [1e183ed14396924437fe730d78959bfce1661d22](https://github.com/BCS-io/capistrano-backup/commit/1e183ed14396924437fe730d78959bfce1661d22) Template configuration

- Removed Feature
  - uploading configuration verbatim - as I wasn't using the feature now

### v0.0.4  2015-06-30
- Added
  - Test to see if main backup configuration is present
  - more comments

### v0.0.3, 2015-06-21
- Added
  - creation of file path in case we are the first called 'setup'
    - have previously removed it - guess I did need it after all!
  - symlink between application configuration folder and backup models folder

### v0.0.2, 2015-06-20
- backup directory => only copying a single file

### v0.0.1, 2015-06-19
- started the project
- first working version
