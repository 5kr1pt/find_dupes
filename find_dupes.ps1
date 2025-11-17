$path = 'G:\CAMINHO\DE\VERIFICACAO'

# Lista só arquivos locais (ignora placeholders offline do Google Drive)
$files = Get-ChildItem -LiteralPath $path -File -Recurse -Force -ErrorAction SilentlyContinue |
         Where-Object {
           -not ($_.Attributes -band [IO.FileAttributes]::Offline) -and
           $_.Name -ne 'desktop.ini'
         }

# Pré-filtra por tamanho repetido pra evitar hash desnecessário
$sameSize = $files | Group-Object Length | Where-Object { $_.Count -gt 1 }

# Calcula hash apenas nos grupos com mesmo tamanho
$hashed = foreach ($g in $sameSize) {
  foreach ($f in $g.Group) {
    try {
      $h = Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256 -ErrorAction Stop
      [pscustomobject]@{ Hash=$h.Hash; FullName=$f.FullName }
    } catch { }
  }
}

# Agrupa por hash e imprime só duplicados
$dupes = $hashed | Group-Object Hash | Where-Object { $_.Count -gt 1 }
if (-not $dupes) { "Sem duplicados." ; return }

foreach ($grp in $dupes) {
  "=== DUPLICADOS (Hash: {0}) ===" -f $grp.Name
  $grp.Group | Sort-Object FullName | ForEach-Object { $_.FullName }
  ""
}

