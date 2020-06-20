
#Creates a date stamp in a specific format
$currentDateStamp = (Get-Date -UFormat %Y).ToString() + (Get-Date -UFormat %m).ToString() + (Get-Date -UFormat %d).ToString() + "_" +(Get-Date -UFormat %M).ToString() + (Get-Date -UFormat %S).ToString() 


$DBBackupDir = "E:\DENTRIX_DBBackup\"
$sevenZip = "C:\Program Files\7-Zip\7z.exe"
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition #Grabs the path that the script was run from
$scriptPath += ""

#DB Path Variables
$DBDir = "E:\DENTRIX\Common\DBCopyForBackup\"
$outputDBBackupDir = $DBBackupDir 


#Backup and Zip DB files
$filesToZip = Get-ChildItem $DBDir -Attributes D 

#Loops through each folder to be zipped
foreach($f in $filesToZip) {

$zipArgs = "a", "-tzip",($outputDBBackupDir + $f.Name + "" + $f.Name + "_" + $currentDateStamp + ".zip"),($DBDir + $f.Name + "*") 

& $sevenZip $zipArgs 

#Delete Backups older than 90 days
forfiles -p $DBBackupDir -s -m *.zip /D -90 /C "cmd /c del @path"

}
