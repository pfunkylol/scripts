Get-ChildItem -Path "C:\Temp" -Recurse | Where-Object {$_.Length -gt 10MB} | `
  Select Name, @{n=' ';e={
       "{0:N0} MB" -f  ((Get-ChildItem "localhost" -Recurse | Measure-Object -Sum Length).Sum / 1MB)}}
       | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-730)}