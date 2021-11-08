# In a loop:
$test = @('remotehostname:80','remotehostname:9548','remotehostname:4561', 'remotehostname:4562')

Write-Output "check server and port, lazy admin at:"
$env:computername

Foreach ($t in $test)
{
  $source = $t.Split(':')[0]
  $port = $t.Split(':')[1]
  
  Write-Host "Connecting to $source on port $port"

  try
  {
    $socket = New-Object System.Net.Sockets.TcpClient($source, $port)
    $socket.ToString()
  }
  catch [Exception]
  {
    Write-Host $_.Exception.GetType().FullName
    Write-Host $_.Exception.Message
  }

  Write-Host "Connected`n"
}
