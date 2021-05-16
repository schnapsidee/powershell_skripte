<# Findet alle Printserver in der Domäne
   
@author mmai
#>

#muss auf CD ausgeführt werden
Import-Module ActiveDirectory

Get-ADObject -LDAPFilter "(&(&(&(uncName=*)(objectCategory=printQueue))))" -properties *|Sort-Object -Unique -Property servername |Select-Object servername

pause