# === Authors
#
# Tommy Parnell
#
# === Copyright
#
# Copyright 2016 Tommy Parnell, unless otherwise noted.
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
