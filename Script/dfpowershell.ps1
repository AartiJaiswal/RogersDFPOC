$SecurePassword = "$(key)" | ConvertTo-SecureString -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential `
-argumentlist "$(clientID)", $SecurePassword
$tenantID = "9e9dea74-ace1-4615-a603-b76fa219cf55"
Connect-AzAccount -Credential $cred -TenantId "$(tenantID)" -ServicePrincipal

$resourceGroupName = "RogersPOC";
$dataFactoryName = "RogersDFPOC";


$files = Get-ChildItem $(System.DefaultWorkingDirectory)\_AartiJaiswal_RogersDFPOC\pipeline\*.json
foreach ($file in $files)
{
 $outputFile = Split-Path $file -leaf
 $pipeline =[System.IO.Path]::GetFileNameWithoutExtension($outputFile)
 Set-AzDataFactoryV2Pipeline -DataFactoryName $dataFactoryName $pipeline -ResourcegroupName $resourceGroupName -DefinitionFile "$file"  -Force -Confirm:$false
 
}


$files = Get-ChildItem $(System.DefaultWorkingDirectory)\_AartiJaiswal_RogersDFPOC\dataset\*.json
foreach ($file in $files)
{
 $outputFile = Split-Path $file -leaf
 $dataset =[System.IO.Path]::GetFileNameWithoutExtension($outputFile)
 Set-AzDataFactoryV2Dataset -DataFactoryName $dataFactoryName $dataset -ResourcegroupName $resourceGroupName -DefinitionFile "$file"   -Force -Confirm:$false
 
}
$files = Get-ChildItem $(System.DefaultWorkingDirectory)\_AartiJaiswal_RogersDFPOC\linkedService\*.json
foreach ($file in $files)
{
 $outputFile = Split-Path $file -leaf
 $filename =[System.IO.Path]::GetFileNameWithoutExtension($outputFile)

Set-AzDataFactoryV2LinkedService -DataFactoryName $dataFactoryName $filename -ResourcegroupName $resourceGroupName -DefinitionFile "$file"   -Force -Confirm:$false
}

