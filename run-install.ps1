param([String]$pMSIPath, [String]$pDestinationPath, [String]$pLogPath="C:\msi-last-auto-install-log.log")
# Vérifier si la variable $pMSIPath commence par "http"
if ($pMSIPath.StartsWith("http")) {
  # Gérer les exceptions
  try {
    # Télécharger le fichier $pMSIPath
    $fileName = [System.IO.Path]::GetFileName($pMSIPath)
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($pMSIPath, $fileName)
  }
  catch {
    # S'arrêter en cas d'exception
    Write-Host "Le téléchargement du fichier à échoué."
    Exit
  }
}
else {
    $fileName = $pMSIPath
}
# Lancer l'installer
$arguments = "/i `"$fileName`" /quiet /qn /norestart /log `"$pLogPath`" INSTALLDIR=`"$pDestinationPath`" INSTALLFOLDER=`"$pDestinationPath`""
Start-Process msiexec.exe -ArgumentList $arguments -Wait

# Notification de fin
Write-Host "L'intallation est terminé avec succès."