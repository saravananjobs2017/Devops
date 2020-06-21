#!/bin/bash/

check_status() {
if [ $retcode -ne 0 ]
then
echo " error"
exit 1
else
echo "completed"
fi
}

creation_area() {

az login -u $1 -p $2 
retcode=`echo $?`
check_status

az group create --name $resource_grp  --location $loc
retcode=`echo $?`
check_status

az network vnet create --name $vnet_name --resource-group $resource_grp --subnet-name default
retcode=`echo $?`
check_status


az vm create --resource-group $resource_grp --name $vm_name --image CentOS  --generate-ssh-keys  --output json --verbose 
retcode=`echo $?`
check_status

VM1_IP_ADDR=$(az vm show -d -g $resource_grp -n $vm_name --query publicIps -o tsv)
retcode=`echo $?`
check_status

echo $VM1_IP_ADDR

}
source Config.sh

creation_area username password 