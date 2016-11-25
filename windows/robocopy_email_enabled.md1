
```ps1

###########################################################
$SmtpServer =    "localhost"
$EmailFrom  =    "From Address <from@address.com>"
$EmailTo    =    "to@address.com"

###########################################################

$Logfile = "log.txt"
$hostname = hostname
$Subject = "[ROBOCOPY] $hostname"
$Body = "Robocopy completed successfully. See attached log file for details"

# Backup 
Robocopy E:\SOURCE Z:\DESTINATION /MT:32 /MIR /FFT /Z /XA:H /W:5 /LOG:$Logfile /NP


$Message = New-Object Net.Mail.MailMessage($EmailFrom, $EmailTo, $Subject, $Body)
$Attachment = New-Object Net.Mail.Attachment($Logfile, 'text/plain')
$Message.Attachments.Add($Attachment)

$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 25)
$SMTPClient.Send($Message)
```

