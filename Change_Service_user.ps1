<#
    aendert den ausfuehrenden User eines Dienstes und startet den Dienst neu
    Loggt alle Erfolge und Computer auf denen der Dienst nicht gefunden wurde

    @author: mmai 03.2019
#>

$service = ""
$service2 = ""

$UserName = ""
$password = ""

$logfile = ""
$hostname = hostname


$ErrorActionPreference = "SilentlyContinue"

function changeServiceUser {
    param (
    [string]$svc, [string]$UserName, [string]$password
    )
    
    $svc_Obj = Get-WmiObject Win32_Service -filter "DisplayName='$svc'"
    
    #setzt Serviceuser und password, startet Dienst neu
    if($null -ne $svc_Obj) {
        $ChangeStatus = $svc_Obj.change($null,$null,$null,$null,$null,$null, $UserName,$password,$null,$null,$null)
        if ($ChangeStatus.ReturnValue -eq "0")  
        	{Add-Content $logfile "$hostname - User fuer '$svc' wurde auf $userName geaendert"} 
        $StartStatus = $svc_Obj.StartService() 
        if ($StartStatus.ReturnValue -eq "0")  
        	{Add-Content $logfile "$hostname - Der Dienst '$svc' wurde gestartet"} 
    } 
    
    #Wenn der Dienst nicht gefunden wird
    else {
        Add-Content $logfile "$hostname - Service '$svc' nicht installiert"
    }
    
}

changeServiceUser $service $UserName $password
changeServiceUser $service2 $UserName $password