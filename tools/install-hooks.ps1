# Installs the repository's git hooks into .git/hooks.
# Hooks are not distributed by git clone, so run this once per clone.

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
Set-Location $repo

$hookDir = Join-Path $repo '.git/hooks'
if (-not (Test-Path -PathType Container $hookDir)) {
  throw "Not a git repository: $hookDir not found"
}

foreach ($hook in @('pre-commit')) {
  $src = Join-Path $PSScriptRoot $hook
  if (-not (Test-Path -LiteralPath $src)) { continue }
  $dest = Join-Path $hookDir $hook
  # Write with LF endings and no BOM so the shell can run it.
  $text = (Get-Content -LiteralPath $src -Raw) -replace "`r`n", "`n"
  [System.IO.File]::WriteAllText($dest, $text, (New-Object System.Text.UTF8Encoding $false))
  Write-Output "Installed hook: $hook"
}

Write-Output "Done. Test it with:  git commit --allow-empty -m test"
