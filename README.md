# Volumio Powershell
This Powershell Module allows you to control your Volumio devices via PowerShell.

# Installation
From repository (Recommended)
```PowerShell
Install-Module -Name Volumio
```

OR

```
Import-Module "{FullPath}\volumio-powershell\Volumio.psd1"
```


# Usage

## Connect to a Volumio Server
```powershell
Connect-VolumioServer -ServerURL 'http://volumio.local' 
```

## Change Volumio Volume 
```powershell
# Enter a volume number from 1 to 100
Set-VolumioVolume -Volume 1
```

## Get Volumio Playlists
```powershell
# To get all playlists run: 
Get-VolumioPlaylist

# To get a specific playlists run: 
Get-VolumioPlaylist -Name 'PlayListName'
```

## Play Volumio Playlist 
```powershell
# We get a specific playlists and then pipe it to the play playlist command: 
Get-VolumioPlaylist -Name 'PlayListName' | Play-VolumioPlaylist

# Or we can just call the Play-VolumioPlaylist with the name argument:
Play-VolumioPlaylist -Name 'PlayListName'
```

## Additional Volumio Actions
```powershell
# Invoke Play Action
Invoke-VolumioCommand -Play

# Invoke Toggle Play Action / Toggle between Play and Pause
Invoke-VolumioCommand -TogglePlay

# Invoke Stop Action
Invoke-VolumioCommand -Stop

# Invoke Pause Action
Invoke-VolumioCommand -Pause

# Invoke Next Action
Invoke-VolumioCommand -Next

# Invoke Previous Action
Invoke-VolumioCommand -Previous
```
