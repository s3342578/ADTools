# Specify the username and new password
$Username = ""
$NewPassword = ""

# Disable password complexity requirements
#secedit /export /cfg C:\secpol.cfg
#(Get-Content C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
#secedit /configure /db C:\Windows\Security\local.sdb /cfg C:\secpol.cfg /areas SECURITYPOLICY

# Reset the user's password
Set-ADAccountPassword -Identity $Username -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $NewPassword -Force)

# Clean up the temporary security policy file
#Remove-Item -Path C:\secpol.cfg -Force
