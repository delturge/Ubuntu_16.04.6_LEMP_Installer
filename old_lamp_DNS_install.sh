#!/usr/bin/bash
####LAMP INSTALLER x86_64: Ubuntu 16.04.6 LTS #####
#
#@Copyright Anthony E. Rutledge 6/13/2015 @ 0100 EST
#All Rights Reserved
#
#Note: The best way to start is to make sure the kernel and libraries
#are up to date. This will save you time in the long run.
#
#The purpose of this file is to install:
#MySQL Database 5.6.25
#ICU4C 55.1
#Readline 6.3
#libz 1.2.8
#libbz2 1.0.6
#XZ Utilities 5.2.8
#libgpg-error 1.19
#libgcrpypt 1.6.3
#mcrypt 2.6.8
#PCRE 8.37
#PERL 5.22.0
#Python 2.7.10
#Python 3.4.3
#libxml2 2.9.2
#libxslt 1.1.28
#OpenSSL 1.0.2a
#Apache httpd 2.4.12
#PHP Programming Language 5.6.10
#BIND 9.10.2 

RPMROOT="$HOME/rpmbuild/RPMS/x86_64"
SRPMROOT="$HOME/rpmbuild/SRPMS"
hostname=`hostname`

cd ../downloads/
cd /etc/

date
timedatectl status
echo -e "\nChanging timezone to America/Detroit (i.e. Eastern Time U.S. +0500 UTC)\n\n"
timedatectl set-timezone `timedatectl list-timezones | grep Detroit`
date
timedatectl status
sleep 5


echo -e "\n\n"


echo "Current hostname = `hostname`\n\n"
echo -e "\nCreating /etc/hostname \n\n"
echo $hostname > hostname

#while [ ! hostnamectl set-hostname $newHostName ]
#do
#	echo "Trying again.\n"
#done

#echo -e "\nChanging hostname entry in /etc/hosts.\n\n"
#sed -i '/s166-62-44-91.secureserver.net/c \127.0.0.1 ncc1701d.anthonyerutledge.info ncc1701d' hosts

#echo -e "\nChanging hostname entry in /etc/sysconfig/network.\n\n"
#sed -i '/s166-62-44-91.secureserver.net/c \HOSTNAME="ncc1701d.anthonyerutledge.info"' /etc/sysconfig/network

#echo -e "\nRestarting systemd-hostnamed.\n\n"
#systemctl restart systemd-hostnamed

#echo "New hostname = `hostname`\n\n"



echo -e "\nChanging to the downloads directory!\n\n"
cd $OLDPWD
sleep 3



echo -e "###################
#                 #
#PHASE 1: Prep    #
#                 #
###################\n\n"
sleep 2

echo -e "Remove all LAMP related packages.\n\n"

yum -y remove bind
yum -y remove bind-libs
yum -y remove samba-client
yum -y remove samba
yum -y remove samba-common
yum -y remove samba-libs
yum -y remove samba*
yum -y remove talk
yum -y remove talk-server
yum -y remove php
yum -y remove php-common
yum -y remove php-cli
yum -y remove php*
yum -y remove http-tools
yum -y remove apr-util
yum -y remove apr
yum -y remove httpd
yum -y remove mysql-client
yum -y remove mysql-server
yum -y remove mysql-libs
yum -y remove mysql*
yum -y remove mariadb
yum -y remove mariadb100u-devel
yum -y remove mariadb100u-common
yum -y remove mariadb100u-config
yum -y remove mariadb100u-libs
yum -y remove mariadb*

echo -e "Install required or useful utilities, programs, and libraries.\n\n"
yum -y install file
yum -y install yum-utils
yum -y install net-tools
yum -y install iputils
yum -y install gcc
yum -y install gcc-c++
yum -y install gzip
yum -y install bzip2
yum -y install bzip2-devel
yum -y install libicu
yum -y install libicu-devel
yum -y install ncurses-devel
yum -y install readline-devel
yum -y install perl
yum -y install wget
yum -y install rpm-build
echo -e "Intall dependencies for apr-1.5.2\n\n"
yum -y install automake
yum -y install autoconf
yum -y install libtool
yum -y install doxygen
echo -e "Install possible dependencies for apr-util-1.5.4\n\n"
yum -y install expat-devel
yum -y install libuuid-devel
yum -y install db4-devel
yum -y install postgresql-devel
#yum    install mysql-devel   #DO NOT INSTALL mariadb files or libraries.
yum -y install sqlite-devel
yum -y install freetds-devel
yum -y install unixODBC-devel
yum -y install openldap-devel
yum -y install openssl-devel
yum -y install nss-devel
yum -y install libdb-devel
yum -y install libdb-cxx-devel
yum -y install lib4db-devel
yum -y install libdb4-cxx
yum -y install libdb
yum -y install lib4db
echo -e "Install dependencies for httpd-2.4.12 or PHP 5.6.9\n\n"
yum -y install pcre-devel
yum -y install lua-devel
yum -y install libxml2
yum -y install libxml2-devel
yum -y install libxslt
yum -y install libxslt-devel
yum -y install libxml2-python
yum -y install distcache-devel

yum -y update
yum-complete-transaction --cleanup-only


echo "###################
#                 #
#PHASE 2: Download#
#                 #
###################"
sleep 2

echo -e "Downloading ICU4C 55.1\n\n"
wget http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-src.tgz

echo -e "Downloading Readline 6.3\n\n"
wget ftp://ftp.cwru.edu/pub/bash/readline-6.3.tar.gz

echo -e "Downloading libz 1.2.8\n\n"
wget http://zlib.net/zlib-1.2.8.tar.gz

echo -e "Downloading libbz2 1.0.6 (bzip2)\n\n"
wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz

echo -e "Downloading XZ Utils (xz-5.2.1)\n\n"
wget http://tukaani.org/xz/xz-5.2.1.tar.gz

echo -e "Downloading libgpg-error 1.19 (GnuPG)\n\n"
wget ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.19.tar.bz2

echo -e "Downloading libgcrypt 1.6.3 (GnuPG)\n\n"
wget ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.6.3.tar.bz2

echo -e "Downloading libmcrypt 2.5.8 \n\n"
wget http://sourceforge.net/projects/mcrypt/files/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz/download
mv -v download libmcrypt-2.5.8.tar.gz

#echo -e "Downloading mcrypt 2.6.8\n\n"
#wget http://sourceforge.net/projects/mcrypt/files/latest/download?source=files

echo -e "Downloading Python 2.7.10\n\n"
wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tar.xz

echo -e "Downloading Python 3.4.3\n\n"
wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tar.xz

echo -e "Downloading libxml2-2.9.2\n\n"
wget ftp://xmlsoft.org/libxml2/libxml2-2.9.2.tar.gz

echo -e "Downloading libxml2-python-2.6.9.tar.gz\n\n"
wget ftp://xmlsoft.org/libxml2/python/libxml2-python-2.6.9.tar.gz

echo -e "Downloading libxslt 1.1.28\n\n"
wget ftp://xmlsoft.org/libxml2/libxslt-1.1.28.tar.gz

echo -e "Downloading PCRE (Perl Compatible Regular Expressions Library)\n\n"
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.bz2

echo -e "Downloading OpenSSL 1.0.2c\n\n"
wget https://www.openssl.org/source/openssl-1.0.2c.tar.gz

echo -e "Downloading MySQL YUM repository.\n\n"
wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm

echo -e "Downloading PERL 5.22.0\n\n"
wget http://www.cpan.org/src/5.0/perl-5.22.0.tar.gz

echo -e "Downloading APR (Apache Portable Runtime) 1.5.2\n\n"
wget http://ftp.wayne.edu/apache//apr/apr-1.5.2.tar.bz2

echo -e "Downloading APR-UTIL (Apache Portable Runtime Utilities) 1.5.4\n\n"
wget http://ftp.wayne.edu/apache//apr/apr-util-1.5.4.tar.bz2

echo -e "Downloading Apache HTTP Server 2.4.12\n\n"
wget http://ftp.wayne.edu/apache//httpd/httpd-2.4.12.tar.bz2

echo -e "Downloading PHP 5.6.10\n\n"
wget http://php.net/get/php-5.6.10.tar.bz2/from/this/mirror
mv -v mirror php-5.6.10.tar.bz2

echo -e "Downloading BIND 9.10.2-P1\n\n"
wget ftp://ftp.isc.org/isc/bind9/9.10.2-P1/bind-9.10.2-P1.tar.gz



echo "###################
#                 #
#PHASE 3: Extract #
#         Sources #
###################"
sleep 2

echo -e "ICU4C 55.1\n\n"
tar -xzvf icu4c-55_1-src.tgz

echo -e "Extracting Readline 6.3\n\n"
tar -xzvf readline-6.3.tar.gz

echo -e "Extracting libz 1.2.8\n\n"
tar -xzvf zlib-1.2.8.tar.gz

echo -e "Extracting libbz2\n\n"
tar -xzvf bzip2-1.0.6.tar.gz

echo -e "Extracting XZ Utils (liblzma)\n\n"
tar -xzvf xz-5.2.1.tar.gz

echo -e "Extracting libgpg-error 1.19 (GnuPG)\n\n"
tar -xjvf libgpg-error-1.19.tar.bz2

echo -e "Extracting libgcrpyt 1.6.3 (GnuPG)\n\n"
tar -xjvf libgcrypt-1.6.3.tar.bz2

echo -e "Extracting libmcrpyt 2.5.8 (GnuPG)\n\n"
tar -xzvf libmcrypt-2.5.8.tar.gz

#echo -e "Extracting mcrypt 2.6.8\n\n"
#tar -xzvf mcrypt-2.6.8.tar.gz

echo -e "Extracting Python 2.7.10\n\n"
tar -xJvf Python-2.7.10.tar.xz

echo -e "Extracting Python 3.4.3\n\n"
tar -xJvf Python-3.4.3.tar.xz

echo -e "Extracting libxml2 2.9.2\n\n"
tar -xzvf libxml2-2.9.2.tar.gz

echo -e "Extracting libxml2-python-2.6.9.tar.gz\n\n"
tar -xzvf libxml2-python-2.6.9.tar.gz

echo -e "Extracting libxslt 1.1.28\n\n"
tar -xzvf libxslt-1.1.28.tar.gz

echo -e "Extracting PCRE 8.37\n\n"
tar -xjvf pcre-8.37.tar.bz2

echo -e "Extracting OpenSSL 1.0.2\n\n"
tar -xzvf openssl-1.0.2c.tar.gz

echo -e "Extracting PERL 5.22.0\n\n"
tar -xzvf perl-5.22.0.tar.gz

echo -e "Extracting APR 1.5.2\n\n"
tar -xjvf apr-1.5.2.tar.bz2

echo -e "Extracting APR-UTILS 1.5.4\n\n"
tar -xjvf apr-util-1.5.4.tar.bz2

echo -e "Extracting httpd-2.4.12\n\n"
tar -xjvf httpd-2.4.12.tar.bz2

echo -e "Extracting PHP 5.6.10\n\n"
tar -xjvf php-5.6.10.tar.bz2

echo -e "Extracting BIND 9.10.2-P1\n\n"
tar -xzvf bind-9.10.2-P1.tar.gz


echo "###################
#                 #
#PHASE 4: MySQL   #
#         Install #
###################"
sleep 2


echo -e "Install the MySQL YUM repository. (CentOS/RHEL7/Fedora 20+)\n\n"
yum -y install mysql-community-release-el7-5.noarch.rpm
yum clean all

echo -e "Install MySQL 5.6.25 from the MySQL community repository.\n\n"
yum -y install mysql-community-libs
yum -y install mysql-community-client
yum -y install mysql-community-server
yum -y install mysql-community-devel #<---Required by apr-utils-1.5.4

echo -e "Removing the mysql users's login shell from /etc/passwd.\n\n"
usermod -s /sbin/nologin mysql

echo -e "\n"
grep "^mysql:x:" /etc/passwd
echo -e "\n"

yum update

echo -e "\nCopying my.cnf and mysqld.service to their proper directories.\n\n"
cp ../apps/mysql/my.cnf /etc/
cp ../apps/mysql/mysqld.service /usr/lib/systemd/system/
systemctl daemon-reload

echo -e "Making sure the mysql user owns its working directories.\n\n"
if [ ! -d /var/run/mysqld/ ]
then
	mkdir -pv /var/run/mysqld
fi

if [ ! -d /var/lib/mysql/ ]
then
	mkdir -pv /var/lib/mysql
fi

chown -Rv mysql:mysql /var/run/mysqld/ /var/lib/mysql/
ls -ld /var/lib/mysql/ /var/run/mysqld/
sleep 5


echo "\n###################
#                 #
#PHASE 5: Source  #
#         Installs#
###################"
sleep 2


echo -e "\nCompiling ICU4C 55.1\n\n"
#-DU_USING_ICU_NAMESPACE=0 -DU_CHARSET_IS_UTF8=1 -DUNISTR_FROM_CHAR_EXPLICIT=explicit -DUNISTR_FROM_STRING_EXPLICIT=explicit \
#           --with-library-bits=bits=nochange \
#           --with-data-packaging \
cd icu/source/
./runConfigureICU Linux/gcc \
            --enable-shared \
            --enable-static \
            && make && make install
cd ../../
ldconfig
sleep 20


echo -e "\nCompiling readline-6.3\n\n"
cd readline-6.3/
./configure --enable-shared \
            --enable-static \
            --enable-multibyte \
            && make && make install
cd ..
ldconfig
sleep 5


echo -e "\nCompiling libz 1.2.8\n\n"
cd zlib-1.2.8/
make distclean
./configure && make && make install
cd ..
ldconfig
sleep 5


echo -e "\nCompiling libbz2 1.0.6 (bzip2)\n\n"
cd bzip2-1.0.6/
make -f Makefile-libbz2_so && make install
cp libbz2.so.1.0.6 /usr/local/lib/
cp libbz2.so.1.0 /usr/local/lib/
cd ..
ldconfig
sleep 5


echo -e "\nCompiling XZ Utils 5.2.1 (liblzma)\n\n"
#--enable-threads=yes|no   <----Not sure what is right. 
cd xz-5.2.1/
./configure --enable-shared=yes \
            --enable-static=yes \
            --enable-encoders \
            --enable-decoders \
            --enable-match-finders \
            --enable-checks= \
            --disable-largefile \
            && make && make install
cd ..
ldconfig
sleep 5


echo -e "\nCompiling libgpg-error-1.19 (GnuPG)\n\n"
cd libgpg-error-1.19/
./configure --enable-shared=yes \
            --enable-static=yes \
            --disable-largefile \
            && make && make install
cd ..
ldconfig
sleep 5


echo -e "\nCompiling libgcrypt 1.6.3 (GnuPG)\n\n"
cd libgcrypt-1.6.3/
./configure --enable-shared=yes \
            --enable-static=yes \
            --with-libgpg-error-prefix=/usr/local/lib \
            && make && make install
cd ..
ldconfig
sleep 5


echo -e "\nCompiling libmcrypt 2.5.8\n\n"
#           --enable-dynamic-loading \
cd libmcrypt-2.5.8/
./configure --enable-shared=yes \
            --enable-static=yes \
            --disable-posix-threads \
            && make && make install
cd ..
ldconfig
sleep 5


#echo -e "Compiling mcrypt 2.6.8\n\n"
#cd mcrypt-2.6.8/
#./configure && make && make install
#cd ..
#ldconfig
#sleep 5


echo -e "\nCompiling PCRE(1) 8.37\n\n"
cd pcre-8.37/
./configure --enable-shared \
            --enable-static \
            --docdir=/usr/share/doc/pcre-8.37 \
            --enable-unicode-properties \
            --enable-pcre16 \
            --enable-pcre32 \
            --enable-pcregrep-libz \
            --enable-pcregrep-libbz2 \
            --enable-pcretest-libreadline \
            && make && make install
ldconfig
cd ..
sleep 5


echo -e "\nCompiling PERL 5.22.0\n\n"
cd perl-5.22.0/
./Configure -de && make && make install
cd ..
ldconfig
sleep 5


echo -e "\nCompiling Python-2.7.10\n\n"
cd Python-2.7.10/
./configure --enable-shared \
            --enable-ipv6 \
            --enable-unicode \
            && make && make install
cd ..
ldconfig
sleep 5


echo -e "\nCompiling Python-3.4.3\n\n"
cd Python-3.4.3/
./configure --enable-shared \
            --enable-ipv6 \
            && make && make install
cd ..
ldconfig
sleep 5


echo -e "\nCompiling OpenSSL 1.0.2c\n\n"
cd openssl-1.0.2c/
./config shared \
         zlib-dynamic \
         && make && make install
cd ..
ldconfig
sleep 5


#echo -e "Compiling libxml2 2.9.2\n\n"
#cd libxml2-2.9.2/
#./configure --enable-shared \
#            --enable-static \
#            --enable-ipv6=yes \
#            --with-ftp \
#            --with-http \
#            --with-html \
#            --with-pattern \
#            --with-regexps \
#            --with-reader \
#            --with-writer \
#            --with-output \
#            --with-tree \
#            --with-xpath \
#            --with-xptr \
#            --with-push \
#            --with-valid \
#            --with-xinclude \
#            --with-modules \
#            --with-readline=/usr/local/lib \
#            --with-zlib=/usr/local/lib \
#            --with-lzma=/usr/local/lib \
#            --without-python \
#            && make && make install
#cd ..
#ldconfig
#sleep 10


#echo -e "Compiling libxslt-1.1.28\n\n"
#cd libxslt-1.1.28/
#./configure --enable-shared \
#            --enable-static \
#            --with-crypto \
#            --with-libxml-prefix=/usr/local/bin \
#            --with-libxml-include-prefix=/usr/local/include/libxml2/libxml \
#            --with-libxml-libs-prefix=/usr/local/lib \
#            --without-python \
#            && make && make install
#cd ..
#ldconfig
#sleep 10


echo -e "\nCompiling Apache HTTP Server 2.4.12\n\n"
#           --with-libxml2=/usr/local/lib \
#           --enable-ssl-static-lib-deps \
cd httpd-2.4.12/
mkdir -v srclib/apr/ srclib/apr-util/
mv -v ../apr-1.5.2/* srclib/apr/
mv -v ../apr-util-1.5.4/* srclib/apr-util/
./configure --enable-mods-shared=all --prefix=/usr/local/apache2 --with-mpm=prefork --with-pcre=/usr/local/bin/pcre-config --with-included-apr --with-z=/usr/local/lib --with-ssl=/usr/local/ssl/lib --with-sslport=443 --with-port=80 && make && make install && ./httpd -l && ./httpd -M 
cd ..
sleep 10


echo -e "Compiling PHP 5.6.10\n\n"
#&& make && make install && /usr/local/apache2/build/libtool --finish ../libs
cd php-5.6.10/
./configure --enable-mysqlnd \
            --enable-mbstring \
            --enable-calendar \
            --enable-intl \
            --enable-zip \
            --enable-cli \
            --disable-cgi \
            --with-apxs2=/usr/local/apache2/bin/apxs \
            --with-config-file-path=/etc \
            --with-pcre-regex \
            --with-mysqli=mysqlnd \
            --with-mysql-sock=/var/lib/mysql/mysql.sock \
            --with-pdo-mysql=mysqlnd \
            --with-readline=/usr/local/lib \
            --with-openssl-dir=/usr/local/ssl \
            --with-openssl=/usr/local/ssl \
            --with-zlib-dir=/usr/local \
            --with-zlib \
            --with-bz2=/usr/local/lib \
            --with-icu-dir=/usr/local \
            --with-mcrypt \
            --without-pear \
            --without-sqlite3 \
            --without-pdo-sqlite \
            && make && make install
cd ..
sleep 5


echo -e "\nCompiling ISC BIND 9.10.2-P1\n\n"
#           --enable-openssl-version-check \
#           --with-openssl=/usr/local/ssl \
#           --with-libxml2=PATH
#           --with-libjson=PATH
#           --with-dlopen=ARG       support dynamically loadable DLZ drivers
#           --with-dlz-mysql=PATH   Build with MySQL DLZ driver yes|no|path.
#           --enable-shared=yes \
#           --enable-static=yes \
#           --enable-openssl-hash \ 
#           --with-python=/usr/local/bin
cd bind-9.10.2-P1/
./configure && make && make install
cd ..
sleep 5

#################

##Learn about command line tool to rebuild your database.
##Learn about command line tool to restore your backed-up data.


echo -e "\nConfigure Apache HTTP Server 2.4.12 (httpd) files and directories.\n\n"
cd /etc/

echo -e "Adding new user 'apache' to /etc/passwd and /etc/shadow.\n
Adding new group 'apache' to /etc/group.\n"

if [ ! `grep "^apache:x:" /etc/passwd` ]
then
	useradd -r -U -N -c "Apache" -d /usr/local/apache -M -s /sbin/nologin apache \
        && echo -e "\n Added user and group 'apache'."
else
	echo -e "\nThe apache user and group already exist! No user or group added.\n"
fi
 
#You can do this, or create an httpd directory
#and put symlinks inside of it for conf, logs, and error
#inside of /usr/local/apache2/
if [ -d httpd ]
then
	rm -rfv httpd
fi

ln -sv /usr/local/apache2/ httpd

cd $OLDPWD
cd ../apps/httpd/

cp -v httpd /etc/sysconfig/
cp -v httpd.service /usr/lib/systemd/system/
cp -v -t /usr/local/apache2/conf/ httpd.conf *key *crt 

cd extra/
cp -v *.conf /usr/local/apache2/conf/extra/
cd ../../

if [ ! -d /var/www ]
then
	mkdir -pv /var/www/html
else
	mkdir -v  /var/www/html
fi

mkdir -pv /var/www/aerphp/includes
mkdir -v  /var/www/aerphp/logs
mkdir -v  /var/www/aerphp/sessions

chown -v apache:apache /var/www/aerphp/sessions/ /var/www/aerphp/logs/
chown -Rv apache:apache /usr/local/apache2/logs/ 



echo -e "\nConfigure PHP 5.6.9 files and directories.\n\n"
cd php/
cp -v php.ini /etc/
cd ..



echo -e "\nConfigure BIND 9.10.2-P1 (named) files and directories.\n\n"
cd named/

echo -e "Adding new user 'named' to /etc/passwd and /etc/shadow.\n
Adding new group 'named' to /etc/group.\n\n"

if [ ! `grep "^named:x:" /etc/passwd` ]
then
	useradd -r -U -c "named" -d /var/named -M -s /sbin/nologin named
else
	echo -e "\nThe named user and group already exist!\n"
fi

echo -e "\n"
grep "^named:" /etc/passwd
echo -e "\n"
sleep 2

cp -v *.service /usr/lib/systemd/system/
cp -v generate-rndc-key.sh /usr/libexec/
chmod -v 755 /usr/libexec/generate-rndc-key.sh
cp -v named.conf /etc/
cp -v named /etc/sysconfig/

if [ ! -d /var/named ]
then
	mkdir -v /var/named
	chown -v root:named /var/named
fi 

if [ ! -d /var/named/data ]
then
	mkdir -v /var/named/data
fi 

if [ ! -d /var/named/dynamic ]
then
	mkdir -v /var/named/dynamic
fi 

if [ ! -d /var/named/slaves ]
then
	mkdir -v /var/named/slaves
fi 

if [ ! -d /var/run/named ]
then
	mkdir -v /var/run/named
fi

chown -v named:named /var/named/data /var/named/dynamic /var/named/slaves /var/run/named
cp -fv -t /var/named/ anthonyerutledge.info named.root *.arpa

cd ../../sys/



echo -e "\n Enabling named, httpd, and mysql via systemd.\n\n"
systemctl daemon-reload
#systemctl enable named
systemctl enable httpd
systemctl enable mysqld

echo -e "\n Stopping named, httpd, and mysql via systemd.\n\n"
#systemctl stop named
systemctl stop httpd
systemctl stop mysqld

echo -e "\n Starting mysqld, httpd, and named via systemd.\n\n"
systemctl start mysqld 
systemctl start httpd
#systemctl start named

echo -e "Replacing /etc/resolv.conf with updated one.\n\n"
cp -fv resolv.conf /etc/

echo -e "Securing MySQL installation.\n\n"
/usr/bin/mysql_secure_installation

echo -e "Installing the anthonyerutledge database.\n\n"
mysql -u root -p'FreeBSD247!123' < ~/config/apps/mysql/anthonyerutledge.net.sql

echo -e "Allow incoming web traffic TCP 80/443).\n\n"
cp -fv iptables /etc/sysconfig/
systemctl restart iptables

echo -e "\nCongratulations! Your LAMP stack (with DNS & OpenSSL) has been successfully installed.\n\n"

