$clientID = "65582b83-9bfa-4931-9e1c-5c9f5a7f80b0"
$key = "gH[1c_p1-=BVC0ok4b4/V78o?W7/uXGW"
$SecurePassword = $key | ConvertTo-SecureString -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential `
-argumentlist $clientID, $SecurePassword
$tenantID = "9e9dea74-ace1-4615-a603-b76fa219cf55"
Connect-AzureRmAccount -Credential $cred -TenantId $tenantID -ServicePrincipal

$resourceGroupName = "RogersPOC";
$dataFactoryName = "RogersDFPOC";

Set-AzureRmDataFactoryV2Pipeline -DataFactoryName 'RogersDFPOC' Copy -ResourcegroupName RogersPOC -DefinitionFile ".\Copy.json" 