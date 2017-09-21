#!/bin/bash

# Author: Sudharsan R
# Purpose: Create a local repo for SOLR

export SOLR_VERSION=6.6.1
tempFolder=/tmp
appName=HDP-SOLR
appId=HDP-SOLR-2.6-100
basefolder=/opt/lucidworks-hdpsearch
packageName=solr


rootfolder=$tempFolder/$appName
basepath=$rootfolder/$basefolder

sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y apache2 #apache2-doc apache2-utils 
sudo apt-get install -y dpkg-dev


mkdir -p $basepath && cd $basepath
wget http://www.namesdir.com/mirrors/apache/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz
tar zxvf solr-$SOLR_VERSION.tgz
git clone https://github.com/lucidworks/banana.git
mv banana solr-$SOLR_VERSION/server/solr-webapp/webapp/.
mv solr-$SOLR_VERSION solr
rm solr-$SOLR_VERSION.tgz

# Create DEBIAN control file
mkdir -p $rootfolder/DEBIAN
cat <<EOF > $rootfolder/DEBIAN/control
Package: solr
Architecture: all
Priority: optional
Maintainer: "Sudharsan R"
Version: $SOLR_VERSION
Description: solr SOLR_VERSION package for local repo
EOF

# Build debian package
cd $rootfolder
dpkg-deb --build . solr.deb
cd $tempFolder
dpkg-scanpackages $appName /dev/null | gzip -9c > $rootfolder/Packages.gz

# Install package in webserver
#sudo mkdir -p /var/www/html/$appId/repos/ubuntu14/$appName && cd /var/www/html/$appId/repos/ubuntu14/$appName
sudo mkdir -p /var/www/html/$appId/repos/ubuntu14/dists/$appName/Release/binary-amd64 && cd /var/www/html/$appId/repos/ubuntu14/dists/$appName/Release/binary-amd64
sudo mv $rootfolder/solr.deb $rootfolder/Packages.gz ./

sudo ln -sf /var/www/html/$appId/repos/ubuntu14/dists/$appName/Release /var/www/html/$appId/repos/ubuntu14/dists/$appName/main

# Commented. These will be written by Ambari.
# Write repo information
#cd /etc/apt/sources.list.d && sudo bash -c "cat <<EOF > solr.list
#deb http://$(hostname -f)/$appId/repos/ubuntu14 $appName/
#EOF"

# Install local repo
#sudo apt-get update && sudo apt-get install solr

# Remove temporary and downloaded files
rm -Rf $rootfolder


