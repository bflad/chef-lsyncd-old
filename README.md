# chef-lsyncd [![Build Status](https://secure.travis-ci.org/bflad/chef-lsyncd.png?branch=master)](http://travis-ci.org/bflad/chef-lsyncd)

## COMMUNITY OWNERSHIP MOVED

I've transfered the [lysncd community cookbook](http://community.opscode.com/cookbooks/lsyncd) maintainership to [@dgivens](https://github.com/dgivens/) ([danielgivens](http://community.opscode.com/users/danielgivens) on the community site). Please see: https://github.com/dgivens/chef-lsyncd for a much better cookbook!

## Description

Installs/configures [lsyncd](https://github.com/axkibe/lsyncd).

## Requirements

### Platforms

* CentOS 6
* RHEL 6

## Attributes

* `node["lsyncd"]["logfile"]` - log file for lsyncd, defaults to
  "/var/log/lsyncd.log"
* `node["lsyncd"]["statusFile"]` - status file for lsyncd, defaults to
  "/var/log/lsyncd-status.log"
* `node["lsyncd"]["statusInterval"]` - minimum seconds before updating status
  file, defaults to 20
* `node["lsyncd"]["sync"]` - Array of sync configurations, defaults to [],
  examples in Usage section

## Recipes

* `recipe[lsyncd]` will install/configure lsyncd.
* `recipe[lsyncd::source]` will install lsyncd from source.

## Usage

### Package installation and configuration

* Add sync configurations via `node["lsyncd"]["sync"]` attribute
* Add `recipe[lsyncd]` to your node's run list

### Source installation

* Add `recipe[lsyncd::source]` to your node's run list

### Sync configuration

Select a mode for the sync for further attributes.

Attributes for all modes:
* `mode` - "rsync" or "rsyncssh" - defaults to "rsync"
* `source` - _required_ - path to source directory - no default
* `exclude` - array of file exclusion strings - no default
* `excludeFrom` - path to exclude file - no default

#### rsync mode

For remote targets, normal rsync behavior of rsync all changes over the wire.

Attributes:
* `host` - remote host, used in conjunction with `targetdir` - no default
* `rsyncOpts` - array of rsync option strings, lsyncd defaults this to "-lts"
* `target` - full specification for destination ([host::]/target/dir) - no
  default
* `targetdir` - target directory, possibly used in conjunction with `host` -
  no default

Example:

    "sync" => [
      {
        "mode" => "rsync",
        "source" => "/my/source/dir",
        "target" => "remotehost::/my/target/dir"
      }
    ]

#### rsyncssh mode

Causes moves and copies to be executed on the remote host via SSH, rather than
retransmitting files over the wire. Normal rsync behavior otherwise.

Attributes:
* `host` - _required_ - remote host - no default
* `rsyncOpts` - array of rsync option strings, lsyncd defaults this to "-lts"
* `targetdir` - _required_ - target directory - no default

Example:

    "sync" => [
      {
        "mode" => "rsyncssh",
        "source" => "/my/source/dir",
        "host" => "remotehost",
        "targetdir" => "/my/target/dir"
      }
    ]

## Testing and Development

* Quickly testing with Vagrant: [VAGRANT.md](VAGRANT.md)
* Full development and testing workflow with Test Kitchen and friends: [TESTING.md](TESTING.md)

## Contributing

Please see contributing information in: [CONTRIBUTING.md](CONTRIBUTING.md)

## Maintainers

* Brian Flad (<bflad417@gmail.com>)

## License

Please see licensing information in: [LICENSE](LICENSE)
