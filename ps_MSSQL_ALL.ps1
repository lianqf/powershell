$Database                       = 'Zichan'
$Server                         = '192.168.181.70'
$UserName                         = 'sa'
$Password                       = 'ABCabc123'
 
$SqlQuery                       = 'select TOP 1 id from test order by id desc '
 
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
 
[int32]$last_id = $set.Tables[0] | select -ExpandProperty id

for ($i=0;$i -lt 30000;$i++) {

    $insertDateTime = Get-Date -F "yyyyMMddHHmmss"
    $last_id++  
    $SqlQuery                       = "INSERT INTO test (id,insetdatetime) values ($last_id,$insertDateTime)"

    # Accessing Data Base
    $SqlConnection                  = New-Object -TypeName System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = "Data Source=$Server;Initial Catalog=$Database;user id=$UserName;pwd=$Password"
    $SqlConnection.open()
    $SqlCmd                         = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.CommandText             = $SqlQuery
    $SqlCmd.Connection              = $SqlConnection
    $sqlCmd.ExecuteNonQuery()
    Start-Sleep -s 5
}