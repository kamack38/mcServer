$response = Invoke-RestMethod -Uri "http://localhost:4040/api/tunnels" -Method 'Get'
$ip = $response.tunnels.public_url
$ip = $ip.substring(6) 

$hookUrl = (Get-Content .\token.env | Select-Object -first 1)
$time = get-date -UFormat "%Y-%m-%dT%T"

$authorObject = [PSCustomObject]@{
    name = 'Server'
    url = 'https://github.com/kamack38'
    icon_url = 'https://upload.wikimedia.org/wikipedia/commons/0/01/Windows_Terminal_Logo_256x256.png'
}

$footerObject = [PSCustomObject]@{
    text = 'By kamack38'
    icon_url = 'https://i.imgur.com/rbxQ6dD.png'
}

$imageObject = [PSCustomObject]@{
    url = 'https://store-images.s-microsoft.com/image/apps.608.13510798887677013.5c7792f0-b887-4250-8c4e-4617af9c4509.bcd1385a-ad15-450c-9ddd-3ee80c37121a?mode=scale&q=90&h=1080&w=1920'
}

$embedObject = [PSCustomObject]@{
    title = 'Serwer został włączony 🟢'
    description = "Serwer został włączony. **Połącz** się z nim już teraz:
    ``$ip``"
    color = '1092143'
    author = $authorObject

    footer = $footerObject

    timestamp = $time
    image = $imageObject
}

[System.Collections.ArrayList]$embedArray = @()
$embedArray.Add($embedObject)

$payload = [PSCustomObject]@{
    embeds = $embedArray
}

Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json -Depth 4) -ContentType 'application/json; charset=utf-16'
Write-Host "Start Message Sent" -Foreground Green 

java -Xmx4096M -Xms4096M -jar purpur.jar nogui

$time = get-date -UFormat "%Y-%m-%dT%T"

$embedObject = [PSCustomObject]@{
    title = 'Serwer wyłączony 🔴'
    description = "Serwer o IP: ``$ip`` został wyłączony.
    Zapraszamy ponownie później"
    color = '15413831'
    author = $authorObject

    footer = $footerObject

    timestamp = $time
    image = $imageObject
}

[System.Collections.ArrayList]$embedArray = @()
$embedArray.Add($embedObject)

$payload = [PSCustomObject]@{
    embeds = $embedArray
}

Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json -Depth 4) -ContentType 'application/json; charset=utf-16'
Write-Host "Stop Message Sent" -Foreground Red 