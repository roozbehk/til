
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
cd $dir	



function Invoke-Sqlcmd2 
{ 
    [CmdletBinding()] 
    param( 
    [Parameter(Position=0, Mandatory=$true)] [string]$ServerInstance, 
    [Parameter(Position=1, Mandatory=$false)] [string]$Database, 
    [Parameter(Position=2, Mandatory=$false)] [string]$Query, 
    [Parameter(Position=3, Mandatory=$false)] [string]$Username, 
    [Parameter(Position=4, Mandatory=$false)] [string]$Password, 
    [Parameter(Position=5, Mandatory=$false)] [Int32]$QueryTimeout=600, 
    [Parameter(Position=6, Mandatory=$false)] [Int32]$ConnectionTimeout=15, 
    [Parameter(Position=7, Mandatory=$false)] [ValidateScript({test-path $_})] [string]$InputFile, 
    [Parameter(Position=8, Mandatory=$false)] [ValidateSet("DataSet", "DataTable", "DataRow")] [string]$As="DataRow" 
    ) 
 
    if ($InputFile) 
    { 
        $filePath = $(resolve-path $InputFile).path 
        $Query =  [System.IO.File]::ReadAllText("$filePath") 
    } 
 
    $conn=new-object System.Data.SqlClient.SQLConnection 
      
    if ($Username) 
    { $ConnectionString = "Server={0};Database={1};User ID={2};Password={3};Trusted_Connection=False;Connect Timeout={4}" -f $ServerInstance,$Database,$Username,$Password,$ConnectionTimeout } 
    else 
    { $ConnectionString = "Server={0};Database={1};Integrated Security=True;Connect Timeout={2}" -f $ServerInstance,$Database,$ConnectionTimeout } 
 
    $conn.ConnectionString=$ConnectionString 
     
    #Following EventHandler is used for PRINT and RAISERROR T-SQL statements. Executed when -Verbose parameter specified by caller 
    if ($PSBoundParameters.Verbose) 
    { 
        $conn.FireInfoMessageEventOnUserErrors=$true 
        $handler = [System.Data.SqlClient.SqlInfoMessageEventHandler] {Write-Verbose "$($_)"} 
        $conn.add_InfoMessage($handler) 
    } 
     
    $conn.Open() 
    $cmd=new-object system.Data.SqlClient.SqlCommand($Query,$conn) 
    $cmd.CommandTimeout=$QueryTimeout 
    $ds=New-Object system.Data.DataSet 
    $da=New-Object system.Data.SqlClient.SqlDataAdapter($cmd) 
    [void]$da.fill($ds) 
    $conn.Close() 
    switch ($As) 
    { 
        'DataSet'   { Write-Output ($ds) } 
        'DataTable' { Write-Output ($ds.Tables) } 
        'DataRow'   { Write-Output ($ds.Tables[0]) } 
    } 
 
} #Invoke-Sqlcmd2


# $query = Invoke-Sqlcmd2 -ServerInstance "SERVERNAME" -Query "SELECT TOP 100 [AgentID],[HardwareClass],[HardwareName],[Quantity] FROM [PLUS].[dbo].[rpt_AgentHardware] where AgentID = '9f3bc8a5-cc48-49f8-a8cf-408329478332'"
#$AgentHardwares = @()
#$AgentHardwares = Invoke-Sqlcmd2 -ServerInstance "SERVERNAME" -Query "SELECT [AgentID],[HardwareClass],[HardwareName],[Quantity] FROM [PLUS].[dbo].[rpt_AgentHardware]"

$AgentOSAttributes = [ordered] @{}
$AgentOSAttributes = Invoke-Sqlcmd2 -ServerInstance "SERVERNAME" -Query `
"SELECT EndpointDetail.[EPID]
      ,EndpointDetail.[AgentID]
      ,[AgentGUID]
      ,[AgentName]
      ,EndpointDetail.[InstallDate]
      ,[Status]
      ,SerialNumber.[HardwareName] as SerialNumber
	  ,MachineModel.[HardwareName] as MachineModel
      ,Processors.[HardwareName] as Processors
	  ,RAM.[HardwareName] as Ram
	  ,BIOS.[HardwareName] as BIOS
	  ,Architecture.[HardwareName] as Architecture
	  ,EndpointDetail.[OperatingSystem_ID]
	  ,[OperatingSystem_Name]
      ,[OSVer]
      ,[OSBuildNo]
      ,[ServicePack]
      ,[AgentVersion]
      ,[IPAddress]
      ,[MACAddress]
      ,[SubnetMask]
      ,[CIDRNotation]
      ,[DNSSuffix]
      ,[LastContactDate]
      ,[IsEndPointService]
      ,[IsInitialized]
  FROM [UPCCommon].[dbo].[EndpointDetail] EndpointDetail
    INNER JOIN  [PLUS].[dbo].[OperatingSystems] OperatingSystems ON (EndpointDetail.OperatingSystem_ID = OperatingSystems.OperatingSystem_ID)
    INNER JOIN [UPCCommon].[dbo].[EndpointNetworkAddress] EndpointNetworkAddress ON (EndpointDetail.EPID = EndpointNetworkAddress.EPID )
	LEFT JOIN [PLUS].[dbo].[rpt_AgentHardware] SerialNumber ON (EndpointDetail.AgentGUID = SerialNumber.AgentID AND SerialNumber.HardwareClass = 'Serial Number'  )
	LEFT JOIN [PLUS].[dbo].[rpt_AgentHardware] MachineModel ON (EndpointDetail.AgentGUID = MachineModel.AgentID AND MachineModel.HardwareClass = 'Machine Model'  )
	LEFT JOIN [PLUS].[dbo].[rpt_AgentHardware] BIOS ON (EndpointDetail.AgentGUID = BIOS.AgentID AND BIOS.HardwareClass = 'BIOS'  )
	LEFT JOIN [PLUS].[dbo].[rpt_AgentHardware] RAM ON (EndpointDetail.AgentGUID = RAM.AgentID AND RAM.HardwareClass = 'RAM'  )
	LEFT JOIN [PLUS].[dbo].[rpt_AgentHardware] Architecture ON (EndpointDetail.AgentGUID = Architecture.AgentID AND Architecture.HardwareClass = 'Architecture'  )
	LEFT JOIN [PLUS].[dbo].[rpt_AgentHardware] Processors ON (EndpointDetail.AgentGUID = Processors.AgentID AND Processors.HardwareClass = 'Processors'  )"




$AgentDiskDrives = [ordered]@{}
$AgentDiskDrives = Invoke-Sqlcmd2 -ServerInstance "SERVERNAME" -Query "SELECT [AgentID],[HardwareClass],[HardwareName],[Quantity] FROM [PLUS].[dbo].[rpt_AgentHardware] WHERE HardwareClass = 'Disk drives'"

$AgentMonitors = [ordered]@{}
$AgentMonitors = Invoke-Sqlcmd2 -ServerInstance "SERVERNAME" -Query "SELECT [AgentID],[HardwareClass],[HardwareName],[Quantity] FROM [PLUS].[dbo].[rpt_AgentHardware] WHERE HardwareClass = 'Monitors'"

$AgentDisplayAdapters = [ordered]@{}
$AgentDisplayAdapters = Invoke-Sqlcmd2 -ServerInstance "SERVERNAME" -Query "SELECT [AgentID],[HardwareClass],[HardwareName],[Quantity] FROM [PLUS].[dbo].[rpt_AgentHardware] WHERE HardwareClass = 'Display adapters'"

$AgentPrinters = [ordered]@{}
$AgentPrinters = Invoke-Sqlcmd2 -ServerInstance "SERVERNAME" -Query "SELECT [AgentID],[HardwareClass],[HardwareName],[Quantity] FROM [PLUS].[dbo].[rpt_AgentHardware] WHERE HardwareClass = 'Printers'"

$AgentDiskDrives = $AgentDiskDrives | Group-Object AgentID | foreach-object {

    [PsCustomObject]@{
        AgentGUID = $_.Name
        HardwareClass =  'DiskDrives'
        HardwareName = %{ $_.Group.HardwareName } | out-string  
    }

} 

$AgentMonitors = $AgentMonitors | Group-Object AgentID | foreach-object {

    [PsCustomObject]@{
        AgentGUID = $_.Name
        HardwareClass =  'Monitors'
        HardwareName = %{ $_.Group.HardwareName } | out-string  
    }

} 

$AgentDisplayAdapters = $AgentDisplayAdapters | Group-Object AgentID | foreach-object {

    [PsCustomObject]@{
        AgentGUID = $_.Name
        HardwareClass =  'DisplayAdaptors'
        HardwareName = %{ $_.Group.HardwareName } | out-string  
    }

} 

$AgentPrinters = $AgentPrinters | Group-Object AgentID | foreach-object {

    [PsCustomObject]@{
        AgentGUID = $_.Name
        HardwareClass =  'Printers'
        HardwareName = %{ $_.Group.HardwareName } | out-string  
    }

} 


$AgentOSAttributes | Add-Member -MemberType NoteProperty -Name "DiskDrives" -Value $null
$AgentOSAttributes | Add-Member -MemberType NoteProperty -Name "Monitors" -Value $null
$AgentOSAttributes | Add-Member -MemberType NoteProperty -Name "DisplayAdaptors" -Value $null
$AgentOSAttributes | Add-Member -MemberType NoteProperty -Name "Printers" -Value $null


$AgentOSAttributes | foreach-object {

    $AgentGUID = $_.AgentGUID
    $_.OSVer = $_.OSVer -replace ',','.'
    $_.AgentVersion = $_.AgentVersion -replace ',','.'
       
    $_.DiskDrives = $AgentDiskDrives | Where-Object { $_.AgentGUID -eq $AgentGUID } | Select -ExpandProperty HardwareName 
    $_.Monitors = $AgentMonitors | Where-Object { $_.AgentGUID -eq $AgentGUID } | Select -ExpandProperty HardwareName 
    $_.DisplayAdaptors = $AgentDisplayAdapters | Where-Object { $_.AgentGUID -eq $AgentGUID } | Select -ExpandProperty HardwareName 
    $_.Printers = $AgentPrinters | Where-Object { $_.AgentGUID -eq $AgentGUID } | Select -ExpandProperty HardwareName 

    #$_.AgentName
    #$_.DiskDrives
    #$_.Monitors 
    #$_.DisplayAdaptors
    #$_.Printers
} 



 $AgentOSAttributes | export-csv  -NoTypeInformation _ivanti_hardware.csv


