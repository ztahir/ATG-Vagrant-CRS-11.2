# install CRS application artifacts into ATG servers directory and jboss

# do this as vagrant
exec sudo -u vagrant /bin/bash -l << eof

	# copy jboss application descriptors
	cp /vagrant/scripts/atg/crs_artifacts/ATGProduction.xml /vagrant/scripts/atg/crs_artifacts/ATGPublishing.xml /home/vagrant/jboss/standalone/configuration

	# create jboss deployments
/home/vagrant/ATG/ATG11.3/home/bin/runAssembler -server "ATGProduction" -jboss "/home/vagrant/jboss/standalone/deployments/ATGProduction/ATGProduction.ear" -m Store.EStore.International DCS.AbandonedOrderServices DafEar.Admin DPS DSS ContentMgmt DCS.PublishingAgent DCS.AbandonedOrderServices ContentMgmt.Endeca.Index DCS.Endeca.Index DCS.Endeca.Assembler Store.Endeca.Index Store.Endeca.Assembler DAF.Endeca.Assembler Store.WCSExtensions Store.WCSExtensions.Endeca.Index PublishingAgent REST.JAXRSPublic.Version1 DCS.Endeca.Index.SKUIndexing Store.Storefront Store.EStore.International Store.Recommendations Store.Mobile Store.Endeca.International Store.WCSExtensions.International Store.WCSExtensions.Endeca.International Store.Fluoroscope Store.Fulfillment Store.KnowledgeBase.International Store.Mobile.REST Store.Mobile.Recommendations Store.Mobile.International REST.base REST.Actor Store.Recommendations.International
/home/vagrant/ATG/ATG11.3/home/bin/runAssembler -server "ATGPublishing" -jboss "/home/vagrant/jboss/standalone/deployments/ATGPublishing/ATGPublishing.ear" -m DCS-UI.Versioned BIZUI PubPortlet DafEar.Admin ContentMgmt.Versioned DCS-UI.SiteAdmin.Versioned SiteAdmin.Versioned DCS.Versioned DCS-UI Store.EStore.Versioned Store.Storefront ContentMgmt.Endeca.Index.Versioned DCS.Endeca.Index.Versioned DCS.Endeca.Assembler.Versioned Store.Endeca.Index.Versioned Store.Endeca.Assembler.Versioned DAF.Endeca.Reader.Versioned Store.Endeca.Reader Store.WCSExtensions.Versioned Store.WCSExtensions.Endeca.Index.Versioned WCSExtensions.Endeca.Reader.Versioned DCS.Endeca.Index.SKUIndexing Store.EStore.International.Versioned Store.Mobile Store.Mobile.Versioned Store.Endeca.International Store.Endeca.International.Reader Store.WCSExtensions.International.Versioned Store.WCSExtensions.Endeca.International Store.KnowledgeBase.International Store.Mobile.REST.Versioned Store.Mobile.International.Versioned

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