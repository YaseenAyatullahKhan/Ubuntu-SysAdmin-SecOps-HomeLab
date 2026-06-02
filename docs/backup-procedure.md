# Incident Response Archive and Backups
## Execution Walkthrough
First, identify the files that need to target inside the logs directory:
```
cd /var/log
ls *.log
```

Next, navigate back to the home directory and create the dedicated target directories:
```
cd ~
mkdir archive backup
```
Now, will perform a verbose archiving process. By running tar directly inside the target log folder, strip out unnecessary parent directory path configurations, producing a clean, localised archive:
```
cd /var/log
tar cvf ~/archive/log.tar *.log

# you may ignore the ones that say 'Permission denied'
```
Now, return to the home folder, confirm the creation of the archive, and list its contents (without extracting them) to verify integrity:
```
cd ~
ls archive
tar tf ./archive/log.tar
```
![Output Screenshot](/screenshots/ls-archive_tar-tf.png)

Finally, extract the logs inside the dedicated secure recovery directory and verify whether all the files have been extracted successfully:
```
cd backup
tar xvf ~/archive/log.tar
ls
```
![Output Screenshot](/screenshots/ls-backup.png)
---
**Possible improvement**: we can also write a bash script like the [user management](/scripts/user_management.sh) one I made to automate the backup procedure for a specified regular timing, and we could then copy that to an external memory device such as a backup SSD. For organisations and their IT teams, this would be an essential component of corporate cyber resilience.