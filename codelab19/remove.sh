#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
white_bg=`tput setab 7`
bold=$(tput bold)
reset=`tput sgr0`

remove () {
  export LAB_DEPLOYED=($(cat lab_deployed.txt))
  echo ""
  echo "${red}${bold}$LAB_DEPLOYED${reset} lab is currently deployed"
  echo ""
  read -p "Are you sure you want to remove ${red}${bold}$LAB_DEPLOYED${reset} lab? ( Y/N  y/n  yes/no ): "
  if [[ ! $REPLY =~ ^([yY][eE][sS]|[yY])$ ]]
  then
      return
  fi
  echo ""
  echo "Removing base template for ${red}${bold}$LAB_DEPLOYED ${reset}..."
  echo ""
  time ./tf_destroy.sh -d "labs/${LAB_DEPLOYED}/"
}

if [[ -s lab_deployed.txt ]]; then
  remove
  rm lab_deployed.txt
else
  echo ""
  echo "You have no labs deployed!"
  echo ""
fi
