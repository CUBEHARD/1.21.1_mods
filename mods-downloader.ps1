# File with links
$linksFile = "links.txt"
$successCount = 0
$totalCount = 0

# Reading links from the source file
Get-Content $linksFile | ForEach-Object {
    $line = $_
    $totalCount++

    # Getting URL from line
    if ($line -match '"(.*?)"') {
        $url = $matches[1]
        $fileName = [System.IO.Path]::GetFileName($url)

        # Downloading file using Invoke-WebRequest
        try {
            Invoke-WebRequest -Uri $url -OutFile $fileName
            Write-Host "Downloaded: $fileName"
            $successCount++
        } catch {
            Write-Host "An error occurred during downloading: $fileName"
        }
    }
}

# Printing status after downloading sequence
Write-Host "Successfully downloaded $successCount out of $totalCount files."
