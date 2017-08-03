param(
[string] $simulatorUrl = "$1",
[string] $dataserviceUrl = "$2"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
$client.DownloadFile($simulatorUrl,"C:\SimulatorSetup.msi")
C:\SimulatorSetup.msi /qn
Start-Sleep -s 12
$client.DownloadFile($dataserviceUrl,"C:\DataServiceAppSetup.msi")
C:\DataServiceAppSetup.msi /qn
Start-Sleep -s 12
$piserverconfig = "C:\Program Files (x86)\Default Company Name\SimulatorSetup\PiServerSimulator.exe.config"
$doc = (Get-Content $piserverconfig) -as [Xml]
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'PiConnectionString'}
$obj.value = 'Data Source=sqlvm; Initial Catalog=iottestdb; Persist Security Info=True; User ID=sqluser; Password=Password@1234'
$doc.Save($piserverconfig)
Start-Process -FilePath " C:\Program Files (x86)\Default Company Name\SimulatorSetup\PiServerSimulator.exe "
