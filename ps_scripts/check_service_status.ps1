$getservice = Get-Service -Name mtsrv
if ($getservice.Status -eq "Running") {
    Write-Output "MT4 service is running."
}
else {
    Write-Output "MT4 service is not running."
}