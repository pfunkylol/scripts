 GC C:\Temp\IP.txt | %{
	If (Test-Connection $_ -Quiet -Count 1)
{
	" $_ is UP" 
	}

	Else
{
	"$_ is Down"  
	}
} | Out-File C:\Temp\resultIP.txt