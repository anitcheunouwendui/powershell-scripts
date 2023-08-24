param([String]$pMSIPath, [String]$pDestinationPath, [String]$pLogPath="C:\msi-last-auto-install-log.log")
# Vérifier si la variable $pMSIPath commence par "http"
if ($pMSIPath.StartsWith("http")) {
  # Télécharger le fichier $pMSIPath
  $fileName = [System.IO.Path]::GetFileName($pMSIPath)
  $webClient = New-Object System.Net.WebClient
  $webClient.DownloadFile($pMSIPath, $fileName)

  # Exécuter le fichier msi téléchargé
  Start-Process -FilePath $fileName
}
else {
    $fileName = $pMSIPath
}
$arguments = "/i `"$fileName`" /quiet /qn /norestart /log `"$pLogPath`" INSTALLDIR=`"$pDestinationPath`" INSTALLFOLDER=`"$pDestinationPath`""
Start-Process msiexec.exe -ArgumentList $arguments -Wait