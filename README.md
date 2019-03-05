# Summary

This little script will allow you to install latest stable release of yaru theme on Ubuntu 18.04.  
Without specific session, without snap, without ppa.  

Yaaay ! \o/

# Usage

## Configuration

You can change the version number of yaru-theme packages to install in `data/config.sh`.  
You can check available version of yaru-theme packages here : [yaru-theme packages](http://fr.archive.ubuntu.com/ubuntu/pool/main/y/yaru-theme/).

You can set your country in `data/config.sh` in order to have a faster download.

You can change the download platform in `data/config.sh` if you want.  
*NOTE* : the installation script will search for `DOWNLOAD_PLATFORM/packages-names.deb`  
Also, if you change the download platform, the country setting may become useless.


You can edit config with :
```
./yaru-theme-manager -e
```
default editor of this option can be changed in `data/config.sh`

## Installation

```
git clone https://github.com/Barazok/Ubuntu-18.04-Yaru-theme-installer.git  
./yaru-theme-manager -i
```

## Uninstallation

```
./yaru-theme-manager -r
```

## Updating

When a new version of yaru-theme is out and the `data/config.sh` file is updated, you can use this script.  
It will uninstall the old theme and download / install the new one.

*Note* : You can also use this script to downgrade yaru-theme to an older version.  
You just have to set the version you want in `data/config.sh` and run this script.

```
./yaru-theme-manager -u
```
