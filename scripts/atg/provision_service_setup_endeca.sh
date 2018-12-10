echo "setting up endeca services"

mkdir -p /home/vagrant/scripts
chown vagrant.vagrant /home/vagrant/scripts

cp /vagrant/scripts/atg/endeca/endecaplatform /etc/init.d/endecaplatform
chmod 750 /etc/init.d/endecaplatform
chkconfig --add endecaplatform

cp /vagrant/scripts/atg/endeca/endecaworkbench /etc/init.d/endecaworkbench
chmod 750 /etc/init.d/endecaworkbench
chkconfig --add endecaworkbench

cp /vagrant/scripts/atg/endeca/endecacas /etc/init.d/endecacas
chmod 750 /etc/init.d/endecacas
chkconfig --add endecacas

# start all services
/vagrant/scripts/atg/start_endeca_services.sh

echo "endeca service setup complete"
echo " "

echo "Started installing expect"
yum -y install expect
echo "Finished installing expect"
echo " "

echo "Started changing Endeca Workbench Credentials"
expect /vagrant/scripts/atg/endeca/change_credentials
echo " "
echo "Finished changing Endeca Workbench Credentials"
echo " "
echo "Started changing Endeca Config Repository Password "
curl -FoldPwd=admin -FnewPwd=Admin123 -FnewPwdConfirm=Admin123 http://admin:admin@localhost:8006/ifcr/system/userManager/user/admin.changePassword.json
echo " "
echo "Finished changing Endeca Config Repository Password "
echo " "

# stop all services
/vagrant/scripts/atg/stop_endeca_services.sh
sleep 60

echo "Started updating the webstudio with new password"
ex -s -c "%s/#ifcr.password=admin/ifcr.password=Admin123/g|x" /usr/local/endeca/ToolsAndFrameworks/11.3.1.5.0/server/workspace/conf/webstudio.properties
echo "Finished updating the webstudio with new password"

# start all services
/vagrant/scripts/atg/start_endeca_services.sh
