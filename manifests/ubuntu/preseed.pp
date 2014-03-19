# Build a preseed file for Ubuntu for Cobbler

define cobbler::ubuntu::preseed(
  $packages = '',
  $early_command = false, # runs before install
  $late_command = false, # runs after install, before PXE is disabled
  $proxy = '',
  $ntp_server = undef,
  $admin_user = 'localadmin',
  $password_crypted,
  $expert_disk = false,
  $diskpart = [],
  $time_zone = 'UTC',
  $boot_disk = undef,
  $autostart_puppet = true,
  $root_part_size = 32768,
  $var_part_size = 131072,
  $enable_var = true,
  $enable_vol_space = true,
  $openstack_release = 'havana',
  $openstack_repo_location = 'http://openstack-repo.cisco.com/openstack/cisco',
  $supplemental_repo = 'http://openstack-repo.cisco.com/openstack/cisco_supplemental',
  $pocket = '',
  $preseed_template = 'cobbler/preseed.erb',
  $late_command_template = '',
) {
    if ( ! defined(File['/etc/cobbler/preseed'])) {
        file { "/etc/cobbler/preseed":
            ensure => directory
        }
    }

    file { "/etc/cobbler/preseed/${name}":
        ensure => 'file',
        content => template($preseed_template)
    }

    if ($late_command_template != '') {
      if ( ! defined(File['/var/www/preseed-data'])) {
        file { "/var/www/preseed-data":
          ensure => 'directory',
        }
      }

      file { "/var/www/preseed-data/${name}.late_command":
        ensure => "file",
        content => template($late_command_template),
      }
    }
  }
