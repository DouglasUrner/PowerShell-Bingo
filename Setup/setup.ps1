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
    $f.CreationTime = "1953-10-30"
}

if ($IsMacOS)
{
    $Path = "$HOME/Source/GitHub/"
} elseif ($IsWindows) {
    $Path = "C:/users/urner/Desktop/GitHub/"
}
$Path = $Path + "PowerShell-Bingo/Setup/tmp/"

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