function New-BingoFile {
    param (
        $name,
        $size,
        $create,
        $lastWrite,
        $lastAccess
    )

    # Touch file and set size.
    $f = New-Object System.IO.FileStream $name, Create, ReadWrite
    #$f.SetLength($size)
    $f.Close()

    # Set times
    #Get-ChildItem $name | % {
    #    $_.CreationTime = $create
    #    $_.LastWriteTime = $lastWrite
    #    $_.LastAccessTime = $lastAccess
    #}
}

New-BingoFile deleteMe, 3MB, '02/22/1953 00:00:42', '11/05/1953 03:14:16', '09/22/2001 10:30:53'