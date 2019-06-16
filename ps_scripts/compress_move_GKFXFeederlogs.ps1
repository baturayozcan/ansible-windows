set-alias rar "C:\Program Files\WinRAR\WinRAR.exe"
$metadir="D:\MetaTraderServer4\datafeed"
$year=(get-date (get-date).addMonths(-1) -UFormat "%Y")
$month=(get-date (get-date).addMonths(-1) -UFormat "%m")
$server_name=gci C:\ansible\files\*.ansibleID | %{$_.BaseName}


if (($server_name -ne "demo2") -And ($server_name -ne "isikfxlive") -And ($server_name -ne "isikfxdemo") -And ($server_name -ne "kapitalfxlive") -And ($server_name -ne "kapitalfxdemo")) {  #we do not have GKFX feeder on these

	if (($server_name -eq "live0") -Or ($server_name -eq "live1") -Or ($server_name -eq "live1.2") -Or ($server_name -eq "live1.4")) {
		$files="$($metadir)\GKFXPrimeFeeder_$($year)_$($month)*.log"
		$path=Get-ChildItem $files
		$file_name="GKFXPrimeFeeder_$($year).$($month).zip"
		foreach ($zipfile in $path) {rar  a -ep -IBCK "$($metadir)\$($file_name)" $zipfile | Get-Process rar | Wait-Process }
		Move-Item $metadir\$file_name E:\GKFXPrimeFeederLogs
		foreach ($log in $files) {Remove-Item $log}
		$files="$($metadir)\GKFXPrimeFeed-RS-Master_$($year)_$($month)*.log"
                $path=Get-ChildItem $files
                $file_name="GKFXPrimeFeed-RS-Master_$($year).$($month).zip"
                foreach ($zipfile in $path) {rar  a -ep -IBCK "$($metadir)\$($file_name)" $zipfile | Get-Process rar | Wait-Process }
                Move-Item $metadir\$file_name E:\GKFXPrimeFeederLogs
                foreach ($log in $files) {Remove-Item $log}
	}
	
	else {
		$files="$($metadir)\GKFXFeeder_$($year)_$($month)*.log"
		$path=Get-ChildItem $files
		$file_name="GKFXFeeder_$($year).$($month).zip"
		foreach ($zipfile in $path) {rar  a -ep -IBCK "$($metadir)\$($file_name)" $zipfile | Get-Process rar | Wait-Process }
		Move-Item $metadir\$file_name E:\GKFXFeederLogs
		foreach ($log in $files) {Remove-Item $log}
		$files="$($metadir)\GKFXFeed-RS-Master_$($year)_$($month)*.log"
                $path=Get-ChildItem $files
                $file_name="GKFXFeed-RS-Master_$($year).$($month).zip"
                foreach ($zipfile in $path) {rar  a -ep -IBCK "$($metadir)\$($file_name)" $zipfile | Get-Process rar | Wait-Process }
                Move-Item $metadir\$file_name E:\GKFXFeederLogs
                foreach ($log in $files) {Remove-Item $log}
	}



}
