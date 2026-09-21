<#
.SYNOPSIS 
 Kurzbeschreibung welche Aufgaben
.DESCRIPTION
 Eine lange Beschreibung
.PARAMETER EventId
 4624 Anmeldung
 4625 fehlgeschlagene Anmeldung
 4634 Abmeldung
.LINK
 https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1#syntax-for-comment-based-help-in-functions
#>
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$EventId,

[ValidateRange(5,20)]
[int]$Newest = 5,

[string]$Computername = "localhost"
)
Write-Verbose -Message "Optionale Ausgabe die nur ausgegeben wird wenn das SKript mit -Verbose gestartet wird"
Write-Debug -Message "Debughaltepunkte die nur wirken wenn das Skript mit -Debug aufgerufen "
Get-EventLog -LogName Security -ComputerName $Computername | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

