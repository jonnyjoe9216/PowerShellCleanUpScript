# PowerShell Clean Up Script

Simple PowerShell Script to clean-up target directory.

## Description

This script is created to forcely delete files to multiple target directory and uses configuration file for email notification and other required configuration.
-Delete only specific file type based on the given configurations (e.g. : .tmp, .txt, .xls, etc.)
-Uses configuration for easy adjust settings without editing the actual script.
-Send compiled results to the support team with all the lists of the files deleted and the total file size of all logs.


## Getting Started

### Dependencies

PowerShell v5

### Installing

Edit config.conf base on your required configuration mail address, smtp, etc.
FileEXT.csv - add the lists of the files that will be deleted by the script.
FolderList.csv - add the target directory here.

### Executing program

* How to run the program
* Step-by-step bullets
```
C:\YourDirectory\CleanUpScript.ps1
```
You can also add this script via Task Scheduler.

## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
```

## Authors

Contributors names and contact info

Joe Marie Magbiro - jonnyjoe9216@gmail.com
Mobile No: +639162871420
Upwork Profile - https://www.upwork.com/freelancers/~01d8513f3eb2ff0796

## Version History

* 0.1
    * Initial Release

## License


## Acknowledgments

