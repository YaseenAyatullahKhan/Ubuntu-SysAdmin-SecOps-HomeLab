# Multi-Tenant Access Isolation
## Step-by-Step Implementation:

First, unlock root privilege access for this virtual machine
```
sudo passwd root

# Enter osboxes.org as the current user password
# Set your own password for the root user

su -
# Enter your root user password when prompted
```
Next, create the three departmental directories at the root (`/`) directory:
```
mkdir production marketing IT

# Verify directory creation
ls
```
Now, create the corresponding system groups for each department:  
*(note the lowercase naming convention for groups)*
```
addgroup production
addgroup marketing
addgroup it

# Verify that the groups were successfully created ↓
```

![Output Screenshot](/screenshots/egrep_group.png)

After the directories and groups are made, create the administrative users. Assign them to their respective primary group using the `-g` flag and enforce a secure `/bin/bash` login shell for better security:
```
useradd -m -s /bin/bash -g production prd-admin
useradd -m -s /bin/bash -g marketing mkt-admin
useradd -m -s /bin/bash -g it IT-admin

# Verify that the admin users were successfully created ↓
```

![Output Screenshot](/screenshots/egrep_passwd.png)

Next, add the remaining departmental staff members to their respective primary groups:
```
# Production Staff
useradd -m -s /bin/bash -g production prd-user-1
useradd -m -s /bin/bash -g production prd-user-2

# Marketing Staff
useradd -m -s /bin/bash -g marketing mkt-user-1
useradd -m -s /bin/bash -g marketing mkt-user-2

# IT Staff
useradd -m -s /bin/bash -g it IT-user-1
useradd -m -s /bin/bash -g it IT-user-2
```
Now, apply secure group ownership to the directories and modify file permissions. Use the octal mode `1770`:

- **Simple breakdown of octal system used**: First digit specifies whether we want to use special permissions, second digit is for the file/directory owner's permissions, third digit for the group owner of the file/directory, fourth for any other user.
- **The Sticky Bit (`1`)**: The special permission that enforces a rule where only the file owner, directory owner, or root user can delete or rename files within the directory. This is to prevent staff members from deleting each other's work.
- **Owner & Group Read/Write/Execute (`770`)**: Grants the admin and group members full control over the folder, while completely blocking unauthorised users on the system (due to the 0).
```
# Apply directory ownership (AdminUser:DepartmentGroup)
chown prd-admin:production production
chown mkt-admin:marketing marketing
chown IT-admin:it IT

# Harden directory permissions and apply the Sticky Bit
chmod 1770 production
chmod 1770 marketing
chmod 1770 IT
```
Finally, create a secure, confidential text document inside each department directory. Assign permissions of `740` so that only the administrative user can modify the document, while departmental staff are restricted to read-only access:
```
# Create the documents
echo "This file contains confidential information for the department." > production/confidential.txt
echo "This file contains confidential information for the department." > marketing/confidential.txt
echo "This file contains confidential information for the department." > IT/confidential.txt

# Harden document permissions (Read/Write/Execute for Admin, Read-only for Group, None for Others)
chmod 740 production/confidential.txt
chmod 740 marketing/confidential.txt
chmod 740 IT/confidential.txt
```
Verify the creation of the confidential file as well as the permissions set to it:

![Output Screenshot](/screenshots/ls-l.png)

Verify the permissions set for each department's directory:

![Output Screenshot](/screenshots/ls-ld.png)