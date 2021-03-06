<#
powershell通过netstat分组统计tcp连接
#>

$tcp_count = netstat -ano |select -skip 3| where-Object {$_ -match "tcp"} | ForEach-Object {
       $i = $_ | Select-Object -Property Protocol , Source , Destination , Mode ,pid
       $null, $i.Protocol, $i.Source, $i.Destination, $i.Mode, $i.pid=  ($_ -split '\s{2,}')
       $i

}

$tcp_mode = $tcp_count | Group-Object Mode | select count,Name |Format-Table -AutoSize
$tcp_DIP = $tcp_count | Group-Object {$_.Destination.split(":")[0]} | select count,Name |Sort-Object -Descending count|Format-Table -AutoSize
$tcp_count |Format-Table -AutoSize 
write-host "total tcp count:"-ForegroundColor green
Write-Host $tcp_count.count
write-host "status group:" -ForegroundColor green
$tcp_mode 
write-host "status Destination IP:" -ForegroundColor green 
$tcp_DIP 