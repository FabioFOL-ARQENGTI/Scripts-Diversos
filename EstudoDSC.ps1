Enable-PSRemoting -force
Enter-PSSession .
Enter-PSSession -ComputerName SRVAD2012SD01 -Credential $cred

Get-DscLocalConfigurationManager -CimSession SRVADMAO01
Get-DscLocalConfigurationManager

Get-Command -Noun DSC*

Get-DscResource | ft 
Get-DscResource -Name WindowsFeature | Select-Object -ExpandProperty Properties

Get-service | Select-Object Name,Status
Get-service | Select-Object Name,Status | Where-Object {$_.name -eq "Dhcp" -and $_.status -eq "Running"}
Get-service | Select-Object Name,Status | Where-Object {$_.name -eq "Dhcp" -and $_.status -eq "Running"} | % { $_.name }

Stop-Service "Dhcp" -Force 
Start-Service "Dhcp" 