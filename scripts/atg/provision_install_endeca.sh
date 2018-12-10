# endeca

# do this as vagrant
exec sudo -u vagrant /bin/bash -l << eof

	# MDEX
	#/vagrant/software/OCmdex6.5.2-Linux64_962107.bin --silent --target /usr/local
	echo "installing mdex"
    /vagrant/software/OCmdex11.3.1.5-Linux64_1326782.bin -i silent -f /vagrant/scripts/atg/mdex_response11.3.properties

	source /usr/local/endeca/MDEX/11.3.1.5/mdex_setup_sh.ini

	echo "installing platform"
	# platform services
	/vagrant/software/OCplatformservices11.3.1.5.0-Linux64_1554774RCN.bin -i silent -f /vagrant/scripts/atg/ps_response11.3.properties
	source /usr/local/endeca/PlatformServices/workspace/setup/installer_sh.ini

	echo "installing tools and framework"
	# tools and frameworks
	export ENDECA_TOOLS_ROOT=/usr/local/endeca/ToolsAndFrameworks/11.3.1.5.0
	export ENDECA_TOOLS_CONF=/usr/local/endeca/ToolsAndFrameworks/11.3.1.5.0/server/workspace

	if [ -f /vagrant/software/V980671-01.zip ]; then
		unzip -n /vagrant/software/V980671-01.zip -d /vagrant/software
	fi

	/vagrant/software/cd/Disk1/install/silent_install.sh /vagrant/scripts/atg/endeca_toolsandframeworks_silent_response.rsp \
		ToolsAndFrameworks /usr/local/endeca/ToolsAndFrameworks

	sudo /home/vagrant/oraInventory/orainstRoot.sh

	/vagrant/software/cd/Disk1/install/silent_install.sh /vagrant/scripts/atg/endeca_toolsandframeworks_silent_response.rsp \
		ToolsAndFrameworks /usr/local/endeca/ToolsAndFrameworks /home/vagrant/oraInventory/oraInst.loc


	sudo /home/vagrant/oraInventory/orainstRoot.sh

	echo "installing cas"
	# CAS
    /vagrant/software/OCcas11_3_1_5-Linux64.bin  -i silent -f /vagrant/scripts/atg/cas_response11.3.properties

	# setup bash profile now that the required files are installed
	echo "source /usr/local/endeca/MDEX/11.3.1.5/mdex_setup_sh.ini" >> /home/vagrant/.bash_profile \
	 && echo "source /usr/local/endeca/PlatformServices/workspace/setup/installer_sh.ini" >> /home/vagrant/.bash_profile
eof