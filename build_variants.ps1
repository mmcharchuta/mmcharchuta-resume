# Builds every resume variant.
#
# PUBLIC sources live in this repository and their PDFs are committed:
#   "Mikolaj Mieszko Charchuta Resume.tex"  -> 1-page resume (repo root)
#   variants/resume-2page.tex               -> 2-page resume
#   variants/cv-full.tex                    -> full multi-page CV
#
# PRIVATE sources live OUTSIDE this repository, by default in a sibling
# folder ../resume-private/. Per-application resumes, cover letters and the
# profile photo belong there and can never be committed, because git cannot
# see files outside its working tree.
#
#   ../resume-private/
#     assets/profile-photo.jpg
#     applications/<company>/resume-1page.tex, resume-2page.tex, cv-full.tex
#     output/<company>/...
#
# Anything built WITH the profile photo is written to the private output
# folder, never into this repository.
#
# Usage:
#   .\build_variants.ps1                      # public PDFs + all private targets
#   .\build_variants.ps1 -Scope public        # only the committed public PDFs
#   .\build_variants.ps1 -Scope private       # only per-application material
#   .build_variants.ps1 -Target <company>    # one private target
#   .\build_variants.ps1 -WithPhoto           # also build photo versions

param(
  [ValidateSet('all','public','private')]
  [string]$Scope = 'all',
  [string]$Target = '',
  [switch]$WithPhoto,
  [string]$PrivateRoot = '',
  [string]$MiktexBin = ''
)

$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

# --- Pick a working LaTeX toolchain ---------------------------------------
# A half-finished MiKTeX update can leave latexmk.exe on PATH while its
# matching DLLs are gone, so probe candidates and use the first that runs.
function Test-Latexmk([string]$dir) {
  $exe = if ($dir -eq '') { 'latexmk' } else { Join-Path $dir 'latexmk.exe' }
  if ($dir -ne '' -and -not (Test-Path -LiteralPath $exe)) { return $false }
  if ($dir -eq '' -and -not (Get-Command latexmk -ErrorAction SilentlyContinue)) { return $false }
  # MiKTeX writes update warnings to stderr; do not redirect, and do not let
  # them surface as terminating errors.
  $prev = $ErrorActionPreference
  $ErrorActionPreference = 'Continue'
  try {
    & $exe -v | Out-Null
    $ok = ($LASTEXITCODE -eq 0)
  } catch { $ok = $false }
  $ErrorActionPreference = $prev
  return $ok
}

$candidates = @()
if ($MiktexBin -ne '') { $candidates += $MiktexBin }
$candidates += ''                                                            # whatever is on PATH
$candidates += "$env:LOCALAPPDATA\Programs\MiKTeX\miktex\bin\x64"
$candidates += "$env:ProgramFiles\MiKTeX\miktex\bin\x64"

$chosen = $null
foreach ($c in $candidates) {
  if (Test-Latexmk $c) { $chosen = $c; break }
}
if ($null -eq $chosen) {
  throw "No working latexmk found. Tried: $(($candidates | ForEach-Object { if ($_ -eq '') {'<PATH>'} else {$_} }) -join '; ')"
}
if ($chosen -ne '') { $env:PATH = "$chosen;$env:PATH" }
Write-Output "Using latexmk: $((Get-Command latexmk).Source)"

if ($PrivateRoot -eq '') {
  $PrivateRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'resume-private'
}
# Profile photo: prefer the copy published in this repo, fall back to the
# private folder for anyone who keeps it out of version control.
$photo = Join-Path $PSScriptRoot 'assets/profile-photo.jpg'
if (-not (Test-Path -LiteralPath $photo)) {
  $photo = Join-Path $PrivateRoot 'assets/profile-photo.jpg'
}
$photoTeX = ($photo -replace '\\', '/')

# --- Guard: never let private paths resolve inside the repository ----------
$repoFull = [System.IO.Path]::GetFullPath($PSScriptRoot)
$privFull = [System.IO.Path]::GetFullPath($PrivateRoot)
if ($privFull.StartsWith($repoFull, [StringComparison]::OrdinalIgnoreCase)) {
  throw "PrivateRoot must be OUTSIDE the repository. Got: $privFull"
}

# --- Build queue -----------------------------------------------------------
# Each job: Source, Out (destination folder), Name (pdf base name), Photo
$jobs = @()

if ($Scope -in @('all','public')) {
  # PhotoName is the base name used for the version that includes the photo.
  # All photo versions live in variants/ so the repo root stays tidy.
  $publicSet = @(
    @{ Source = 'Mikolaj Mieszko Charchuta Resume.tex'; Out = '.';        Name = 'Mikolaj Mieszko Charchuta Resume'; PhotoName = 'Charchuta_Mikolaj_Resume_1page_photo' },
    @{ Source = 'variants/resume-2page.tex';            Out = 'variants'; Name = 'Charchuta_Mikolaj_Resume_2page';   PhotoName = 'Charchuta_Mikolaj_Resume_2page_photo' },
    @{ Source = 'variants/cv-full.tex';                 Out = 'variants'; Name = 'Charchuta_Mikolaj_CV_full';        PhotoName = 'Charchuta_Mikolaj_CV_full_photo' }
  )
  foreach ($p in $publicSet) {
    if (-not (Test-Path -LiteralPath $p.Source)) { continue }
    # Public PDFs are committed, so they are always built without the photo.
    $jobs += [pscustomobject]@{ Source = $p.Source; Out = $p.Out; Name = $p.Name; Photo = $false; Build = "build/public" }
    if ($WithPhoto) {
      $jobs += [pscustomobject]@{ Source = $p.Source; Out = 'variants'; Name = $p.PhotoName; Photo = $true; Build = "build/public" }
    }
  }
}

if ($Scope -in @('all','private')) {
  $appDir = Join-Path $PrivateRoot 'applications'
  if (Test-Path -LiteralPath $appDir) {
    Get-ChildItem -LiteralPath $appDir -Directory |
      Where-Object { $Target -eq '' -or $_.Name -eq $Target } |
      ForEach-Object {
        $t = $_.Name
        Get-ChildItem -LiteralPath $_.FullName -Filter '*.tex' | ForEach-Object {
          $variant = $_.BaseName -replace '^(resume|cv)-', ''
          $outDir = Join-Path $PrivateRoot "output/$t"
          $buildDir = Join-Path $PrivateRoot "build/$t"
          $jobs += [pscustomobject]@{ Source = $_.FullName; Out = $outDir; Name = "Charchuta_Mikolaj_${t}_$variant"; Photo = $false; Build = $buildDir }
          if ($WithPhoto) {
            $jobs += [pscustomobject]@{ Source = $_.FullName; Out = $outDir; Name = "Charchuta_Mikolaj_${t}_${variant}_photo"; Photo = $true; Build = $buildDir }
          }
        }
      }
  } elseif ($Scope -eq 'private') {
    throw "No private sources found at $appDir"
  }
}

if ($jobs.Count -eq 0) { throw "Nothing to build for scope '$Scope' target '$Target'" }

# --- Compile ---------------------------------------------------------------
$built = @()
foreach ($job in $jobs) {
  if ($job.Photo -and -not (Test-Path -LiteralPath $photo)) {
    Write-Warning "Skipping $($job.Name): photo not found at $photo"
    continue
  }
  New-Item -ItemType Directory -Force -Path $job.Build, $job.Out | Out-Null

  $pretex = if ($job.Photo) { "\def\withphoto{}\def\photofile{$photoTeX}" } else { '\relax' }

  # MiKTeX writes harmless warnings to stderr; PowerShell 5.1 would treat
  # them as terminating errors under 'Stop', so relax it for this call.
  $ErrorActionPreference = 'Continue'
  latexmk -xelatex -interaction=nonstopmode -file-line-error -halt-on-error `
    "-jobname=$($job.Name)" "-outdir=$($job.Build)" "-usepretex=$pretex" $job.Source 2>&1 | Out-Null
  $code = $LASTEXITCODE
  $ErrorActionPreference = 'Stop'
  if ($code -ne 0) { throw "latexmk failed for $($job.Name) (see $($job.Build)/$($job.Name).log)" }

  $dest = Join-Path $job.Out "$($job.Name).pdf"
  Copy-Item -LiteralPath (Join-Path $job.Build "$($job.Name).pdf") -Destination $dest -Force
  $built += $dest
}

$built | ForEach-Object { Write-Output "Built: $_" }
