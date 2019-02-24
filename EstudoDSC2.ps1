Configuration FOLDSC
  {
     Node "SRVAD2012SD01"
     {
         WindowsFeature Security
         {
         Ensure = "Present"
         Name = "Telnet-Server"
         }
     }
  }
  Get-WindowsFeature -Name Telnet-Server
FOLDSC
Start-DscConfiguration –Path .\FOLDSC –Wait –Verbose