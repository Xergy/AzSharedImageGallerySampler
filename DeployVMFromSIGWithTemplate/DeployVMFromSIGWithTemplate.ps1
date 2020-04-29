
$RG = "acme-dev-eus-sigt-03-rg"

new-azResourceGroup -Name $RG -Location "EastUS"

New-AzResourceGroupDeployment -ResourceGroupName $RG -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json" -Verbose