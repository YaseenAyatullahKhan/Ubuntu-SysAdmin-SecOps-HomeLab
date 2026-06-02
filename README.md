# Multi-Tenant System Orchestration and Automation with SecOps Baseline
A multi-tenancy focused Linux configuration and system administration home lab proect. This project documents a complete hands-on deployment transitioning a raw virtual machine into a secure, multi-tenant corporate environment, implementing custom automation scripts, establishing log-preservation backups, and running high-performance text-parsing pipelines in memory.

This lab was successfully configured, tested, and validated on a 64-bit virtual machine running Ubuntu Server 22.04 LTS (minimal kernel pre-built by OSBoxes) hosted on a VMware Workstation hypervisor.

## 📁 Repository Directory Structure
```
Repository
├── README.md                      # Project presentation and baseline overview
├── uniqueservices.txt             # Final output artifact generated in Part 4
├── scripts/
│   └── user_management.sh         # Interactive user provisioning Bash script
└── docs/
├── multi-tenant-design.md     # Part 1 technical deep-dive and logs
├── backup-procedures.md       # Part 3 backup methodologies and commands
└── system-triage.md           # Part 4 parsing pipelines and command breakdown
```
---
### 🛡️ Part 1: Multi-Tenant Access Isolation
It is an essential System Administration skill to be able to configure users, groups with respective admin users and home direcotries, while ensuring the correct level of system hardening is applied. In this part I took three example corporate departments and used various, appropriate user/group policy management techniques to create an isolated (inter-department) yet collaborative (intra-department) 'multi-tenant' system.

Via the `su` (super-user) mode, I utilised the following commands:  
| Command | Explanation |
| --- | --- |
| `addgroup [group-name]` | Creates a group  |
| `useradd -m -s /bin/bash -g [group-name] [group]-admin` | Creates an admin user with their home directory named on them and enforces usage of the secure bash shell |
| `useradd -m -s /bin/bash -g [group-name] [group]-user` | Creates a staff user with their home directory named on them and enforces usage of the secure bash shell |
| `chown [group]-admin:[group-name] [group-name]` | Applies directory ownership for the respective department, owned by the administrative user |
| `chmod 1770 [group-name]` | Modifying directory permissions where 1 applies a sticky bit (only file-owner/directory-owner/root-user can delete or rename files), 7 for full permission for user owner and group owner, and 0 for no permissions for any other user |
|`echo "This file contains confidential information for the department." > [group-name]/confidential.txt` | A .txt document for each department's internal, confidential use |
| `chmod 740 [group-name]/confidential.txt` | Hardening permissions for this document (4 allows read-only access to the group) |
---

#### 📸 Verification Artifacts (Part 1)
![Output Screenshot](/screenshots/.png)

---
### 🤖 Part 2: Interactive User Provisioning Script
Manually configuring users, validating inputs, and applying directory security rules one command at a time is inefficient and prone to syntax errors.

To automate this workflow, I developed user_management.sh. This interactive script prompts the operator for a username and group, utilizes getent recursive loops to validate against duplicates, prompts for a secure password, configures home directory allocations at root `/`, and enforces strict 1770 folder security boundaries.

#### 📸 Verification Artifacts (Part 2)
![Output Screenshot](/screenshots/.png)

---
### 📂 Part 3: Incident Response Archive and Backups
During security incidents or active server investigations, preserving system telemetry and log configurations is a high-priority task. Attackers frequently attempt to clear local logs to destroy evidence.

This phase details a backup policy that targets all `.log` files in `/var/log`, archives them without carrying parent directory path structures (which simplifies file management), and verifies the archive before safely extracting the payload inside a local secure analysis environment.

#### 📸 Verification Artifacts (Part 3)
![Output Screenshot](/screenshots/.png)

---
### 🔎 Part 4: High-Performance System Triage & Data Parsing
In a forensic event or for a system audit, we may need to quickly extract unique, valid system service names mapped on the operating system without creating temporary intermediate files or writing messy data back to disk.

This high-performance pipeline processes `/etc/services`, strips out comments, ignores blank spaces, eliminates duplicates, and sorts alphabetically. It saves the filtered records to uniqueservices.txt and conditionally counts the resulting lines using the `&&` operator to confirm success.

#### 📸 Verification Artifacts (Part 4)
![Output Screenshot](/screenshots/.png)

---
### 💡 Key Takeaways
- **Least-Privilege Isolation (Part 1)**: Verified strict boundary protections, securing multi-tenant operations with special permission bits.
- **Infrastructure Automation (Part 2)**: Eliminated manual friction by implementing a programmatic input validator and user provisioning shell script.
- **Evidence Preservation (Part 3)**: Practiced rapid incident backups, utilizing `tar` to package security logs.
- **Log Analysis & Regex Parsing (Part 4)**: Conducted threat intelligence data mining using in-memory text streams.