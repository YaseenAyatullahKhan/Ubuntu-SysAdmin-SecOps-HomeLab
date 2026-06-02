#!/bin/bash                                                                     

set_user(){                                                                     
        printf "Enter username:\n"                                              
        read USERNAME                                                           

        if getent passwd "$USERNAME"; then                                      
                printf "Username \'$USERNAME\' exists, choose a different one.\n\n"                                                                               
                set_user                                                        
        fi                                                                      
}                                                                               

set_group(){
        printf "Enter group name:\n"                                            
        read GROUP                                                              

        if getent group "$GROUP"; then                                          
                printf "Group name \'$GROUP\' exists, choose a different one.\n"
                set_group                                                       
        fi                                                                      
}                                                                               

# Execute interactive checks
set_user                                                                        
set_group                                                                       

# System provisioning using sudo for root access
sudo groupadd $GROUP; printf "$GROUP group was created.\n"                      
sudo useradd -m -s /bin/bash -g $GROUP $USERNAME; printf "$USERNAME username was created.\n"                                                                    
sudo passwd $USERNAME                                                           

# Secure Home Folder Creation at Root
sudo mkdir /$USERNAME                                                           
sudo chown $USERNAME:$GROUP /$USERNAME                                          
sudo chmod 1770 /$USERNAME                                                    

echo "Script executed successfully!"