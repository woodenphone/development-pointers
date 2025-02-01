# Procedure to setup ansible target


## On controller
Create certificate for ansible-controller to connect with: (On ansible-controller)
```bash
cd /home/someuser/host-repos/some-host/windows-init/winrm-cert


mv -v cert_key.pem cert.pem /home/someuser/host-repos/some-host/windows10/files/certs/
```


## On target 

Create user account for remote management: (Admin PS)
```powershell
New-LocalUser -Name "Ansible" -Password $( "example-firstsetup-passphrase" | ConvertTo-SecureString ) -PasswordNeverExpires -Description "Automated managemnt admin"
```

Enable WinRM remote access: (Admin PS)
```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file -DisableBasicAuth
```


Install ansible-controller cert: (Admin PS)
```powershell
$pubKeyFilePath = 'D:\cert.pem'

## Import the public key into Trusted Root Certification Authorities and Trusted People
$null = Import-Certificate -FilePath $pubKeyFilePath -CertStoreLocation 'Cert:\LocalMachine\Root'
$null = Import-Certificate -FilePath $pubKeyFilePath -CertStoreLocation 'Cert:\LocalMachine\TrustedPeople'
```


Map certificate to account: (On Windows ansible-target) (Admin PS)
```powershell
$username = "Ansible"
$password = ConvertTo-SecureString -String "giggly-viral-trapping-devotion" -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password

# This is the issuer thumbprint which in the case of a self generated cert
# is the public key thumbprint, additional logic may be required for other
# scenarios
$thumbprint = (Get-ChildItem -Path cert:\LocalMachine\root | Where-Object { $_.Subject -eq "CN=$username" }).Thumbprint

New-Item -Path WSMan:\localhost\ClientCertificate `
    -Subject "$username@localhost" `
    -URI * `
    -Issuer $thumbprint `
    -Credential $credential `
    -Force
```

Grant account admin priveleges: (Admin PS)
```powershell
Add-LocalGroupMember -Group "Administrators" -Member "Ansible"
```

Grant user admin privs:
```powershell
## Add the local user to the administrators group. If this step isn't doing, Ansible sees an "AccessDenied" error
Get-LocalUser -Name "Ansible" | Add-LocalGroupMember -Group 'Administrators'
```
