MDT Automatic Creation Proccess. 

```powershell
#Variables for VM configuration


$VirtualMachine = "Ref - windows 10 Enterprise x64"
$VirtualMachineFile = "REF-WIN10"
$RAM = 8GB
$DISK = 40GB
$NETWORK = "Internal"
$InstallMedia = "M:\DeploymentShare\Boot\UCLANET_PE_x64.iso"
$VMSearch = $VirtualMachine
#Remove any existing VM's with name matching in $VirtualMachine
if ($VMSearch -eq $VirtualMachine) {
if ((Get-VM -Name $VirtualMachine -ErrorAction SilentlyContinue).State -eq "Running") {
Send-MailMessage -SmtpServer "nospam9.em.ucla.edu" -From "mdt@uclanet.ucla.edu" -To "rkavian@otc.ucla.edu" -Subject "Reference Image creation previous attempt failed" -Body "Something went wrong with the last reference image capture process. Please connect to CAPTURE01 on MDT Server and solve any issues."
exit
}
else{
Send-MailMessage -SmtpServer "nospam9.em.ucla.edu" -From "mdt@uclanet.ucla.edu" -To "rkavian@otc.ucla.edu" -Subject "$VirtualMachine image creation has started" -Body "$VirtualMachine image creation has started"
}
Remove-VM -Name $VirtualMachine -Force -ErrorAction SilentlyContinue
$VHDSearch = Get-ChildItem -Name $VirtualMachineFile* -Path "M:\VMs" -Recurse -ErrorAction SilentlyContinue
$VHDPath = "M:\VMs\" + $VHDSearch
Write-Host "Path >>" $VHDPath
if ($VHDPath -match ".vhdx") {
Remove-Item $VHDPath -Force
}
else {
}
}

#Create a new VM with specified configuration
New-VM -Name $VirtualMachine -Generation 1 -MemoryStartupBytes $RAM -NewVHDPath "$VirtualMachineFile.vhdx" -NewVHDSizeBytes $DISK -SwitchName $NETWORK

# Set MacAddress
Get-VM -Name $VirtualMachine | Get-VMNetworkAdapter | Set-VMNetworkAdapter -StaticMacAddress "00155DC1A001"
# Number of Processor
Set-VMProcessor $VirtualMachine -Count 12 -Reserve 100 -RelativeWeight 100

#Generation 1
Set-VMDvdDrive -VMName $VirtualMachine -Path $InstallMedia
$DVDDrive = Get-VMDvdDrive -VMName $VirtualMachine

# Generation 2 Mount DVD
# Add DVD Drive to Virtual Machine
# Add-VMScsiController -VMName $VirtualMachine
# Add-VMDvdDrive -VMName $VirtualMachine -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia
# Mount Installation Media
# $DVDDrive = Get-VMDvdDrive -VMName $VirtualMachine
# Configure Virtual Machine to Boot from DVD
# Set-VMFirmware -VMName $VirtualMachine -FirstBootDevice $DVDDrive


#Start VM
Start-VM -Name $VirtualMachine
Write-Host (Get-Date)": VM Started..."


# Wait until VM is off
Write-Host (Get-Date)": Waiting for $VirtualMachine to be Turned Off"
 
While ((Get-VM -Name $VirtualMachine).State -ne "Off")
{
	Write-Host "." -NoNewLine
	Start-Sleep -Seconds 5
}
 
Write-Host " "
Write-Host (Get-Date)": $VirtualMachine is Off"


# Rename Current Image for TaskSqueneceID
$MDTOSLocation = "M:\DeploymentShare\Operating Systems\"
$CurrentTaskSequenceID = $VirtualMachineFile + "\"
$CurrentImageFolder = $MDTOSLocation + $CurrentTaskSequenceID
$CurrentImage = $VirtualMachineFile +".wim"
$CurrentImagePath = $MDTOSLocation + $CurrentTaskSequenceID + $CurrentImage
$CurrentDate = get-date -Format yyyy_MM_dd_h_m_tt
$NewImageName = $VirtualMachineFile + "_" + $CurrentDate + ".wim"
rename-item $CurrentImagePath $NewImageName


# Get Captures File
$CaptureLocation = "M:\DeploymentShare\Captures\"
$CaptureFile = Get-ChildItem -Name $VirtualMachineFile* -Path $CaptureLocation -Recurse -ErrorAction SilentlyContinue
$CaptureFilePath = $CaptureLocation + $CaptureFile


# Rename and Move
rename-item $CaptureFilePath $CurrentImage
$CaptureFilePath = $CaptureLocation + $CurrentImage
move-item $CaptureFilePath $CurrentImageFolder 


#Email receiver@domain.com informing that the reference image creation has begun as scheduled
Send-MailMessage -SmtpServer "nospam9.em.ucla.edu" -From "mdt@uclanet.ucla.edu" -To "rkavian@otc.ucla.edu" -Subject "$VirtualMachine image creation has finished" -Body "Congrats. $VirtualMachine image creation process has successfully finished."

``` 
