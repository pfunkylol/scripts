$minGbThreshold = 100;
$computers = "COMPUTERNAME1","ComputerName2";
$smtpAddress = "SMTP_SRV";
$toAddress = "to@whom.com";
$fromAddress = "from@whom.com";
foreach($computer in $computers)
{    
    $disks = Get-WmiObject -ComputerName $computer -Class Win32_LogicalDisk -Filter "DriveType = 3 and Deviceid !='C:'";   #Exclude C partition
    $computer = $computer.toupper();
    $deviceID = $disk.DeviceID;
    $VolumeName = $disk.VolumeName;
    foreach($disk in $disks)
    {
        $freeSpaceGB = [Math]::Round([float]$disk.FreeSpace / 1073741824, 2);
        if($freeSpaceGB -lt $minGbThreshold)
        {
            $smtp = New-Object Net.Mail.SmtpClient($smtpAddress)
            $msg = New-Object Net.Mail.MailMessage
            $msg.To.Add($toAddress)
            $msg.From = $fromAddress
            $msg.Subject = “INFO! ” + $computer + " under the 100 GB limit"
            $msg.Body = "The partition " + $disk.DeviceId + " (" + $disk.VolumeName + ") has" + $freeSpaceGB + " free GB";
            $smtp.Send($msg)
        }
    }
}