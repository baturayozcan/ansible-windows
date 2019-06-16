#Change Debug Preference to print debug messages.
$DebugPreference = "Continue"

#Check disk usage and report which has below %15-20 free space on any drive.

#Get-WmiObject Win32_logicaldisk -ComputerName LocalHost `
#| Format-Table DeviceID, MediaType, `
#@{Name="Size(GB)";Expression={[decimal]("{0:N0}" -f($_.size/1gb))}}, `
#@{Name="Free Space(GB)";Expression={[decimal]("{0:N0}" -f($_.freespace/1gb))}}, `
#@{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}} `
#-AutoSize

#Check MT4 logs and compress all except last 7 days.

$mt4logs="D:\MetaTraderServer4\logs\*.log"
#$age=(get-date (get-date).AddDays(-7) -UFormat "%Y%m%d")
$age=(get-date).AddDays(-7)

Get-ChildItem $mt4logs | where-object {$_.LastWriteTime -le $age -AND $_.Attributes -notlike "*Compressed*"} | ForEach-Object {
    compact /C $_.FullName -ErrorVariable CompressingError -Force
}
if ($CompressingError) {
    Write-Debug "FAILURE: Could not compress MT4 logs."
}
else {
    Write-Debug "SUCCESS: MT4 logs compressed."
}


if (Test-Path D:\MetaTraderServer4\plugins\Mt4ToActiveMQ_Plugin) {

    #Check ActiveMQ logs , Delete older than 6 months and compress rest except last file.

    $amqlogs="D:\MetaTraderServer4\plugins\Mt4ToActiveMQ_Plugin\Logs\*.log"

    $age=(get-date).AddMonths(-6)

    Get-ChildItem $amqlogs | where-object {$_.LastWriteTime -le $age} | Remove-Item -ErrorVariable RemovingError -Force
    if ($RemovingError) {
        Write-Debug "FAILURE: Could not delete AMQ logs."
    }
    else {
        Write-Debug "SUCCESS: AMQ logs deleted."
    }

    $age=(get-date).AddDays(-1)

    Get-ChildItem $amqlogs | where-object {$_.LastWriteTime -lt $age -AND $_.Attributes -notlike "*Compressed*"} | ForEach-Object {
        compact /C $_.FullName -ErrorVariable CompressingError -Force
    }
    if ($CompressingError) {
        Write-Debug "FAILURE: Could not compress AMQ logs."
    }
    else {
        Write-Debug "SUCCESS: AMQ logs compressed."
    }

}

#Get-WUInstall -AcceptAll
#Get-Command -Module pswindowsupdate

#Restart-Computer -Force
