# Import the Active Directory module
Import-Module ActiveDirectory

# Define the groups to search, including the new group
$groups = @("VPN Users", "G S PPTP VPN Access", "Citrix_AAC VPN Access", "G S Covid19 VPN Users", "G S SSLVPN Users", "G S VPN Users")

# Define the OU to check for
$ouFilter = "OU=External Contractors,DC=begacheese,DC=com,DC=au"

# Initialize an empty array to store results
$results = @()

# Loop through each group
foreach ($group in $groups) {
    try {
        # Get the group object
        $groupObject = Get-ADGroup -Identity $group -ErrorAction Stop
        
        # Get the members of the group
        $members = Get-ADGroupMember -Identity $groupObject -Recursive | Where-Object { $_.objectClass -eq 'user' }

        # Loop through each member
        foreach ($member in $members) {
            try {
                # Get user details
                $user = Get-ADUser -Identity $member -Property SamAccountName, DistinguishedName -ErrorAction Stop

                # Check if user is in the specified OU
                if ($user.DistinguishedName -like "*$ouFilter*") {
                    # Add user to results
                    $results += $user | Select SamAccountName, Name, @{Name="GroupName";Expression={$group}}
                }
            } catch {
                Write-Output "Error retrieving user details for $($member.SamAccountName). Error: $_"
            }
        }
        
    } catch {
        Write-Output "Error retrieving data for group: $group. Error: $_"
    }
}

# Display the results
$results | Format-Table -AutoSize


# Optionally, you can export the results to a CSV file
$results | Export-Csv -Path "C:\Users\admnicholas\Desktop\exported_usersEXTGroups.csv" -NoTypeInformation
