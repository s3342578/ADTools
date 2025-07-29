# Ensure the Active Directory module is loaded
Import-Module ActiveDirectory

# Define the output file path
$outputFilePath = "C:\Temp\ADUsersAndGroups.csv"

# Get all AD users
$users = Get-ADUser -Filter * -Property DisplayName

# Create a list to hold the output
$output = @()

foreach ($user in $users) {
    # Get the groups for the current user
    $groups = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName | Select-Object -ExpandProperty Name
    
    # For each group, add an entry to the output list
    foreach ($group in $groups) {
        $output += New-Object PSObject -Property @{
            UserName = $user.DisplayName
            UserSamAccountName = $user.SamAccountName
            GroupName = $group
        }
    }
}

# Export the output list to a CSV file
$output | Export-Csv -Path $outputFilePath -NoTypeInformation

Write-Host "Export complete. The file is located at $outputFilePath"
