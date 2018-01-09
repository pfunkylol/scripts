$smtpServer = ""
$smtpFrom = ""
$smtpTo = ""
$messageSubject = ""
 
[string]$messagebody = ""
 
$logs = Get-Content C:\Temp\contentoffile.txt
 
foreach ($log in $logs )
{
	$messagebody = $messagebody + $log + "`r`n"
}
 
$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($smtpFrom,$smtpTo,$messagesubject,$messagebody)