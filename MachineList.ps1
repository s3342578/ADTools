# Define the search base (Organizational Unit) where you want to search for computers
$SearchBase = ""

# Get all computers from the specified OU
$Workstations = Get-ADComputer -Filter {OperatingSystem -like "*Workstation*"} -SearchBase $SearchBase -Properties Name,OperatingSystem
$Servers = Get-ADComputer -Filter {OperatingSystem -like "*Server*"} -SearchBase $SearchBase -Properties Name,OperatingSystem

# Export the lists to CSV files
$Workstations | Select-Object Name, OperatingSystem | Export-Csv -Path "Workstations.csv" -NoTypeInformation
$Servers | Select-Object Name, OperatingSystem | Export-Csv -Path "Servers.csv" -NoTypeInformation

# Optionally, open the exported files in Excel
Start-Process -FilePath "Workstations.csv"
Start-Process -FilePath "Servers.csv"
