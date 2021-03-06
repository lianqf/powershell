$Database                       = 'Zichan'
$Server                         = '192.168.181.70'
$UserName                         = 'sa'
$Password                       = 'ABCabc123'
 
$SqlQuery                       = 'select TOP 5 id,Service,ServerID,IP,Model,IDC,Location,Status,AdminUser,User,ServerType,HostName,BuyDate,Etc,OS,Soft1,Soft2,Soft3,SN from jserver_office'
 
# Accessing Data Base
$SqlConnection                  = New-Object -TypeName System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Data Source=$Server;Initial Catalog=$Database;user id=$UserName;pwd=$Password"
$SqlCmd                         = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText             = $SqlQuery
$SqlCmd.Connection              = $SqlConnection
$SqlAdapter                     = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand       = $SqlCmd
$set                            = New-Object data.dataset
 
# Filling Dataset
$SqlAdapter.Fill($set)
 
# Consuming Data
$Path = "$env:temp\report.hta"
$set.Tables[0] | ConvertTo-Html | Out-File -FilePath $Path
 
Invoke-Item -Path $Path 