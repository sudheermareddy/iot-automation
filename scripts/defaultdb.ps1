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
$client.DownloadFile("https://projectiot.blob.core.windows.net/iotp2/DataServiceSetup.msi","C:\DataServiceSetup.msi")
$client.DownloadFile($sqlQueryUrl,"C:\createdb.sql")
cd C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn
sqlcmd.exe -S $sqlservername -U $adminUsername -P $adminPassword -i C:\createdb.sql -o "C:\Testoutput.txt"
