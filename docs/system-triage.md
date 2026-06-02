# High-Performance System Triage & Data Parsing

**The full command for the system triage and data parsing pipeline**:
```
cut -d' ' -f1 /etc/services | cut -f1 | sort -u -b | grep '^[a-zA-Z]' > ./uniqueservices.txt && wc -l uniqueservices.txt
```
*Its output:*  
![Output Screenshot](/screenshots/pipeline.png)

### Detailed breakdown of the command:

| Part of command | Explanation |
| --- | --- |
| `cut -d' ' -f1 /etc/services` | Extract only the first column using spaces as a delimiter |
| `cut -f1` | Also use the default tab delimiter to ensure all names are parsed correctly (as some services use tab instead of space) |
| `sort -u -b` | Sort the output, remove duplicates (`-u`), and strip away any leading blank lines (`-b`) |
| `grep '^[a-zA-Z]'` | Filter out any remaining administrative comments, leaving only lines that begin with a valid alphabetical character (upper or lowercase) |
| `> ./uniqueservices.txt` | Redirect the sorted dataset into `uniqueservices.txt` |
| `&& wc -l uniqueservices.txt` | Count the parsed records using a conditional command (`&&`) that only runs if the extraction pipeline executes successfully |

Verify that the file was created and contains the precise entry count:
```
# In the home directory, verify if the file was created
ls
cat uniqueservices.txt
```
![Output Screenshot](/screenshots/cat-uniqueservices.png)  
> The full file output can be viewed [here](/uniqueservices.txt)