#!/bin/bash
function __install_yaru_theme() {
  if [[ $(apt-cache search yaru | wc -l) = 4 ]]; then
    echo "Yaru theme is already installed !"
    exit 1
  fi
  if [[ ! -d "$MANAGER_PATH/tmp" ]]; then
    mkdir $MANAGER_PATH/tmp
  fi
  echo "Starting yaru-theme packages installation and configuration..."
  for package in `cat $MANAGER_PATH/data/packages`; do
    if [[ $(ls $MANAGER_PATH/tmp/ | grep $package | grep $YARU_THEME_VERSION | wc -l) = 0 ]]; then
      wget "${DOWNLOAD_PLATFORM}/${package}_${YARU_THEME_VERSION}_all.deb" -P $MANAGER_PATH/tmp/
    fi
    sudo dpkg -i "$MANAGER_PATH/tmp/${package}_${YARU_THEME_VERSION}_all.deb"
  done
  cd /
  sudo mv /usr/share/gnome-shell/theme/ubuntu.css /usr/share/gnome-shell/theme/ubuntu.css.bak
  sudo mv /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/stylesheet.css /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/stylesheet.css.bak
  sudo mv /usr/share/gnome-shell/modes/ubuntu.json /usr/share/gnome-shell/modes/ubuntu.json.bak
  sudo mv /usr/share/gnome-shell/theme/ubuntu-high-contrast.css /usr/share/gnome-shell/theme/ubuntu-high-contrast.css.bak
  sudo ln -s /usr/share/gnome-shell/theme/Yaru/gnome-shell.css /usr/share/gnome-shell/theme/ubuntu.css
  sudo ln -s /usr/share/gnome-shell/theme/Yaru/gnome-shell-high-contrast.css /usr/share/gnome-shell/theme/ubuntu-high-contrast.css
  sudo ln -s /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/yaru.css /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/stylesheet.css
  sudo ln -s /usr/share/gnome-shell/modes/yaru.json /usr/share/gnome-shell/modes/ubuntu.json
  sudo cp $MANAGER_PATH/data/yaru.css /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/yaru.css
  sudo ln -s /usr/share/gnome-shell/theme/Yaru/*.svg /usr/share/gnome-shell/theme/
  cd -
  gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
  gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
  gsettings set org.gnome.desktop.interface gtk-theme 'Yaru'
  gsettings set org.gnome.desktop.sound theme-name 'Yaru'
  echo "Gnome Shell is restarting... Please wait."
  sleep 0.1s
  gnome-shell --replace > /dev/null 2>&1 &
}

function __uninstall_yaru_theme() {
  if [[ $(apt-cache search yaru | wc -l) = 0 ]]; then
    echo "Yaru theme is already uninstalled !"
    exit 1
  fi
  echo "Rollbacking configurations..."
  cd /
  sudo rm -rf /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/stylesheet.css
  sudo rm -rf /usr/share/gnome-shell/modes/ubuntu.json
  sudo mv /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/stylesheet.css.bak /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/stylesheet.css
  sudo mv /usr/share/gnome-shell/modes/ubuntu.json.bak /usr/share/gnome-shell/modes/ubuntu.json
  sudo rm -rf /usr/share/gnome-shell/theme/
  sudo apt-get install --reinstall gnome-shell gnome-shell-common
  cd -
  gsettings reset org.gnome.desktop.interface cursor-theme
  gsettings reset org.gnome.desktop.interface icon-theme
  gsettings reset org.gnome.desktop.interface gtk-theme
  gsettings reset org.gnome.desktop.sound theme-name
  echo "Removing yaru-theme packages..."
  for package in `cat $MANAGER_PATH/data/packages`; do
    sudo dpkg -P $package
  done
  echo "Gnome Shell is restarting... Please wait."
  sleep 0.1s
  gnome-shell --replace > /dev/null 2>&1 &
}

function __update_yaru_theme() {
  INSTALLED_VERSION=$(apt-cache show yaru-theme-gnome-shell | grep "Version: " | sed -e 's/\Version: //g')
  if [[ $INSTALLED_VERSION != $(echo $YARU_THEME_VERSION) ]]; then
    __uninstall_yaru_theme
    __install_yaru_theme
  else
    echo "You have the lastest stable release of yaru theme"
  fi
}

function __usage(){
  printf "Script usage :\n"
  printf "\t-i : Install lastest stable release of yaru-theme.\n"
  printf "\t-r : Uninstall yaru-theme and back to default.\n"
  printf "\t-u : Update installed yaru-theme if needed.\n"
  printf "\t-h : Display this message.\n"
  printf "\t-v : Display version.\n"
  printf "\t-e : Edit config.\n"
}

function __version() {
  echo "yaru-theme-manager $MANAGER_VERSION"
}

function __edit_config() {
  $DEFAULT_EDITOR $1 > /dev/null 2>&1 &
}
