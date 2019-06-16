#Change Debug Preference to print debug messages.
$DebugPreference = "Continue"

$mt4logs="D:\MetaTraderServer4\logs\*.log"
#$age=(get-date (get-date).AddDays(-7) -UFormat "%Y%m%d")
$age=(get-date).AddDays(-7)
Get-ChildItem $mt4logs | where-object {$_.LastWriteTime -le $age -AND $_.Attributes -notlike "*Compressed*"} | Remove-Item -ErrorVariable RemovingError -Force
if ($RemovingError) {
    Write-Debug "FAILURE: Could not delete MT4 logs."
}
else {
    Write-Debug "SUCCESS: MT4 logs deleted."
}

$amqlogs="D:\MetaTraderServer4\plugins\Mt4ToActiveMQ_Plugin\Logs\*.log"
Get-ChildItem $amqlogs | where-object {$_.LastWriteTime -le $age -AND $_.Attributes -notlike "*Compressed*"} | Remove-Item -ErrorVariable RemovingError -Force
if ($RemovingError) {
    Write-Debug "FAILURE: Could not delete AMQ logs."
}
else {
    Write-Debug "SUCCESS: AMQ logs deleted."
}