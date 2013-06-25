#Local settings
$live_deploy = "./_live_deploy"

#Deployment settings
$targetServer = "prod-extapp01.win.sys.7d"
$targetEnvironment = "prod"
$webRoot = "D:/inetpub/7d-buyitnow/"

#TeamCity settings
$buildId = "bt33"
$teamCityServer = "http://teamcity.7digital-devint.co.uk:8111"
$buildTag  = "PROD"

IF (Test-Path $live_deploy)
{
	Remove-Item $live_deploy -Force -Recurse
}

md $live_deploy
md $live_deploy/sitefiles 

#pull down PROD site files
Invoke-WebRequest $teamCityServer/guestAuth/repository/download/$buildId/$buildTag.tcbuildtag/sitefiles/site.zip -OutFile $live_deploy/sitefiles/site.zip

#pull down PROD demo files
Invoke-WebRequest $teamCityServer/guestAuth/repository/download/$buildId/$buildTag.tcbuildtag/sitefiles/demos.zip -OutFile $live_deploy/sitefiles/demos.zip

#pull down PROD production environment files (e.g. web.config etc)
Invoke-WebRequest $teamCityServer/guestAuth/repository/download/$buildId/$buildTag.tcbuildtag/prod/prod.zip -OutFile $live_deploy/sitefiles/prod.zip

# pull down project deploy scripts
Invoke-WebRequest $teamCityServer/guestAuth/repository/download/$buildId/$buildTag.tcbuildtag/deploy.zip -OutFile $live_deploy/deploy.zip

# unpack NOTE - Cannot use the $live_deploy variable above as the lack of whitespace means ps parses it as a string literal
& C:\TeamCityBuildTools\7-Zip\7z.exe x $live_deploy/deploy.zip -y -o_live_deploy/

# Run deploy scripts - TODO - need to get these to use batch file settings in "environments" folder
# Copy pinned service
& $live_deploy/deploy-service.bat $targetServer $targetEnvironment $webRoot

# Unpack all zips to output
& $live_deploy/unpack-service.bat $targetServer $targetEnvironment $webRoot

# Setup IIS - this uses correct end bat settings
& $live_deploy/run_deploy.bat live

# delete zips
Remove-Item $live_deploy -Force -Recurse