#Requires -Modules Pester
Import-Module (Join-Path $PSScriptRoot "Volumio.psd1") -Force    

Describe 'Test Connect-VolumioServer' {
    It 'Check Connection' {
        {Connect-VolumioServer -ServerURL 'http://volumio.local'} | Should -Not -Throw
     
    }
}

Describe 'Test Invoke-VolumioCommand'{
    It 'Invoke-VolumioCommand -Play' {
        {Invoke-VolumioCommand -Play} | Should -Not -Throw
    }

    It 'Invoke-VolumioCommand -TogglePlay' {
        {Invoke-VolumioCommand -TogglePlay} | Should -Not -Throw
    }

    It 'Invoke-VolumioCommand -Stop' {
        {Invoke-VolumioCommand -Stop} | Should -Not -Throw
    }

    It 'Invoke-VolumioCommand -Pause' {
        {Invoke-VolumioCommand -Pause} | Should -Not -Throw
    }

    It 'Invoke-VolumioCommand -Next' {
        {Invoke-VolumioCommand -Next} | Should -Not -Throw
    }

    It 'Invoke-VolumioCommand -Volume 50' {
        {Invoke-VolumioCommand -Volume 50} | Should -Not -Throw
        {Invoke-VolumioCommand -Volume 10} | Should -Not -Throw
    }
}

Describe 'Test Get-VolumioStats' {
    It 'Get-VolumioStates' {
        {Get-VolumioStats} | Should -Not -Throw
    }

    It 'Get-VolumioStates -Collection' {
        {Get-VolumioStats -Collection} | Should -Not -Throw
    }
}

Describe 'Test Get-VolumioQueue' {
    It 'Get-VolumioQueue' {
        {Get-VolumioQueue} | Should -Not -Throw
    }
}

Describe 'Test Get-VolumioPlaylist' {
    It 'Get-VolumioPlaylist' {
        {Get-VolumioPlaylist} | Should -Not -Throw
    }

    It 'Get-VolumioPlaylist -Name' {
        {Get-VolumioPlaylist -Name 'MyPL2'| Play-VolumioPlaylist} | Should -Not -Throw
    }
}

Describe 'Test Set-VolumioVolume' {
    It 'Set-VolumioVolume -Volume 1' {
        {Set-VolumioVolume -Volume 1} | Should -Not -Throw
    }

    It 'Set-VolumioVolume -Volume 100' {
        {Set-VolumioVolume -Volume 100} | Should -Not -Throw
    }
}

