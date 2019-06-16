Import-Module Pscx
set-alias rar "C:\Program Files\WinRAR\WinRAR.exe"
$metadir="D:\MetaTraderServer4\logs"
$date=(get-date (get-date).addMonths(-1) -UFormat "%Y%m")
$year=(get-date (get-date).addMonths(-1) -UFormat "%Y")
$month=(get-date (get-date).addMonths(-1) -UFormat "%m")
$server_name=gci C:\ansible\files\*.ansibleID | %{$_.BaseName}
$files="$($metadir)\$($date)*.log"
$path=Get-ChildItem $files
$file_name="$($server_name).$($year).$($month).zip"
foreach ($zipfile in $path) {rar  a -ep -IBCK "$($metadir)\$($file_name)" $zipfile | Get-Process rar | Wait-Process }
$s3_bucket_name=import-csv C:\ansible\files\AWS_S3_credentials.csv -Delimiter ";" | Where-Object {$_.s3_server_name -eq $server_name} | % {$_.s3_bucket_name}
$s3_path=import-csv C:\ansible\files\AWS_S3_credentials.csv -Delimiter ";" | Where-Object {$_.s3_server_name -eq $server_name} | % {$_.s3_path}
$s3_access_key_id=import-csv C:\ansible\files\AWS_S3_credentials.csv -Delimiter ";" | Where-Object {$_.s3_server_name -eq $server_name} | % {$_.s3_access_key_id}
$s3_secret_access_key=import-csv C:\ansible\files\AWS_S3_credentials.csv -Delimiter ";" | Where-Object {$_.s3_server_name -eq $server_name} | % {$_.s3_secret_access_key}
Write-S3Object -BucketName $s3_bucket_name -File $metadir\$file_name -Key $s3_path\$file_name -CannedACLName Private -AccessKey $s3_access_key_id -SecretKey $s3_secret_access_key
Remove-Item $metadir\$file_name