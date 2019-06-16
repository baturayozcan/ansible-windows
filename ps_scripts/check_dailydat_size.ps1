$size=(Get-Item 'D:\MetaTraderServer4\bases\daily.dat').length
If ( $size -gt 1gb ) {
	$size=$size / 1gb
	$size="{0:N2}" -f $size
	Write-Host "$($size) GB"
}
Elseif ( $size -gt 1mb ) {
	$size=$size / 1mb
	$size="{0:N2}" -f $size
	Write-Host "$($size) MB"
}
Else {
	$size=$size / 1kb
	$size="{0:N2}" -f $size
	Write-Host -Message "$($size) KB"
}
