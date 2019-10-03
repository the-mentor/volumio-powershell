function Connect-VolumioServer {
    param (
        [Parameter(Position=0,ValueFromPipeline=$TRUE,Mandatory=$true)]$ServerURL
    )
    
    try{
        $VolumioPong = Invoke-RestMethod -ErrorAction stop -Uri "$ServerURL/api/v1/ping" 
    }
    catch{
        Write-Error "Volumio Server could not be contacted please check the server URL: $ServerURL"
    }

    if($VolumioPong -eq 'pong'){
        $Global:VolumioServerURL = $ServerURL
        Write-Host "Connected to Volumio Server: $Global:VolumioServerURL"
    }

}

function Test-VolumioServerConnection {
    if(!$Global:VolumioServerURL){
        throw 'Please Connect to a Volumio Server using the Connect-VolumioServer command and try again'
    }
    else{
        try{
            Invoke-RestMethod -Uri "$ServerURL/api/v1/ping"
        }
        catch{
            #TODO add error catch code
        }
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

    Test-VolumioServerConnection

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

    Invoke-RestMethod -Uri "$Global:VolumioServerURL/api/v1/commands/?cmd=$cmd"
}

function Get-VolumioStats {
    param (
        [switch]$Collection
    )

    Test-VolumioServerConnection

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

    Test-VolumioServerConnection

    (Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/getzones").zones
    
}

function Get-VolumioQueue {
    param (
    )

    Test-VolumioServerConnection

    (Invoke-RestMethod -Uri "$($Global:VolumioServerURL)/api/v1/getQueue").queue

    
}

function Clear-VolumioQueue {
    param (
    )

    Test-VolumioServerConnection

    Invoke-RestMethod -Uri "$($Global:VolumioServerURL)//api/v1/commands/?cmd=clearQueue"

    
}

function Get-VolumioPlaylist {
    param(
        $Name
    )

    Test-VolumioServerConnection

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

    Test-VolumioServerConnection

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
        [Parameter(Position=0,ValueFromPipeline=$TRUE,Mandatory=$true)][ValidateRange(1, 100)][int]$Volume
    )

    Test-VolumioServerConnection

    Invoke-VolumioCommand -Volume $Volume
}

