#!/bin/bash
#
# LEMP INSTALLER x86_64: Ubuntu 16.04.6 LTS #####
# @version 1.0
# @author Anthony E. Rutledge
# @Copyright Anthony E. Rutledge 5/16/2019 @ 1800 EST All Rights Reserved
#
#  A modular script for basic server configuration and LEMP stack installation.
#
#  Development Start Time: 5/15/2019 @ 1800 EST

####################################
####### Supporting Libraries #######
####################################

. utilities_library
. linux_library
. user_library
. sshd_library
. mysql_installer
. nginx_installer
. php_installer

####################################

####################################
###### Application Functions #######
####################################

function installWebpage ()
{
    message "Initializing: $3"
    echo $1 > "${2}${3}"
}

function showIntro ()
{
    clear
    message "\t\t\t\t3XCorp LEMP Installer 1.0"
    message "\t\t\t\t\t(Fly, Eagles Fly!)"
    showLinuxDistInfo
    sleep 5
}

####################################

####################################
###### Configuration Settings ######
####################################

. eval.3xcorp.com.conf

####################################

################################################################################
################################   MAIN  #######################################
################################################################################

showIntro

echo -e \
"################################
 #                              #
 #  UPGRADING CURRENT PACKAGES  #
 #                              #
 ################################\n\n"

upgradePackages

echo -e \
"###############################
 #                             #
 #   UPGRADING DISTRIBUTION    #
 #                             #
 ###############################\n\n"

upgradeDistrubtion

echo -e \
"###############################
 #                             #
 # GENERAL CONFIGURATION TASKS #
 #                             #
 ###############################\n\n"

sleep 2

echo -e \
"#########################
 # PHASE 1: Set Timezone #
 #########################\n\n"

setTimezone $timezone

echo -e \
"#######################################
 # PHASE 2: Set Locale & Character Set #
 #######################################\n\n"

setLocale

echo -e \
"#########################
 # PHASE 3: Set Hostname #
 #########################\n\n"

setHostname $hostname

echo -e \
"#################################
 # PHASE 4: Add Users and Groups #
 #################################\n\n"

setPasswordDefaults
addAccounts "${users[@]}"
secureHomeDirs "${users[@]}"
setPassword "${users[@]}"
addToGroup $sudoGroup "${users[@]}" 

echo -e \
"###############################
 #                             #
 #      MySQL INSTALLATION     #
 #                             #
 ###############################\n\n"

installMySqlFromPackages
displayServiceReport $rdbms
installMySqlClientPackages
secureMySql $mysqlSecFile
restart $service

echo -e \
"###############################
 #                             #
 #      NGINX INSTALLATION     #
 #                             #
 ###############################\n\n"

installNginxFromPackages
displayServiceReport $httpServer
stop $httpServer
makeWebRoot $webRoot
secureWebRoot $webRoot
setServerName $ipAddress
setWebRoot $webRoot
start $httpServer

echo -e \
"###############################
 #                             #
 #      PHP INSTALLATION       #
 #                             #
 ###############################\n\n"

installPhpFromPackages
stop $httpServer
# Next: PHP configuration functions
start $httpServer

echo -e \
"###############################
 #                             #
 #       BUILD WEBSITE         #
 #                             #
 ###############################\n\n"

installWebpage $homePage $3xcorpDir $index

echo -e \
"###############################
 #                             #
 #      SSH CONFIGURATION      #
 #                             #
 ###############################\n\n"

setupSSH $sshPort
secureSSH "${users[@]}"
restart ssh
showServiceStatus ssh

message "Congratulations! Your Linux instance and LEMP stack has been succesfully configured!"
