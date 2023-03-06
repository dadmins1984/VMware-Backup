#!/bin/bash

#VM Names
vms="vm1 vm2 vm3"
    
for vm in $vms
do

echo $vm

    #create snapchat
    id=$(vim-cmd vmsvc/getallvms | grep $vm | awk '{print $1}')    
    vim-cmd vmsvc/snapshot.create $id "$vm-$(date +%Y-%m-%d)"

    
    #Create backup folder
    backup_folder="Backup-$vm-$(date +%Y-%m-%d)"
    mkdir /vmfs/volumes/ad2cb76d-7a43d63f/New/$backup_folder

    #Copy config
    cp /path/to/$vm/$vm.vmx /path/to/backup/$backup_folder

    #Copy HDD
    vmkfstools -i /patch/to/$vm/$vm.vmdk /patch/to/backup/$backup_folder/$vm.vmdk -d thin

    # emove snapchat    
    vim-cmd vmsvc/snapshot.remove $id $(vim-cmd vmsvc/snapshot.get $id | grep Id | cut -d":" -f 2 | cut -c2-)

done

#Retention
find /vmfs/volumes/ad2cb76d-7a43d63f/New/* -type d -mtime +[days] -exec rm -rf {} \;
