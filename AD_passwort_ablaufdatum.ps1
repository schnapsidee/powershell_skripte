<# findet das Passwort Ablaufdatum fuer den angegeben User
    muss auf DC ausgefuehrt werden
    
 @autor: mmai 2019
 #>

Import-Module ActiveDirectory

$user = Read-Host "Username"

Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and SamAccountName -like $user} -Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" |
Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}} 

Pause