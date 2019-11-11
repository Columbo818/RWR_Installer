#!/usr/bin/env python3

import requests
import os
import zipfile
from shutil import copyfile

def getRegion():
    r = requests.get('https://ipinfo.io')
    region = r.json()['region']
    country = r.json()['country']
    regionstring = '{}, {}'.format(region, country)
    return regionstring

if(os.name == 'nt'):
    print('Detected MS Windows system...')
    if(os.path.exists('C:\SteamCMD1')):
        print('SteamCMD installation found')
    else:
        print('SteamCMD folder created')
        os.system('mkdir C:\SteamCMD1')
        r = requests.get('https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip')
        open('C:\SteamCMD1\steamcmd.zip', 'wb').write(r.content)
        with zipfile.ZipFile('C:\SteamCMD1\steamcmd.zip','r') as zip_ref:
            zip_ref.extractall('C:\SteamCMD1')
        os.remove('C:\SteamCMD1\steamcmd.zip')
        user = input("Enter your Steam username: ")
        passw = input("Enter your Steam password: ")
        os.system('C:\SteamCMD1\steamcmd.exe +login {} {} +app_update 270150 validate +quit'.format(user, passw))
        print(getRegion())
        print('Done!')
        print('Done!')
        copyfile('C:\SteamCMD\steamapps\common\RunningWithRifles\media\packages\vanilla\scripts\start_invasion.as', 'C:\SteamCMD\steamapps\common\RunningWithRifles\media\packages\vanilla\scripts\my_invasion.as')
else:
    print('System type unknown...')
    exit()


