# rubydevkit

## Overview

This is a simple module to install the rubydevkit on windows. 

## Requirements

Ruby installed to a directory, before calling this module.




## Usage

```
class {'rubydevkit':
    rubyHomePath => 'c:/tools/ruby22'
}

```


## Optional Parameters:

#### devkitUrl

Url to download the devkit, default: `http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe` 

you can change this to download the 32-bit devkit, instead of the 64
