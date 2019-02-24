﻿
# create a DSC configuration to install IIS and support remote management
configuration IISConfig {

    # define input parameter
    param(
        [string[]]$computername = 'localhost'
    )

    # target machine(s) based on input param
    node $computername {

        # configure the LCM
        LocalConfigurationManager {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 15
            RefreshMode = "Push"
        }

        # install the IIS server role
        WindowsFeature IIS {
            Ensure = "Present"
            Name = "web-Server"
        }

        # install the IIS remote management service
        WindowsFeature IISManagement {
            Name = 'Web-Mgmt-Service'
            Ensure = 'Present'
            Dependson = @('[WindowsFeature]IIS')
        }

        # enable IIS remote management 
        Registry RemoteManagement {
            Key = 'HKLM:\Software\Microsoft\WebManagement\Server'
            ValueName = 'EnableRemoteManagement'
            ValueType = 'Dword'
            ValueData = '1'
            Dependson = @('[WindowsFeature]IIS','[WindowsFeature]IISManagement')
        }

        # configure remote management service
        Service WMSVC {
            Name = 'WMSVC'
            StartupType = 'Automatic'
            State = 'Running'
            Dependson = '[Registry]RemoteManagement'
        }

                # configure remote management service
        Service W3SVC {
            Name = 'W3SVC'
            StartupType = 'Automatic'
            State = 'Running'
            Dependson = '[Registry]RemoteManagement'
        }

    }

}

# create the configuration (.mof)
IISConfig -Computername SRVADMAO01 -OutputPath C:\ScriptsDscFOL

# push the configuration to SRVADMAO01
Start-DscConfiguration –Path C:\ScriptsDscFOL –Wait –Verbose