## Script Name:    Clean-IISLogs
## Input/Output:   Directory of IIS Logs
## Description:    Detects service state for predefined service in global variable.
##                 If service is stopped, perform loop to start the service and log the start.
##                 If service is started, log that fact.

param ([Parameter(Mandatory=$True)][string]$LogPath)

$retentionDays = 90
$expirationDate = (Get-Date).AddDays(-$retentionDays)
$expiredLogs = Get-ChildItem -Path $LogPath -Recurse | Where-Object {$_.LastWriteTime -lt $expirationDate}
$expiredLogs | Remove-Item -Force -Recurse
