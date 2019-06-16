$path="D:\MetaTraderServer4\logs\"
$date=(get-date (get-date).AddDays(-1) -UFormat "%Y%m%d")
#$date=(get-date -UFormat "%Y%m%d")
$line=Select-String -Path "$($path)$($date).log" -Pattern "Orders" -CaseSensitive | Select-Object -Last 1
if ($line) {
    if ($line -match "Orders : (.*)") { 
        $orders = $matches[1]
        Write-Host "Orders: $($orders.Split()[0])"
    }
}
else {
    $date=(get-date (get-date).AddDays(-2) -UFormat "%Y%m%d")
    $line=Select-String -Path "$($path)$($date).log" -Pattern "Orders" -CaseSensitive | Select-Object -Last 1
    if ($line -match "Orders : (.*)") { 
        $orders = $matches[1]
        Write-Host "Orders: $($orders.Split()[0])"
    }
    #Write-Host "I am in else"
}