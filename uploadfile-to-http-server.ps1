$uri = "http://10.1.102.114:8009/api/upload/db"
$pwd = ConvertTo-SecureString 'MyPassword' -AsPlainText -Force
$cred = New-Object Management.Automation.PSCredential ('myuser', $pwd)
$contentType = "multipart/form-data"
$body = @{
    "file" = Get-Content($uploadPath) -Raw
}
Invoke-RestMethod -Uri $uri -Method Post -InFile $uploadPath -UseDefaultCredentials