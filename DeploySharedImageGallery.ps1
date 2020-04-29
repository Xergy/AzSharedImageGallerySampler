$RGName = 'acme-dev-eus-sig-rg'
$Location = 'EastUs'

New-AzResourceGroup `
   -Name $RGName  `
   -Location $Location	

$resourceGroup = Get-AzResourceGroup -Name $RGName 

$GalleryName ='acmedevsig'

New-AzGallery `
   -GalleryName $GalleryName `
   -ResourceGroupName $resourceGroup.ResourceGroupName `
   -Location $resourceGroup.Location `
   -Description 'Shared Image Gallery for my organization'	

$gallery = Get-AzGallery -Name $GalleryName

$GallaryImageName = 'windows-server-2019-base' 

New-AzGalleryImageDefinition `
   -GalleryName $gallery.Name `
   -ResourceGroupName $resourceGroup.ResourceGroupName `
   -Location $gallery.Location `
   -Name $GallaryImageName `
   -OsState generalized `
   -OsType Windows `
   -Publisher 'acme' `
   -Offer 'baseoffer' `
   -Sku 'windowsserver2019'

$galleryImage = Get-AzGalleryImageDefinition -Name $GallaryImageName -ResourceGroupName $resourceGroup.ResourceGroupName -GalleryName $gallery.Name

#$region1 = @{Name='EastUs2';ReplicaCount=1}
$region2 = @{Name='EastUs';ReplicaCount=1}
#$targetRegions = @($region1,$region2)
$targetRegions = @($region2)

$GalleryImageVersionName = '1.0.1' 

$managedImage = Get-AzImage `
   -ImageName "windows-server-2019-base" `
   -ResourceGroupName "acme-dev-eus-sigt-01-rg"

New-AzGalleryImageVersion `
   -GalleryImageDefinitionName $galleryImage.Name `
   -GalleryImageVersionName $GalleryImageVersionName `
   -GalleryName $gallery.Name `
   -ResourceGroupName $resourceGroup.ResourceGroupName `
   -Location $resourceGroup.Location `
   -TargetRegion $targetRegions  `
   -Source $managedImage.Id.ToString() `
   -PublishingProfileEndOfLifeDate '2030-01-01' `
   
$imageVersion = get-azGalleryImageVersion -Name $GalleryImageVersionName -ResourceGroupName $resourceGroup.ResourceGroupName -GalleryName $gallery.Name -GalleryImageDefinitionName $galleryImage.Name


