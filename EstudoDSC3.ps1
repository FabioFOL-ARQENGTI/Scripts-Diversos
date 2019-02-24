Configuration FOLDSC
  {
     Node "SRVADMAO01"
     {
         WindowsFeature Security
         {
         Ensure = "Present"
         Name = "Telnet-Client"
         }
     }
  }
  Get-WindowsFeature -Name Telnet-Client
FOLDSC
Start-DscConfiguration –Path .\FOLDSC –Wait –Verbose