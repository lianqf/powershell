$Database                       = 'Zichan'
$Server                         = '192.168.181.70'
$UserName                         = 'sa'
$Password                       = 'ABCabc123'
 
$SqlQuery                       = "INSERT INTO test (id,insetdatetime) values ('3','2015110303')"

# Accessing Data Base
$SqlConnection                  = New-Object -TypeName System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Data Source=$Server;Initial Catalog=$Database;user id=$UserName;pwd=$Password"
$SqlConnection.open()
$SqlCmd                         = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText             = $SqlQuery
$SqlCmd.Connection              = $SqlConnection
$sqlCmd.ExecuteNonQuery()