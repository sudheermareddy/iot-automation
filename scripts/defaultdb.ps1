param(
[string] $sqlQueryUrl = "$1",
[string] $serverName = "$2",
[string] $sqlUserName = "$3",
[string] $sqlserverpwd = "$4",
[string] $piserverscript = "$5",
[string] $databaseName = "$6"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = New-Object System.Net.WebClient
$client.DownloadFile($sqlQueryUrl,"C:\createdb.sql")
cd C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn
sqlcmd.exe -S $serverName -U $sqlUserName -P $sqlserverpwd -i C:\createdb.sql -o "C:\Testoutput.txt"
$client.DownloadFile($piserverscript,"C:\piserverscript.sql")
Invoke-sqlcmd -inputfile "C:\piserverscript.sql" -serverinstance $serverName -U $sqlUserName -P $sqlserverpwd -database $databaseName 
