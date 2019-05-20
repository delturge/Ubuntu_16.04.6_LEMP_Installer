# Ubuntu_16.04.6_LEMP_Installer
A bash Linux configurator LEMP installer for Ubuntu 16.04.6 (under construction)

This script is modular and 99% automated. It is 90% complete, but 100% cool.
I have been working off of VirtualBox.

Almost no user interaction will be necessary to complete your LEMP setup.
That can be done, but it's not necessary at the moment.

1. utilities_library: simple helper functions used in other functions.
2. linux_library: used to configure Ubuntu
3. user_library: used to configure users
4. sshd_library: used to configure sshd
5. mysql_installer: used to install MySQL <---- Requires user intervention to secure mysqld
6. nginx_installer: used to install Nginx
7. php7_installer: used to in stall the PHP-FPM
8. eval.3xcorp.com.conf: holds configuration settings
9. configure_eval.3xcorp.com: drives the main line of the program

Notes:

A. At this time, these scripts are totally raw and untested. The gist is there, though.
B. Certain levels of robust error checking were omitted for brevity.
C. Configuration file backup and archiving (tar), and a menu system are features I left off.
D. I hope this is the kind of thing you were looking for.
E. If I only wanted to install things manually, I could have finished long ago (but, where is the fun in that?)
F. Not finished, but I it definitely will be.
G  After testing, this will be pretty sweet.
H. Thanks you for the opportunity.
