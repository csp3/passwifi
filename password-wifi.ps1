<#
uso:
.\password-wifi.ps1 
#>
Clear-Host
$pro = @()
$c = 0
Write-Host "REDES:"
foreach($perfil in (netsh wlan show profiles) | Select-String "\:(.+)$" )
{
    $pro += $perfil.Matches.Groups[1].value.trim()
    Write-Host ($c+1)")" $pro[$c++]   
}

write-host ""

do {
    write-Host -NoNewline "Opcion: " -foregroundcolor green; 
    $r= read-host;
    $r = [int]$r;
} while ( ($r -lt 1) -or ($r -gt $c) )
 
$clave = netsh wlan show profile name = $pro[$r - 1] key = clear | Select-String "Contenido de la clave"   

write-host " Clave:" -NoNewline -ForegroundColor green 
Write-Host -NoNewline ($clave -split ":")[1] -ForegroundColor Yellow `n `n 
pause 
