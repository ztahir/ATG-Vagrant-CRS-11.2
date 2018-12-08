# ATG CRS Quickstart Guide

### About

This document describes a quick and easy way to install and play with ATG CRS.  By following this guide, you'll be able to focus on learning about ATG CRS, without debugging common gotchas.

If you get lost, you can consult the [ATG CRS Installation and Configuration Guide](https://docs.oracle.com/cd/E55783_02/CRS.11-2/ATGCRSInstall/ATGCRSInstall.pdf) for help.

### Conventions

Throughout this document, the top-level directory that you checked out from git will be referred to as `{ATG-CRS}`

### Product versions used in this guide:

- Oracle Linux Server release 6.5 (Operating System) - [All Licenses](https://oss.oracle.com/linux/legal/pkg-list.html)
- Oracle Database 12c
  - Oracle Database 12.1.0.2.0 Enterprise Edition - [license](http://docs.oracle.com/database/121/DBLIC/toc.htm)
- Oracle ATG Web Commerce 11.2 - 
- JDK 1.7 - [Oracle BCL license](http://www.oracle.com/technetwork/java/javase/terms/license/index.html)
- ojdbc7.jar - driver [OTN license](http://www.oracle.com/technetwork/licenses/distribution-license-152002.html)
- Jboss EAP 6.1 - [LGPL license](http://en.wikipedia.org/wiki/GNU_Lesser_General_Public_License)

### Other software dependencies

- Vagrant - [MIT license](https://github.com/mitchellh/vagrant/blob/master/LICENSE)
- VirtualBox - [License FAQ](https://www.virtualbox.org/wiki/Licensing_FAQ) - [GPL](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
- vagrant-vbguest plugin - [MIT license](https://github.com/dotless-de/vagrant-vbguest/blob/master/LICENSE)
- Oracle SQL Developer - [license](http://www.oracle.com/technetwork/licenses/sqldev-license-152021.html)

### Technical Requirements

This product stack is pretty heavy.  It's a DB, three endeca services and two ATG servers.  You're going to need:

- 16 gigs RAM

## Download Required Database Software

The CRS demo works with Oracle 12c.  

### Oracle 12c (12.1.0.2.0) Enterprise Edition

- Go to [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index-092322.html)
- Accept the license agreement
- Under the section "(12.1.0.2.0) - Enterprise Edition" download parts 1 and 2 for Linux x86-64

**IMPORTANT:** Put the zip files parts 1 and 2, in the `{ATG-CRS}/software`directory at the top level of this project (it's the directory that has a `readme.txt`file telling you how to use the directory).

### Oracle SQL Developer

You will also need a way to connect to the database.  I recommend [Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html).

## Download required ATG server software

### ATG 11.2

These instructions download a previous release of Oracle ATG (11.2). At the time of this writing the latest release is 11.3.1  The scripts are coded to assume that the Oracle ATG assets have 11.2 in the name, so you can't just download 11.2 and have it work here.  Sorry.

- Go to [Oracle Edelivery](http://edelivery.oracle.com)
- Sign in
- Accept the restrictions
- On the search page, search for and select the following components:
  - Oracle ATG Web Commerce
  - Oracle Endeca Developer
- Select the platform "Linux x86-64"
- Click Continue
- Click "select alternate release" and select 11.2.0.0.0
- Click Continue
- Accept the terms and conditions
- You don't need to download everything.  Download the following files:
  - "Oracle Commerce Platform"
  - "Oracle Commerce Reference Store"
  - "Oracle Commerce MDEX Engine"
  - "Oracle Commerce Content Acquisition System"
  - "Oracle Commerce Experience Manager Tools and Frameworks"
  - "Oracle Commerce Guided Search Platform Services"

**NOTE**  The Experience Manager Tools and Frameworks zipfile expands to a `cd` directory containing an installer.  It's not strictly required to unzip this file.  If you don't unzip the provisioner will do it for you.

## Download required ATG server software

### ATG 11.1

These instructions download a previous release of Oracle ATG (11.1). At the time of this writing the latest release is 11.2.  The scripts are coded to assume that the Oracle ATG assets have 11.1 in the name, so you can't just download 11.2 and have it work here.  Sorry.

- Go to [Oracle Edelivery](http://edelivery.oracle.com)
- Sign in
- Accept the restrictions
- On the search page, search for and select the following components:
  - Oracle ATG Web Commerce
  - Oracle Endeca Developer
- Select the platform "Linux x86-64"
- Click Continue
- Click "select alternate release" and select 11.1.0.0.0
- Click Continue
- Accept the terms and conditions
- You don't need to download everything.  Download the following files:
  - "Oracle Commerce Platform"
  - "Oracle Commerce Reference Store"
  - "Oracle Commerce MDEX Engine"
  - "Oracle Commerce Content Acquisition System"
  - "Oracle Commerce Experience Manager Tools and Frameworks"
  - "Oracle Commerce Guided Search Platform Services"

**NOTE**  The Experience Manager Tools and Frameworks zipfile (V78229-01.zip) expands to a `cd` directory containing an installer.  It's not strictly required to unzip this file.  If you don't unzip V78229-01.zip the provisioner will do it for you.

### JDK 1.7

- Go to the [Oracle JDK 7 Downloads Page](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)
- Download "jdk-7u72-linux-x64.rpm"

### JBoss EAP 6.1

- Go to the [JBoss product downloads page](http://www.jboss.org/products/eap/download/)
- Click "View older downloads"
- Click on the zip downloader for 6.1.0.GA

### OJDBC Driver

- Go to the [Oracle 12c driver downloads page](http://www.oracle.com/technetwork/database/features/jdbc/jdbc-drivers-12c-download-1958347.html)
- Download ojdbc7.jar

All oracle drivers are backwards compatible with the officially supported database versions at the time of the driver's release.  You can use ojdbc7 to connect to either 12c or 11g databases.

**IMPORTANT:** Move everything you downloaded to the `{ATG-CRS}/software`directory at the top level of this project.

## Software Check

Before going any further, make sure your software directory looks like one of the following:

```
software/
├── OCPlatform11_2.bin
├── OCcas11.2.0-Linux64.bin
├── V78229-01.zip
├── linuxamd64_12102_database_1of2.zip
├── linuxamd64_12102_database_2of2.zip
├── OCReferenceStore11.2_222RCN.bin
├── jboss-eap-6.1.0.zip
├── jdk-7u72-linux-x64.rpm
├── OCmdex6.5.2-Linux64_962107.bin
├── OCStoreAccelerator11_2.bin
├── ojdbc7.jar
├── OCplatformservices11.2.0-Linux64.bin
└── readme.txt
```



## Install Required Virtual Machine Software

Install the latest version of [Vagrant](http://www.vagrantup.com/downloads.html). Install the **latest 5.x** release of [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Also get the [vagrant-vbguest plugin](https://github.com/dotless-de/vagrant-vbguest).  You install it by typing from the command line:


`vagrant plugin install vagrant-vbguest`

## Create the database vm

This project comes with two databases vm definition.


For Database VM type

`vagrant up db12c`

This will set in motion an amazing series of events, *and can take a long time*, depending on your RAM, processor speed, and internet connection speed.  The scripts will:

- download an empty centos machine
- switch it to Oracle Linux (an officially supported platform for Oracle 12g and ATG 11.2)
- install all prerequisites for the oracle database
- install and configure the oracle db software
- create an empty db name `orcl`
- import the CRS / CSA tables and data

To get a shell on the db vm, type

`vagrant ssh db12c`

You'll be logged in as the user "vagrant".  This user has sudo privileges (meaning you can run `somecommand`as root by typing `sudo somecommand`). To su to root (get a root shell), type `su -`.  The root password is "vagrant".  If you want to su to the oracle user, the easiest thing to do is to su to root and then type `su - oracle`.  The "oracle" user is the user that's running oracle and owns all the oracle directories.  The project directory will be mounted at `/vagrant`.  You can copy files back and forth between your host machine and the VM using that directory.

Key Information:

- The db vm has the private IP 192.168.70.4.  This is defined at the top of the Vagrantfile.
- The system username password combo is system/oracle
- The ATG schema names are crs_core,crs_pub,crs_cata,crs_catb.  Passwords are the same as schema name.
- The SID (database name) is orcl
- It's running on the default port 1521
- You can control the oracle server with a service: "sudo service dbora stop|start"



## Create the "atg" vm

`vagrant up atg`

When it's done you'll have a vm created that is all ready to install and run ATG CRS.  It will have installed jdk7 at /usr/java/jdk1.7.0_72 and jboss at /home/vagrant/jboss/.  You'll also have the required environment variables set in the .bash_profile of the "vagrant" user.

To get a shell on the atg vm, type

`vagrant ssh atg`

Key Information:

- The atg vm has the private IP 192.168.70.5.  This is defined at the top of the Vagrantfile.
- java is installed in `/usr/java/jdk1.7.0_72`
- jboss is installed at `/home/vagrant/jboss`
- Your project directory is mounted at `/vagrant`.  You'll find the installers you downloaded at `/vagrant/software`from within the atg vm
- All the endeca software is installed under `/usr/local/endeca`and your CRS endeca project is installed under `/usr/local/endeca/Apps`

## Run the ATGPublishing and ATGProduction servers

For your convenience, this project contains scripts that start the ATG servers with the correct options.  Use `vagrant ssh atg`to get a shell on the atg vm, and then run:

`/vagrant/scripts/atg/startPublishing.sh`

and then in a different shell

`/vagrant/scripts/atg/startProduction.sh`

Both servers start in the foreground.  To stop them either press control-c or close the window.

Key Information:

- The ATGProduction server's primary HTTP port is 8080.  You access its dynamo admin at: http://192.168.70.5:8080/dyn/admin
- The ATGPublishing server's primary HTTP port is 8180.  You access its dynamo admin at: http://192.168.70.5:8180/dyn/admin.  It's started with the JBoss option `-Djboss.socket.binding.port-offset=100`so every port is 100 more than the corresponding ATGProduction port.
- The ATG admin username and password is: admin/Admin123.  It will may ask you to change that on first login. If it does then change that to Admin1234. This applies to both ATGPublishing and ATGProduction.  Use this to log into Dynamo Admin and the BCC
- The various endeca components are installed as the following services. From within the atg vm, you can use the scripts `/vagrant/scripts/atg/start_endeca_services.sh`and `/vagrant/scripts/atg/stop_endeca_services.sh`to start|stop all the endeca services at once:
  - endecaplatform
  - endecaworkbench
  - endecacas

## Run initial full deployment

At this point, you can pick up the ATG CRS documentation from the [Configuring and Running a Full Deployment](https://docs.oracle.com/cd/E55783_02/CRS.11-2/ATGCRSInstall/html/s0214configuringandrunningafulldeploy01.html) section.  Your publishing server has all the CRS data, but nothing has been deployed to production.  You need to:

- Deploy the crs data
- Check the Endeca baseline index status
- Promote the CRS content from the command line

### Deploy the crs data

Do this from within the BCC by following the [docs](https://docs.oracle.com/cd/E55783_02/CRS.11-2/ATGCRSInstall/html/s0214configuringthedeploymenttopology01.html)

### Check the baseline index status

Do this from within the Dynamo Admin by following the [docs](https://docs.oracle.com/cd/E55783_02/CRS.11-2/ATGCRSInstall/html/s0215checkingthebaselineindexstatus01.html)

### Promote the endeca content

Do this from the command line from within the atg vm:

`vagrant ssh atg`

`/usr/local/endeca/Apps/CRS/control/promote_content.sh`

### Access the storefront

The CRS application is live at: 

http://192.168.70.5:8080/crs

