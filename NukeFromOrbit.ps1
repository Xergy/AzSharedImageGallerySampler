$RGsToNuke = Get-AzResourceGroup | Where-Object {$_.ResourceGroupName -like "acme-dev-eus-sig*" }

$Jobs = $RGsToNuke | Remove-AzResourceGroup -Force -AsJob

Write-Host "$(get-date) Removing RGs. This will take a while... "

$Jobs | wait-job -Verbose

Write-Host "$(get-date) Done!"

$JobResults =  $Jobs | Receive-Job -Keep