param(
[string] $sqlQueryUrl = "$1",
[string] $sqlservername = "$2",
[string] $adminUsername = "$3",
[string] $adminPassword = "$4",
[string] $piserverscript = "$5",
[string] $databaseName = "$6"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = New-Object System.Net.WebClient
$client.DownloadFile($sqlQueryUrl,"C:\createdb.sql")
cd C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn
sqlcmd.exe -S $sqlservername -U $adminUsername -P $adminPassword -i C:\createdb.sql -o "C:\Testoutput.txt"
$client.DownloadFile($piserverscript,"C:\piserverscript.sql")
Invoke-sqlcmd -inputfile "C:\piserverscript.sql" -serverinstance $sqlservername -U $adminUsername -P $adminPassword -database $databaseName 
