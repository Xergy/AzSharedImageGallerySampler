
$RG = "acme-dev-eus-sigt-03-rg"

New-AzResourceGroup -Name $RG -Location "EastUS"

New-AzResourceGroupDeployment -ResourceGroupName $RG -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json" -Verbose