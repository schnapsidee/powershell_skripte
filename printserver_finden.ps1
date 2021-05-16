<# Findet alle Printserver in der Dom�ne
   
@author mmai
#>

#muss auf CD ausgef�hrt werden
Import-Module ActiveDirectory

Get-ADObject -LDAPFilter "(&(&(&(uncName=*)(objectCategory=printQueue))))" -properties *|Sort-Object -Unique -Property servername |Select-Object servername

pause