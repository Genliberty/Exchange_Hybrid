#Script for hybrid situations to remove secondary SMTP address. Hope it will help someone.

# Output will be added to C:\temp folder. Change in where you want the log. Open the Remove-SMTP-Address.log with a text editor. For example, Notepad.
Strart-Transcript -Path "C:\temp\Remove-SMTP-Address.log" -Append

#Get all mail accounts, adjust for own situation.
$MailUsers = Get-RemoteMailbox -ResultSize Unlimited

Foreach($Mailuser in $MailUsers)
  {
  write-host $MailUser
  
  #Pickup all the mailaddresses with "example.com" and remove them. At example.com change to own SMTP address
  $smtps = Get-RemoteMailbox $MailUser.UserPrincipalName | select -ExpandProperty emailaddresses | Select-string -Pattern example.com
  Foreach($smtp in $smtps)
    {
        $RemoveSMTP = ($smtp.ToString()).split(":")[1]
        write-host "Removeing SMTP $($RemoveSMTP)"
        Set-RemoteMailbox $MailUser.UserPrincipalName -EmailAddresses @{Remove=$RemoveSMTP} #To test place -WhatIF behind this.
    }
}

Stop-Transcript
