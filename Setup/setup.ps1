function New-BingoFile {
    param (
        [string] $FileName,
        $FileLength
    )

    # Create file.
    $f = New-Object System.IO.FileStream $FileName, Create, ReadWrite
    $f.SetLength($FileLength)
    $f.Close()
    
    # Get reference to file and set times.
    $f = Get-ChildItem($FileName)
    $create = New-RandomDate "1921-09-01"
    $write = New-RandomDate $create
    $access = New-RandomDate $write
    $f.CreationTime = $create
    $f.LastWriteTime = $write
    $f.LastAccessTime = $access 
}

function New-RandomDate {
    param (
        [string] $Seed
    )

    $LeftHyphen = $Seed.IndexOf('-')
    $RightHyphen = $Seed.LastIndexOf('-')

    $MinYear = $Seed.Substring(0, $LeftHyphen)
    $MinMonth = $Seed.Substring($LeftHyphen + 1, $RightHyphen - $LeftHyphen - 1)
    $MinDay = $Seed.Substring($RightHyphen + 1)

    $MaxYear = 2023

    $year = Get-Random -Minimum $MinYear -Maximum $MaxYear
    $month = Get-Random -Minimum $MinMonth -Maximum 12
    $day = Get-Random -Minimum $MinDay -Maximum 28

    return $year.ToString() + "-" + $month.ToString() + "-" + $day.ToString()
}

# Write-Host (New-RandomDate 1921-09-01) ; Read-Host -Prompt "Press Enter to continue"

if ($IsMacOS)
{
    Write-Host "Setting up for macOS."
    $Path = "$HOME/Source/GitHub/"
} elseif ($IsWindows) {
    Write-Host "Setting up for Windows."
    $Path = "$HOME/Desktop/GitHub/"
} else {
    Write-Warning "OS not detected, assuming Windows..."
    $Path = "$HOME/Desktop/GitHub/"
}
$Path = $Path + "PowerShell-Bingo/Setup/tmp/"

Write-Host $Path ; Read-Host -Prompt "Press Enter to continue"

if (!(test-path -PathType container $Path))
{
      New-Item -ItemType Directory -Path $Path
}

$DirMin  = 8
$Dir1Max = 64
$Dir2Max = 32
$FileMax = 512

for ($i = 0; $i -lt (Get-Random -Minimum $DirMin -Maximum $Dir1Max); $i++) {
    $Dir1 = $Path + "/" + $i
    if (!(test-path -PathType container $Dir1))
    {
        New-Item -ItemType Directory -Path $Dir1
    }
    for ($j = 0; $j -lt (Get-Random -Minimum $DirMin -Maximum $Dir2Max); $j++) {
        $Dir2 = $Dir1 + "/" + $j
        if (!(test-path -PathType container $Dir2))
        {
            New-Item -ItemType Directory -Path $Dir2
        }
        for ($k = 0; $k -lt (Get-Random -Maximum $FileMax); $k++) {
            $FullPath = $Dir2 + "/" + $k + ".mt"
            New-BingoFile $FullPath (Get-Random -Maximum 32768)
        }
    }
}

Write-Host ( Get-ChildItem -recurse $Path | Measure-Object ).Count

#Read-Host -Prompt "Press Enter to exit"