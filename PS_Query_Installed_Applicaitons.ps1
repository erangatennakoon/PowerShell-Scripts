# Define the registry paths to query for installed applications
$registryPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

# Create an empty array to store the results
$installedApps = @()

# Loop through each registry path and query for installed applications
foreach ($path in $registryPaths) {
    $apps = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue | ForEach-Object {
        New-Object PSObject -Property @{
            Name = $_.DisplayName
            Version = $_.DisplayVersion
            Publisher = $_.Publisher
            InstallDate = $_.InstallDate

            # Uncomment the following properties as you need
            # For more details about the registry keys and their values refer to the following links
            # https://learn.microsoft.com/en-us/windows/win32/sysinfo/registry-key-security-and-access-rights
            # https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc785971(v=ws.10)?redirectedfrom=MSDN

            #EstimatedSize = $_.EstimatedSize
            #InstallLocation = $_.InstallLocation
            #UninstallString = $_.UninstallString
            #HelpLink = $_.HelpLink
            #InstallSource = $_.InstallSource
            #ModifyPath = $_.ModifyPath
            #Readme = $_.Readme
            #URLInfoAbout = $_.URLInfoAbout
            #Comments = $_.Comments
            #Contact = $_.Contact
            #AuthorizedCDFPrefix = $_.AuthorizedCDFPrefix
            #DisplayIcon = $_.DisplayIcon
            #Language = $_.Language
            #NoModify = $_.NoModify
            #NoRepair = $_.NoRepair
            #VersionMajor = $_.VersionMajor
            #VersionMinor = $_.VersionMinor
        }
    }

    # Add the applications to the results array
    $installedApps += $apps
}

# Filter out any entries with empty names
$installedApps = $installedApps | Where-Object { $_.Name -ne $null }

# Output the results
$installedApps | Format-Table -AutoSize
