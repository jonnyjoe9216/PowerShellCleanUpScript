#Script will be used to clean up temp directory to the target Servers

#Please Log all the script udpate below
#4/6/2023 - Created Script v.1.0 by Joe Marie Magbiro


#Load the Configuration
Foreach ($i in $(Get-Content '.\Config.conf')) {
    #Set Config to Variable with Define Value from Configuration File
    Set-Variable -Name $i.split("=")[0] -Value $i.split("=", 2)[1]
}

#File Extension Converting to Array
$FileExtension = @(get-content $FILESEXT)

#Exclude Files base on Days to Retain Config
$DateToBackUp = (get-date).AddDays($DAYSTORETAIN).Date

#Get File Directory from the lists
$FileDirectories = Get-Content -Path $FILEDIR

#Hash for Reporting
$Report = @()

$sumSize = 0

$ArrayFiles = Get-ChildItem $FileDirectories -Recurse | Where-Object { $_.Extension -ine $FileExtension -and $_.LastWriteTime -le $DateToBackUp } | Select-Object FullName, Length, LastWriteTime

foreach ($ArrayFile in $ArrayFiles) {
    
    Remove-Item $ArrayFile.FullName -Recurse -Force -Verbose
    
    #CreateReport
    $Report += [pscustomobject]@{
        FilePath            = $ArrayFile.FullName
        FileSizeInMegaBytes = $ArrayFile.Length / 1MB
        FileLastModified    = $ArrayFile.LastWriteTime
        Remarks             = "Deleted File"
        CleanUpDate         = Get-Date
    }
    
    
}

#Remove all empty Directory
$DIRToDel = Get-ChildItem $FileDirectories -Recurse -Force -Directory | Where-Object { $($_ | Get-ChildItem -Force | Select-Object -First 1).Count -eq 0 }

foreach ($DIR in $DIRToDel) {

    Remove-Item $DIR.FullName -Recurse -Verbose -Force

    #CreateReport
    $Report += [pscustomobject]@{
        FilePath            = $DIR.FullName
        FileSizeInMegaBytes = "0"
        FileLastModified    = $DIR.LastWriteTime
        Remarks             = "Deleted Empty Directory"
        CleanUpDate         = Get-Date
    }

}

#Generate Report
$Report | Export-Csv $OUTPUTDIR -Encoding UTF8

$Report.FileSizeInMegaBytes  | ForEach-Object { $sumSize += $_}

$TotalGB = $sumSize /1024

$FormattedGB = "{0:##.##}" -F $TotalGB

#Converting to String Array
[string[]]$cc = $CC.Split(',')

#Send Mail with the report attachment
Send-MailMessage -From "youremail@domain.com" -To $TO -Cc $cc -Subject $SUBJECT -Body "Total GB Cleaned Up: $FormattedGB GB" -Attachments $OUTPUTDIR -SmtpServer $SMTP
