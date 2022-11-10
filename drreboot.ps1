##############
# Dr. Reboot v1.0 by Gary Howard
# Prereq: PWSH 5.x or later, HPEilocmdlets module, ilo.csv file
# Purpose: To Reset the iLO MGNT plane or reboot the physical host
# Updates: none 
##############

#Import and load the iLO cmdlets module
Import-Module -name HPEiLOCmdlets

Write-Host "
_____         _____      _                 _   
|  __ \       |  __ \    | |               | |  
| |  | |_ __  | |__) |___| |__   ___   ___ | |_ 
| |  | | '__| |  _  // _ \ '_ \ / _ \ / _ \| __|
| |__| | |_   | | \ \  __/ |_) | (_) | (_) | |_ 
|_____/|_(_)  |_|  \_\___|_.__/ \___/ \___/ \__|

                       By Gary Howard

"
#Ask User for iLO Creds
Write-Host "Please Provide iLO Credentials that will be used to access the iLO(s)"
$Creds = Get-Credential -Message "Enter iLO Username and Password"

#Ask user for CSV file and stores it in an Array
$filepath = Read-Host "Please provide the full path of the CSV file ex C:\Users"
$Hostname=@()
Import-Csv $filepath | ForEach-Object{
    $Hostname += $_.hostname
}

#Connection String for connecting to iLO 
$connection = Connect-HPEilo -IP $Hostname -Credential $Creds -DisableCertificateAuthentication

$choice = Read-Host "Please Select a Choice 1-Reset iLO 2-Reboot Server 3-Power Off Server"

switch ($choice) {
    1 { Reset-HPEiLO -Connection $connection -Device iLO }
    2 { Write-Host "Feature coming soon" }
    3 { Write-Host "Feature coming soon"}
    Default {Write-Host "Program Completed" -ForegroundColor Green }
}

Write-Host "Program Completed" -ForegroundColor Green
