#!/bin/bash
#config:

#1 VM Names
vms="vm1 vm2 vm3"

#2 VMs patch
vmpatch="/vmfs/volumes/xxxxxx"

#3 Backup patch
bacpatch="/xxx/xxxx/xxx"
    
for vm in $vms
do

echo $vm

    #create snapchat
    id=$(vim-cmd vmsvc/getallvms | grep $vm | awk '{print $1}')    
    vim-cmd vmsvc/snapshot.create $id "$vm-$(date +%Y-%m-%d)"

    
    #Create backup folder
    backup_folder="Backup-$vm-$(date +%Y-%m-%d)"
    mkdir $bacpatch/$backup_folder

    #Copy config
    cp $vmpatch/$vm/$vm.vmx $bacpatch/$backup_folder

    #Copy HDD
    vmkfstools -i $vmpatch/$vm/$vm.vmdk $bacpatch/$backup_folder/$vm.vmdk -d thin

    # remove snapchat    
    vim-cmd vmsvc/snapshot.remove $id $(vim-cmd vmsvc/snapshot.get $id | grep Id | cut -d":" -f 2 | cut -c2-)

done

#Retention - change "days" on numer - 1 (one day), 2 (two days), etc
find $bacpatch/backup/* -type d -mtime +[days] -exec rm -rf {} \;
