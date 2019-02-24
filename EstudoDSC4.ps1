
# configuration
Configuration IISConfig {

     # resource
     WindowsFeature IIS {

            Ensure = "Present"
            Name = "web-Server"

     }

}

# create the configuration (.mof)
IISConfig -Computername SRVADMAO01 -OutPath C:\ScriptsDscFOL

# push the configuration to SRVADMAO01 
Start-DscConfiguration –Path C:\ScriptsDscFOL –Wait –Verbose