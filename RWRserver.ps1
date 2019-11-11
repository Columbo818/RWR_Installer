if(!(Test-Path -Path C:\SteamCMD\steamcmd.exe)){
    Write-Host 'No SteamCMD installation found!' -ForegroundColor Red
    New-Item -ItemType Directory -Path C:\SteamCMD -Force
    Write-Host 'SteamCMD directory created!' -ForegroundColor Green
    Invoke-WebRequest https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -OutFile C:\SteamCMD\steamcmd.zip
    Write-Host 'SteamCMD downloaded!' -ForegroundColor Green
    Expand-Archive -Path C:\SteamCMD\steamcmd.zip -DestinationPath C:\SteamCMD\
    Write-Host 'SteamCMD extracted!' -ForegroundColor Green
    Remove-Item -Path C:\SteamCMD\steamcmd.zip
    $username = Read-Host -Prompt 'Please enter your steam username (login is required to check for game license)'
    $password = Read-Host -Prompt 'Please enter your steam password'
    Clear-Host
    Write-Host 'Starting SteamCMD...' -ForegroundColor Yellow
    Start-Process -FilePath "C:\SteamCMD\steamcmd.exe"  -ArgumentList "+login $username $password +app_update 270150 validate +quit" -Wait
    Write-Host 'RunningWithRifles installed successfully!!' -ForegroundColor Green
    Write-Host 'Configuring server settings...' -ForegroundColor Yellow
    Copy-Item -Path C:\SteamCMD\steamapps\common\RunningWithRifles\media\packages\vanilla\scripts\start_invasion.as -Destination C:\SteamCMD\steamapps\common\RunningWithRifles\media\packages\vanilla\scripts\my_invasion.as
    (Get-Content C:\SteamCMD\steamapps\common\RunningWithRifles\media\packages\vanilla\scripts\my_invasion.as).replace('InvasionEU', 'APEK Invasion EU') | Set-Content C:\SteamCMD\steamapps\common\RunningWithRifles\media\packages\vanilla\scripts\my_invasion.as
    Invoke-WebRequest http://www.modulaatio.com/wp/commands.xml -OutFile C:\SteamCMD\steamapps\common\RunningWithRifles\commands.xml
    (Get-Content C:\SteamCMD\steamapps\common\RunningWithRifles\commands.xml).replace('<!-- ', '') | Set-Content C:\SteamCMD\steamapps\common\RunningWithRifles\commands.xml
    (Get-Content C:\SteamCMD\steamapps\common\RunningWithRifles\commands.xml).replace(' -->', '') | Set-Content C:\SteamCMD\steamapps\common\RunningWithRifles\commands.xml
    (Get-Content C:\SteamCMD\steamapps\common\RunningWithRifles\commands.xml).replace('say test; start_game 0 0 0.94 300; say yay!', 'start_script my_invasion.as') | Set-Content C:\SteamCMD\steamapps\common\RunningWithRifles\commands.xml
    Invoke-WebRequest http://www.modulaatio.com/wp/geoinfo.xml -OutFile C:\SteamCMD\steamapps\common\RunningWithRifles\geoinfo.xml
    (Get-Content C:\SteamCMD\steamapps\common\RunningWithRifles\geoinfo.xml).replace('Greyland', 'London, England') | Set-Content C:\SteamCMD\steamapps\common\RunningWithRifles\geoinfo.xml
    Invoke-WebRequest http://www.modulaatio.com/wp/admins.xml -OutFile C:\SteamCMD\steamapps\common\RunningWithRifles\admins.xml
    (Get-Content C:\SteamCMD\steamapps\common\RunningWithRifles\admins.xml).replace('pasik', 'yezcrusader') | Set-Content C:\SteamCMD\steamapps\common\RunningWithRifles\admins.xml
    (Get-Content C:\SteamCMD\steamapps\common\RunningWithRifles\admins.xml).replace('jackmayol', 'columbo818') | Set-Content C:\SteamCMD\steamapps\common\RunningWithRifles\admins.xml
    Write-Host 'Done. Running server...' -ForegroundColor Green
    Start-Process -FilePath "C:\SteamCMD\steamapps\common\RunningWithRifles\rwr_server.exe"
    }
else{
    $username = Read-Host -Prompt 'Please enter your steam username (login is required to check for game license)'
    $password = Read-Host -Prompt 'Please enter your steam password'
    Clear-Host
    Write-Host 'Starting SteamCMD...' -ForegroundColor Yellow
    Start-Process -FilePath "C:\SteamCMD\steamcmd.exe"  -ArgumentList "+login $username $password +app_update 270150 validate +quit" -Wait
    Write-Host 'RunningWithRifles updated successfully!!' -ForegroundColor Green
    Write-Host 'Running server...' -ForegroundColor Green
    Start-Process -FilePath "C:\SteamCMD\steamapps\common\RunningWithRifles\rwr_server.exe"
    }