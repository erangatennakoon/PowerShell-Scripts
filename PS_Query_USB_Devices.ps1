# Function to query connected USB devices
function Get-ConnectedUSBDevices {
    $USBDevices = Get-WmiObject -Query "SELECT * FROM Win32_PnPEntity WHERE PNPDeviceID LIKE 'USB\\%' AND Service != 'USBHUB' AND Service != 'USBHUB3' AND Service != 'usbhub' AND Service != 'usb'"

    # Output USB devices information
    if ($USBDevices) {
        Write-Host "Connected USB Devices:"
        foreach ($Device in $USBDevices) {
            Write-Host "---------------------------"
            Write-Host "DeviceID      : $($Device.DeviceID)"
            Write-Host "PNPDeviceID   : $($Device.PNPDeviceID)"
            Write-Host "Description   : $($Device.Description)"
            Write-Host "Manufacturer  : $($Device.Manufacturer)"
        }
    } else {
        Write-Host "No connected USB devices found."
    }
}

# Query USB devices
Get-ConnectedUSBDevices

<#
    Get-WmiObject -Query "SELECT * FROM Win32_PnPEntity WHERE PNPDeviceID LIKE 'USB\%' AND Service != 'USBHUB' AND Service != 'USBHUB3' AND Service != 'usbhub' AND Service != 'usb'"
        This query fetches all USB devices while excluding common USB hub services and other internal devices.

    Write-Host
        Outputs each device's properties.
            DeviceID: The unique identifier of the device.
            PNPDeviceID: The Plug and Play identifier for the device.
            Description: A description of the device.
            Manufacturer: The manufacturer of the device.
#>
