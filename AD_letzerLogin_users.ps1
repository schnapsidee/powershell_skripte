<# Findet Benutzernamen und letzten Login aller aktiven AD Benutzer
   exportiert in CSV Datei unter $Path
   zum Aufraeumen der AD
 @autor: mmai 2019
 #>

#funktioniert nur auf DC
Import-Module ActiveDirectory

#Output-Pfad für Text Datei
$Path = 'C:\Temp\LastLogon.csv'

Get-ADUser -Filter {enabled -eq $true} -Properties LastLogonTimeStamp | 
Select-Object Name;@{Name="Letzer Login"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd_hh:mm:ss')}} | 
Export-Csv -Path $Path –notypeinformation

pause