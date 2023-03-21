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

#New-BingoFile C:/users/urner/Desktop/GitHub/PowerShell-Bingo/Setup/foo 2MB

$Path = "C:/users/urner/Desktop/GitHub/PowerShell-Bingo/Setup/tmp/"

for ($i = 0; $i -lt 1000; $i++) {
    $FullPath = $Path + $i + ".mt"
    <# Action that will repeat until the condition is met #>
    New-BingoFile $FullPath 1KB
}
#Read-Host -Prompt "Press Enter to exit"