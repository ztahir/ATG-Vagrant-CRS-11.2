#!/bin/bash
# check for the presence of required software

echo "Checking for the presence of required third-party software installers ..."

declare -a files=(
"jboss-eap-6.1.0.zip"
"jdk-7u72-linux-x64.rpm"
"OCPlatform11_2.bin"
"ojdbc7.jar"
"OCcas11.2.0-Linux64.bin"
"OCmdex6.5.2-Linux64_962107.bin"
"OCplatformservices11.2.0-Linux64.bin"
"V78229-01.zip"
"OCReferenceStore11.2_222RCN.bin"
)

for file in "${files[@]}"
do
	echo "Checking for the presence of $file in the software directory"
	if [ ! -f /vagrant/software/$file ]; then
		echo "ERROR! Missing third-party software: $file."
		exit 1
	else
		echo "$file found"
	fi

	echo "Checking md5 sum of $file"
	if [ ! `cat /vagrant/software/$file.md5` = `md5sum /vagrant/software/$file | cut -d ' ' -f 1` ]; then
		echo "ERROR! md5sum for $file does not match.  File is corrupt."
		exit 1
	else
		echo "checksum matches"
	fi
done

echo "All required third-party software found."