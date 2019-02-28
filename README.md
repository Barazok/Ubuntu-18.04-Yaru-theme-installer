# Summary

This little script will allow you to install latest stable release of yaru theme on Ubuntu 18.04.  
Without specific session, without snap, without ppa.  

Yaaay ! \o/

# Usage

## Configuration

You can change the version number of yaru-theme packages to install in `data/config.sh`.  
You can check available version of yaru-theme packages here : [yaru-theme packages](http://fr.archive.ubuntu.com/ubuntu/pool/main/y/yaru-theme/).

## Installation

```
git clone https://github.com/Barazok/Ubuntu-18.04-Yaru-theme-installer.git  
./install-yaru-theme
```

## Uninstallation

```
./remove-yaru-theme
```

## Updating

When a new version of yaru-theme is out and the `data/config.sh` file is updated, you can use this script.  
It will uninstall the old theme and download / install the new one.

*Note* : You can also use this script to downgrade yaru-theme to an older version.  
You just have to set the version you want in `data/config.sh` and run this script.

```
./update-yaru-theme
```
