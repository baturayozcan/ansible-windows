#Change Debug Preference to print debug messages.
$DebugPreference = "Continue"

$tcpConnection = New-Object System.Net.Sockets.TcpClient("localhost", 9911)
$tcpStream = $tcpConnection.GetStream()
$reader = New-Object System.IO.StreamReader($tcpStream)
if ($tcpConnection.Connected)
{
    if ($tcpStream.DataAvailable)
    {
        $reader.ReadLine()
    }
}
$reader.Close()
$tcpConnection.Close()
Write-Debug $reader