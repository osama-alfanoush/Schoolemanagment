# Generates one WAV per narration line using the offline Arabic voice
# (Microsoft Naayf). The OneCore voices are not visible to System.Speech, so we
# reach them through SAPI's token category instead.
param(
  [Parameter(Mandatory = $true)][string]$LinesJson,
  [Parameter(Mandatory = $true)][string]$OutDir,
  [int]$Rate = 0
)

$ErrorActionPreference = "Stop"
if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir -Force | Out-Null }

$lines = Get-Content -Raw -Encoding UTF8 $LinesJson | ConvertFrom-Json

$voice = New-Object -ComObject SAPI.SpVoice
$cat = New-Object -ComObject SAPI.SpObjectTokenCategory
$cat.SetId("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Speech_OneCore\Voices", $false)

$arabic = $null
foreach ($token in $cat.EnumerateTokens()) {
  if ($token.GetDescription() -match 'Arabic') { $arabic = $token; break }
}
if ($null -eq $arabic) { throw "No Arabic voice installed" }

$voice.Voice = $arabic
$voice.Rate = $Rate

$made = 0
foreach ($line in $lines) {
  $path = Join-Path $OutDir "$($line.id).wav"
  if (Test-Path $path) { Remove-Item $path -Force }

  $stream = New-Object -ComObject SAPI.SpFileStream
  $stream.Format.Type = 39            # 48 kHz, 16-bit, stereo
  $stream.Open($path, 3, $false)
  $voice.AudioOutputStream = $stream
  $voice.Speak($line.text, 0) | Out-Null
  $stream.Close()
  $made++
}

"generated $made clip(s) in $OutDir"
