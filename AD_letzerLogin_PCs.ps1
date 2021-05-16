<# Erkennt alle AD-Computer, auf denen es seit X tagen keine Anmeldung mehr gab. 
Output entweder in der Konsole oder als Datei (oder beides)

 @autor: mmai 2019
 #>

#funktioniert nur auf DC
Import-Module ActiveDirectory

#Anzahl der Tage, die der PC inaktiv war
$days = 60
#Output-Pfad für Text Datei
#$output = "C:\Temp\AD_info.txt"

$date = (Get-Date).AddDays(-$days)

#Output in Konsole
$info = Get-ADComputer -Property Name,lastLogonDate -Filter {lastLogonDate -lt $date} | Format-Table Name,lastLogonDate
Write-Output $info 

#Output in Text Datei
#$info1 = Get-ADComputer -Property Name,lastLogonDate -Filter {lastLogonDate -lt $date } | Format-Table Name
#$info1 | Out-File -FilePath $output

#verhindert Schließung der Konsole nach Ausführung des Skripts
pause