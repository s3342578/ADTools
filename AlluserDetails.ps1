Import-Module ActiveDirectory
Import-Module GroupPolicy

$allUsers = Get-ADUser -Filter * -Properties *
$results = New-Object System.Collections.Generic.List[object]

foreach ($user in $allUsers) {
    try {
        $groupMembership = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName | Select-Object -ExpandProperty name
    } catch {
        Write-Warning "Failed to get group membership for $($user.SamAccountName): $_"
        $groupMembership = @() # Ensure this is an empty array to avoid null reference issues
    }

    $userObj = New-Object PSObject -Property @{
        Name              = $user.Name
        Username          = $user.SamAccountName
        Enabled           = $user.Enabled
        LockedStatus      = $user.LockedOut
        GroupMembership   = ($groupMembership -join ', ')
        AccountCreateDate = $user.whenCreated
        AccountExpiryDate = $user.AccountExpirationDate
        LastLoginDate     = if ($user.lastLogonTimestamp) { [datetime]::FromFileTime($user.lastLogonTimestamp) } else { $null }
    }

    $results.Add($userObj)
}

$exportPath = "C:\temp"
$results | Export-Csv -Path "$exportPath\AllUsersInfo.csv" -NoTypeInformation
Write-Host "All users info exported to $exportPath\AllUsersInfo.csv"
