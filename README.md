<strong>This script will help you perform an automatic backup of virtual machines in case of any VMware versions.</strong>



How to use it? 

1. Connect to VMware via SSH (you may need to start the service in the VMware panel), 

2. Create a file in any location that suits you best using the vi /patch/backup.sh command, 

3. Copy the code and replace the options in the configuration section (provide your virtual machine names and paths, the default start is included in 
the script, as well as the location where the backup is to be performed, tested on NFS), 

4. Save the file and make it executable (chmod +x /patch/backup.sh), 

5. Add an entry in the crontab (vi /var/spool/cron/crontab/root) 
if you don't know how to set up a cron, this website will help you https://crontab.guru/ after adding the necessary values, save the file by entering: wq!,
an example cron configuration that performs a backup once a day at 1am is "00 1 * * * sh /patch/backup.sh".
