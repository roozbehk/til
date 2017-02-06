

```powershell
#Variables for VM configuration
$VirtualMachine = "CAPTURE01"
$RAM = 8GB
$DISK = 40GB
$NETWORK = "Internal"
$ISO = "M:\DeploymentShare\Boot\UCLANET_PE_x64.iso"
$VMSearch = $VirtualMachine
#Remove any existing VM's with name matching in $VirtualMachine
if ($VMSearch -eq $VirtualMachine) {
if ((Get-VM -Name $VirtualMachine -ErrorAction SilentlyContinue).State -eq "Running") {
Send-MailMessage -SmtpServer "nospam9.em.ucla.edu" -From "mdt@uclanet.ucla.edu" -To "rkavian@otc.ucla.edu" -Subject "Reference Image creation previous attempt failed" -Body "Something went wrong with the last reference image capture process. Please connect to CAPTURE01 on MDT Server and solve any issues."
exit
}
Remove-VM -Name $VirtualMachine -Force -ErrorAction SilentlyContinue
$VHDSearch = Get-ChildItem -Name $VirtualMachine* -Path "M:\VMs" -Recurse -ErrorAction SilentlyContinue
$VHDPath = "M:\VMs\" + $VHDSearch
Write-Host "Path >>" $VHDPath
if ($VHDPath -match ".VHDX") {
Remove-Item $VHDPath -Force
}
else {
}
}

#Create a new VM with specified configuration
New-VM -Name $VirtualMachine -ComputerName $HostName -MemoryStartupBytes $RAM -NewVHDPath "CAPTURE01.VHDX" -NewVHDSizeBytes $DISK -SwitchName $NETWORK

# Set MacAddress
Get-VM -Name $VirtualMachine | Get-VMNetworkAdapter | Set-VMNetworkAdapter -StaticMacAddress "00155DC1A001"
# Number of Processor
Set-VMProcessor $VirtualMachine -Count 12 -Reserve 100 -Maximum 75 -RelativeWeight 100
#Load boot ISO
Set-VMDvdDrive -VMName $VirtualMachine -Path $ISO
#Start VM
Start-VM -Name $VirtualMachine


# Wait until VM is off
Write-Host (Get-Date)": Waiting for $VirtualMachine to be Turned Off"
 
While ((Get-VM -Name $VirtualMachine).State -ne "Off")
{
	Write-Host "." -NoNewLine
	Start-Sleep -Seconds 5
}
 
Write-Host " "
Write-Host (Get-Date)": $VirtualMachine is Off"


#Email receiver@domain.com informing that the reference image creation has begun as scheduled
Send-MailMessage -SmtpServer "nospam9.em.ucla.edu" -From "mdt@uclanet.ucla.edu" -To "rkavian@otc.ucla.edu" -Subject "Reference Image creation has finished" -Body "Congrats $SRV reference image creation process has successfully finished."
```
