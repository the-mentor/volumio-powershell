function Connect-VolumioServer {
    param (
        [Parameter(Position=0,ValueFromPipeline=$TRUE,Mandatory=$true)]$ServerURL
    )
    
    if((Invoke-RestMethod -Uri "$ServerURL/api/v1/ping") -eq 'pong'){
        $Global:VolumioServerURL = $ServerURL
        Write-Host 'Connected to Voumio Server'
    }
}

function Invoke-VolumioCommand {
    param (
        [switch]$Play,
        [switch]$TogglePlay,
        [switch]$Stop,
        [switch]$Pause,
        [switch]$Previous,
        [switch]$Next,
        [int]$Volume
    )

    if($TogglePlay){
        $cmd = 'toggle'
    }
    elseif($Play){
        $cmd = 'play'
    }
    elseif($Stop){
        $cmd = 'stop'
    }
    elseif($Pause){
        $cmd = 'pause'
    }
    elseif($Previous){
        $cmd = 'prev'
    }
    elseif($Next){
        $cmd = 'next'
    }
    elseif($Volume){
        $cmd = "volume&volume=$Volume"
    }

    Invoke-RestMethod -Uri "http://volumio.local/api/v1/commands/?cmd=$cmd"
}

function Get-VolumioStats {
    param (
        [switch]$Collection
    )

    if($Collection){
        Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/collectionstats"
    }
    else{
        Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/getState"
    }
}

function Get-VolumioZones {
    param (
    )

    (Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/getzones").zones
    
}

function Get-VolumioQueue {
    param (
    )

    (Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/getQueue").queue

    
}

function Clear-VolumioQueue {
    param (
    )

    Invoke-RestMethod -Uri "$($Global:VolumioServerURL)//api/v1/commands/?cmd=clearQueue"

    
}

function Get-VolumioPlaylist {
    param(
        $Name
    )

    if($Name){
        $r = Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/listplaylists" # | foreach{$_| Select-Object @{l='PlayListName';e={$_}}} |Where-Object {$_.PlayListName -eq $Name }
        $r |Where-Object {$_ -eq $Name}
    }
    else{
        Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/listplaylists" #| foreach{$_| Select-Object @{l='PlayListName';e={$_}}}
    }
}

function Play-VolumioPlaylist {
    param(
        [Parameter(Position=0,ValueFromPipeline=$TRUE,Mandatory=$true)]$Name
    )

    if($PlayListName){
        $PlayListName = $Name | Select-Object -ExpandProperty PlayListName
    }
    else{
        $PlayListName = $Name
    }

    Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/commands/?cmd=playplaylist&name=$Name"
    
}

function Set-VolumioVolume {
    param(
        [Parameter(Position=0,ValueFromPipeline=$TRUE,Mandatory=$true)][int]$Volume
    )

    if($Volume -le 100 -and $Volume -ge 1 ){
        Invoke-VolumioCommand -Volume $Volume
    }
    else {
        Write-Error "Volume should be a number between 1 and 100"
    }
    
  
}

