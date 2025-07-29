# Get all AD computers including servers but exclude disabled ones
$computers = Get-ADComputer -Filter {Enabled -eq $true} -Properties Name, DNSHostName, OperatingSystem, LastLogonDate

# Export to CSV
$computers | Select-Object Name, DNSHostName, OperatingSystem, LastLogonDate |
    Export-CSV "C:\Temp\AllComputers.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Computer information exported to C:\AllComputers.csv"


