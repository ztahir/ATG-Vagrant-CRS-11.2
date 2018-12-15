# install CRS application artifacts into ATG servers directory and jboss

# do this as vagrant
exec sudo -u vagrant /bin/bash -l << eof

	# copy jboss application descriptors
	cp /vagrant/scripts/atg/crs_artifacts/ATGProduction.xml /vagrant/scripts/atg/crs_artifacts/ATGPublishing.xml /home/vagrant/jboss/standalone/configuration

	# create jboss deployments
/home/vagrant/ATG/ATG11.3/home/bin/runAssembler -server "atg_production_lockserver" -jboss "/home/vagrant/jboss/standalone/deployments/ATGProduction/ATGProduction.ear" -m DCS.AbandonedOrderServices DafEar.Admin DPS DSS ContentMgmt DCS.PublishingAgent DCS.AbandonedOrderServices ContentMgmt.Endeca.Index DCS.Endeca.Index DCS.Endeca.Assembler Store.Endeca.Index Store.Endeca.Assembler DAF.Endeca.Assembler DCS.Endeca.Index.SKUIndexing Store.Storefront Store.Recommendations Store.Mobile Store.Fluoroscope Store.Mobile.REST Store.Mobile.Recommendations REST.JAXRSPublic.Version1 PublishingAgent REST.base REST.Actor 
/home/vagrant/ATG/ATG11.3/home/bin/runAssembler -server "atg_publishing_lockserver" -jboss "/home/vagrant/jboss/standalone/deployments/ATGPublishing/ATGPublishing.ear" -m DCS-UI.Versioned BIZUI PubPortlet DafEar.Admin ContentMgmt.Versioned DCS.Versioned DCS-UI Store.EStore.Versioned Store.Storefront DCS-UI.SiteAdmin.Versioned SiteAdmin.Versioned ContentMgmt.Endeca.Index.Versioned DCS.Endeca.Index.Versioned DCS.Endeca.Assembler.Versioned Store.Endeca.Index.Versioned Store.Endeca.Assembler.Versioned DCS.Endeca.Index.SKUIndexing Store.Mobile Store.Mobile.Versioned Store.Mobile.REST.Versioned 

	# make sure jboss knows to deploy
	touch /home/vagrant/jboss/standalone/deployments/ATGProduction/ATGProduction.ear.dodeploy
	touch /home/vagrant/jboss/standalone/deployments/ATGPublishing/ATGPublishing.ear.dodeploy

	# copy ATG server configs
	unzip -n /vagrant/scripts/atg/crs_artifacts/server-ATGProduction.zip -d /home/vagrant/ATG/ATG11.3/home/servers
	unzip -n /vagrant/scripts/atg/crs_artifacts/server-ATGPublishing.zip -d /home/vagrant/ATG/ATG11.3/home/servers

	# copy ATG version file store
	unzip -n /vagrant/scripts/atg/crs_artifacts/versionFileStore.zip -d /home/vagrant/ATG/ATG11.3/home/Publishing

	# initialize the CRS Eac artifacts
	cp -r /home/vagrant/ATG/ATG11.3/CommerceReferenceStore/Store/Storefront/deploy /home/vagrant/deploy
	/usr/local/endeca/ToolsAndFrameworks/11.3.1.5.0/deployment_template/bin/deploy.sh --app /home/vagrant/deploy/deploy.xml < /vagrant/scripts/atg/deploy_CRS_endeca_silent.silentinput
	/usr/local/endeca/Apps/CRS/control/initialize_services.sh --force


eof