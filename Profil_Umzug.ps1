#!! ACHTUNG! Wurde lange nicht getestet -> Sollte vor erstem Einsatz getestet werden 

<# Ändert Profilpfad für alle AD Benutzer
   Variablen für alte und neue Server müssen gesetzt werden 

@author mmai
#>

Import-Module ActiveDirectory

$alterServer = ""
$neuerServer = ""

$ou = "Dc=Gruppe,Dc=domain"
$properties = "ProfilePath","ScriptPath", "l"
Get-ADUser -Filter * -SearchBase $ou -Properties $properties |
ForEach-Object {
        $ProfilePath = "{0}" -f $_.l, $_.SamAccountName
        $tmp = $_.ProfilePath
        $tmpUser = $_.Name
        
        #wenn Profilpfad nicht leer
        if (($tmp -ne $null) -and ($tmp -ne ''))
        {
                #nur Profile mit dem alten Servernamen und NICHT dem neuen, werden bearbeitet
                if (($tmp.Contains($alterServer)) -and !$tmp.Contains($neuerServer))
                {
                        #print aktuellen Profilpfad
                        "$tmp"
                        #Ersetzt Servernamen im Profilpfad
                        $tmp = $tmp.replace($neuerServer,$alterServer)
                        #print neuen Profilpfad und Usernamen
                        "$tmpuser --- $tmp"
                        #update AD
                        Set-ADUser $_.samaccountname -ProfilePath $tmp
                }
        }
}