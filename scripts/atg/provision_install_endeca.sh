# endeca

# do this as vagrant
exec sudo -u vagrant /bin/bash -l << eof

	# MDEX
	#/vagrant/software/OCmdex6.5.2-Linux64_962107.bin --silent --target /usr/local
	echo "installing mdex"
    /vagrant/software/OCmdex6.5.2-Linux64_962107.bin -i silent -f /vagrant/scripts/atg/mdex_response.properties

	source /usr/local/endeca/MDEX/6.5.2/mdex_setup_sh.ini

	echo "installing platform"

	# platform services
	#/vagrant/software/OCplatformservices11.2.0-Linux64.bin --silent --target /usr/local/ < /vagrant/scripts/atg/endeca_platformservices_silent.silentinput 
	/vagrant/software/OCplatformservices11.2.0-Linux64.bin -i silent -f /vagrant/scripts/atg/ps_response.properties
	source /usr/local/endeca/PlatformServices/workspace/setup/installer_sh.ini

	echo "installing tools and framework"

	# tools and frameworks
	export ENDECA_TOOLS_ROOT=/usr/local/endeca/ToolsAndFrameworks/11.2.0
	export ENDECA_TOOLS_CONF=/usr/local/endeca/ToolsAndFrameworks/11.2.0/server/workspace

	if [ -f /vagrant/software/V78229-01.zip ]; then
		unzip -n /vagrant/software/V78229-01.zip -d /vagrant/software
	fi

	/vagrant/software/cd/Disk1/install/silent_install.sh /vagrant/scripts/atg/endeca_toolsandframeworks_silent_response.rsp \
		ToolsAndFrameworks /usr/local/endeca/ToolsAndFrameworks

	sudo /home/vagrant/oraInventory/orainstRoot.sh

	/vagrant/software/cd/Disk1/install/silent_install.sh /vagrant/scripts/atg/endeca_toolsandframeworks_silent_response.rsp \
		ToolsAndFrameworks /usr/local/endeca/ToolsAndFrameworks /home/vagrant/oraInventory/oraInst.loc

	sudo /home/vagrant/oraInventory/orainstRoot.sh

	echo "installing cas"
	# CAS
	#/vagrant/software/OCcas11.2.0-Linux64.sh --silent --target /usr/local < /vagrant/scripts/atg/endeca_cas_silent.silentinput
    /vagrant/software/OCcas11.2.0-Linux64.bin -i silent -f /vagrant/scripts/atg/cas_response.properties

	# setup bash profile now that the required files are installed

	echo "source /usr/local/endeca/MDEX/6.5.2/mdex_setup_sh.ini" >> /home/vagrant/.bash_profile \
	 && echo "source /usr/local/endeca/PlatformServices/workspace/setup/installer_sh.ini" >> /home/vagrant/.bash_profile
eof