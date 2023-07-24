# Scripts for temporarily granting administrative privileges in an OS Windows 10/11 domain environment


## Usage

Scripts for temporarily granting administrative privileges in a Windows 10/11 environment in a domain.

### Scope:

Temporary granting of administrative privileges is only relevant when it is not possible to configure exceptions using Group Policies.

For example, to import the `IKEv2 VPN Profile` into the system.
This problem is not solved by simply running the batch file as an administrator. Because in this case the profile is imported directly into the domain/local administrator account.

Moreover, if you grant temporary permissions to run it, the profile may not be imported correctly.

Therefore, to solve this problem it is necessary to add the current user who needs to import the VPN profile to the local `Administrators` group