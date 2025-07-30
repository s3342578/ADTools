# Define the search base (OU) where the disabled computers are located
$SearchBase = "OU="

# Export the results to a CSV file
$ExportPath = "C:\Temp\AllDisabledComputers.csv"
Get-ADComputer -filter * -SearchBase $SearchBase -Properties Name, DNSHostName, OperatingSystem, LastLogonDate | Export-Csv -Path $ExportPath -NoTypeInformation -Encoding UTF8

# Display a confirmation message
Write-Host "Exported disabled computers to $ExportPath"
