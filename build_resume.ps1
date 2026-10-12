$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

$tex = "Mikolaj Mieszko Charchuta Resume.tex"
if (-not (Test-Path -LiteralPath $tex)) {
  throw "Missing source file: $tex"
}

latexmk -xelatex -interaction=nonstopmode -file-line-error "$tex"
if ($LASTEXITCODE -ne 0) {
  throw "latexmk failed with exit code $LASTEXITCODE"
}

$basePdf = [System.IO.Path]::ChangeExtension($tex, '.pdf')
$date = (Get-Date).ToString('ddMMMyyyy', [System.Globalization.CultureInfo]::InvariantCulture)
$datedPdf = "Mikolaj Mieszko Charchuta Resume $date.pdf"

Copy-Item -LiteralPath $basePdf -Destination $datedPdf -Force

# Move outdated dated PDFs to archive
$archiveDir = Join-Path -Path $PSScriptRoot -ChildPath 'archive'
if (-not (Test-Path -PathType Container $archiveDir)) {
  New-Item -Path $archiveDir -ItemType Directory -Force | Out-Null
}

# Find and move dated resumes (files matching pattern: "Mikolaj Mieszko Charchuta Resume DD[A-Za-z][a-z][a-z]YYYY.pdf")
Get-ChildItem -Path $PSScriptRoot -Name "*.pdf" |
  Where-Object { $_ -match 'Mikolaj Mieszko Charchuta Resume \d{2}[A-Za-z]{3}\d{4}\.pdf$' } |
  Where-Object { $_ -ne $datedPdf } |
  ForEach-Object {
    $oldPdfPath = Join-Path -Path $PSScriptRoot -ChildPath $_
    Move-Item -LiteralPath $oldPdfPath -Destination (Join-Path -Path $archiveDir -ChildPath $_) -Force
    Write-Output "Archived: $_"
  }

Write-Output "Updated: $basePdf"
Write-Output "Updated: $datedPdf"
