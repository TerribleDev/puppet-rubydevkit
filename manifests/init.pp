# == Class: rubydevkit
#
# Full description of class rubydevkit here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'rubydevkit':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class rubydevkit(
    $rubyHomePath,
    $devkitUrl => "http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe"
) {

     package { '7zip':
         ensure   => installed,
         provider => 'chocolatey',
     }->
     # make sure the tools directory exists
    file { 'C:/tools/':
        ensure => 'directory',
    }->
    file { 'C:/temp/':
        ensure => 'directory',
    }->
    download_file { "Download ruby devkit" :
        url                   => $devkitUrl,
        destination_directory => 'c:\temp',
        destination_file => "rubydk.exe"
    }->
    exec{'unzip devkit':
        command => '"c:/Program Files/7-zip/7z.exe" x -oDevKit2 c:/temp/rubydk.exe -aoa', #use 7zip to extract c:/temp/rubydk.exe -0 == extract to DevKit2 -aoa == override files
        cwd => 'c:/tools',
        creates => 'c:/tools/DevKit2'
    }->
     file { 'C:/tools/DevKit2/config.yml':
         ensure => file,
         group  => 'Users',
         owner  => 'Administrator',
         content => template('rubydevkit/config.yml'),
         mode => '0644'
     }
     exec{'install devkit':
         refreshonly => true,
         subscribe => File['C:/tools/DevKit2/config.yml'],
         command => "${rubyHomePath}/bin/ruby.exe dk.rb install",
         cwd => 'c:/tools/DevKit2'
     }
}
