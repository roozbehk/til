Use this script to query SQL Table return values in form of a report in email.

```powershell

#Setting Date 
$today = (Get-Date).ToString()
$LogDate = get-date -f yyyyMMddhhmm


$emailHeader = @"

<style>
BODY{background-color:none ;}
TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:thistle}
TD{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:PaleGoldenrod}
</style>

"@


$SQLServer = localhost
$emailSmtpServer = "smtp.gmail.com"
$emailSmtpServerPort = "587"
$emailSmtpUser = "username@gmail.com"
$emailSmtpPass = "password"
$attachment = "C:\Log\attachment.csv"
# Remove Old Attachment
if(Test-Path -Path $attachment) { Remove-Item $attachment }

$emailMessage = New-Object System.Net.Mail.MailMessage
$emailMessage.From = "Report <server@myserverc.om>"
$emailMessage.To.Add( "to@gmail.com" )
$emailMessage.CC.Add( "cc@gmail.com" )
$emailMessage.Subject = "Subject $today"
$emailMessage.IsBodyHtml = $true


$SMTPClient = New-Object System.Net.Mail.SmtpClient( $emailSmtpServer , $emailSmtpServerPort )
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential( $emailSmtpUser , $emailSmtpPass );
 


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


$query = Invoke-Sqlcmd2 -ServerInstance $SQLServer -Query "SELECT * FROM [DATABASE].[dbo].[TABLE] ORDER BY Id DESC" 
$emailMessage.Body  = $query | Select-Object Column1,Column2 | sort Column2 -Descending  | ConvertTo-html -Head $emailHeader -Body  "<H2>Table Report</H2>"
$emailMessage.Body += "<br><b>--Server Bot</b>"

$query | export-csv  -NoTypeInformation $attachment 

$emailMessage.Attachments.Add( $attachment )
$SMTPClient.Send( $emailMessage )



```
