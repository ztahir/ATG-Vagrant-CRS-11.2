# do this as vagrant
exec sudo -u vagrant /bin/bash -l << eof

	# jboss
	unzip -n /vagrant/software/jboss-eap-7.0.0.zip -d /home/vagrant
	ln -s /home/vagrant/jboss-eap-7.0 /home/vagrant/jboss

	# install the ojdbc driver
	mkdir -p /home/vagrant/jboss/modules/com/oracle/ojdbc7/main
	cp /vagrant/software/ojdbc7.jar /home/vagrant/jboss/modules/com/oracle/ojdbc7/main
	cp /vagrant/scripts/atg/module.xml /home/vagrant/jboss/modules/com/oracle/ojdbc7/main

	# atg
	echo "installing ATG Platform 11.3 ..."
	/vagrant/software/OCPlatform11_3_1.bin -i silent -f /vagrant/scripts/atg/OCPlatform11_3_1.properties
	echo "ATG Platform 11.3 installation complete"

	# atg
	echo "installing ATG CRS 11.3 ..."
	/vagrant/software/OCReferenceStore11_3_1.bin -i silent -f /vagrant/scripts/atg/silent_crs11.3.properties
	echo "ATG CRS 11.3 installation complete"


	echo "installation done"

eof