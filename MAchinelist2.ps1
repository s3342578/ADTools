# Import the Active Directory module (if not already imported)
Import-Module ActiveDirectory

# Calculate the date 45 days ago
$lastLogonThreshold = (Get-Date).AddDays(-45)

# Get computer objects from Active Directory with last logon date within the threshold
$computers = Get-ADComputer -Filter {LastLogonDate -ge $lastLogonThreshold} -Properties Name,OperatingSystem,IPv4Address |
    Where-Object { $_.OperatingSystem -like "*Windows server*" } |
    Select-Object -Property Name,OperatingSystem,IPv4Address

# Export the data to a CSV file
$computers | Export-Csv -Path C:\Temp\RecentComputerData.csv -NoTypeInformation

# Display a confirmation message
Write-Host "Recent computer data exported to RecentComputerData.csv"