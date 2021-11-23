# Powershell remoting

########################################
#region -- Install/Configure Powershell on RH9

ssh rh9wroot

# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo yum install -y powershell

# Start PowerShell
pwsh


# In powershell
dir /etc/ssh
Select-String -Path /etc/ssh/sshd_config -Pattern "Subsystem`t" | Select-Object -ExpandProperty Matches

# add Powershell Subsystem
$Text1 = "Subsystem      sftp    /usr/libexec/openssh/sftp-server"
$Text2 = $Text1 + "`n" + "Subsystem      powershell      /usr/bin/pwsh -sshs -NoLogo -NoProfile"
(Get-Content "/etc/ssh/sshd_config").replace($Text1, $Text2) | Set-Content "/etc/ssh/sshd_config"

systemctl restart sshd


# sed -i 's/^#Subsystem sftp internal-sftp/Subsystem sftp internal-sftp/g' /etc/ssh/sshd_config

#endregion

########################################
#region -- Test remoting

$s = New-PSSession -HostName 172.17.195.137 -KeyFilePath ~/.ssh/id_rsa_redhat9 -UserName root
$s
Get-PSSession

Enter-PSSession -Session $s
Get-Culture
Exit
Exit-PSSession

Invoke-Command -Session $s -ScriptBlock {Get-Culture}
Get-PSSession | Remove-PSSession

#endregion
