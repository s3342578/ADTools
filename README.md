# Active Directory Enumeration Scripts

This repository contains a suite of PowerShell scripts designed for administrators to audit and extract critical data from Active Directory (AD) environments. These scripts help with compliance, reporting, and security review tasks.

---

## Scripts Overview

| Script Name                | Description |
|----------------------------|-------------|
| `allEnabledComputers.ps1`  | Lists all **enabled** computer accounts in the domain. |
| `AlluserDetails.ps1`       | Retrieves full details for all domain users (e.g., name, description, department, etc.). |
| `AllUsersGroups.ps1`       | Lists each user with their **group memberships**. |
| `DisabledOu.ps1`           | Identifies OUs containing **disabled accounts**. |
| `GroupSearchEXTUsers.ps1`  | Searches for users with **external email addresses** (useful for guest/federated accounts). |
| `MachineList.ps1`          | Returns a list of **machine accounts**, helpful for tracking devices. |
| `MAchinelist2.ps1`         | Variant of `MachineList.ps1`, may include additional data or format differences. |
| `password reset.ps1`       | Resets passwords for specified users (requires elevated privileges). |

---

## Requirements

- PowerShell 5.1 or newer
- Active Directory PowerShell module (`RSAT` or domain-joined session)
- Read or administrative permissions in AD (depending on the script)

---

##  Usage

Each script is standalone and can be executed directly:


