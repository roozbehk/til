# Powershell Script to check your ESXi Host Harddrives Status

This script can be scheduled to run as a windows task. It will check the smart status of your esxi harddrives, if it report anything other than OK, it will send you an email. it will also keep a log everytime that it checks your drives. 

## Requierments
ESXi Shell enabled

* [plink.exe](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) Plink is (a command-line interface to the PuTTY back ends)

* SMTP Server if you want email.


## Find Harddrive Device ID

Open a console or SSH session to the ESXi host. 

Determine the device parameter to use by running the command:

 `esxcli storage core device list`

Read the data from the device:

`esxcli storage core device smart get -d device`

Where device is a value found in step 1.

The expected output is a list with all SCSI devices seen by the ESXi host. For example:

`t10.ATA_____WDC_WD2502ABYS2D18B7A0________________________WD2DWCAT1H751520`

Note: External FC/iSCSI LUNs or virtual disks from a RAID controller might not report a S.M.A.R.T. status.

[Reference](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2040405)


Once you have your Device ID, replace it in `cmd_check_hd` file.

Change your ESXi IP and Password in `check_hd_health.ps1`
```bash
./plink.exe -ssh root@192.168.1.20 -pw PASSWORD -m cmd_check_hd 
```

`cmd_check_hd`

```
esxcli storage core device smart get -d t10.ATA_____WDC_WD10EFRX2D68FYTN0_________________________WD2DWCC4J4DNXYF0 | grep 'Health Status' | awk  '{print $3}'
esxcli storage core device smart get -d t10.ATA_____WDC_WD10EFRX2D68FYTN0_________________________WD2DWCC4J4DNX219 | grep 'Health Status' | awk  '{print $3}'
```

`cmd_check_server_model`
```
smbiosDump | egrep '(Product|Serial)'
```

## Script

```powershell
###########################################################
# Edit this part:
$SmtpServer =    "localhost"
$EmailFrom  =    " Monitor <your@emailaddress.com>"
$EmailTo    =    "your@email.com"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 25) 
###########################################################

# Set the relative path to where the command is run.
$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path


# check against this string, if it doesnt report OK send email and log.

$Matchstring = "OK"

# SSH and run cmd_check_hd 
$Result = ./plink.exe -ssh root@192.168.1.20 -pw PASSWORD -m cmd_check_hd 


$Date = $((Get-Date).ToString())

if ( $Result | Select-String -Pattern $Matchstring ){
    "Hard Drive OK $DATE" | Add-Content hd_full_report.txt 
    }
else 
    {
      # Email The info
	  $Subject = '[COMPANYNAME] HD Smart Status FAILED'
	  $messagebody = ""
      $messagebody = "Hard Drive FAILING $DATE `r`n"
      $server_model = ./plink.exe -ssh root@192.168.1.20 -pw PASSWORD -m cmd_check_server_model
      $messagebody = $messagebody + $server_model + "`r"
      $messagebody | Add-Content hd_full_report.txt
      $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $messagebody)     
}

```

## Setup Windows Task Scheduler

for Action, Select Start a program

Program/script: `Powershell.exe`
Add arguments: `-ExecutionPolicy Bypass "C:\script\hd_smart_status_report\check_hd_health.ps1" -RunType $true -Path "C:\script\hd_smart_status_report"`

## License

open-sourced software licensed under the MIT license
