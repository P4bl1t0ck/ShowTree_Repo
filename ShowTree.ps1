param(
    [string]$Path = ".",
    [string]$Prefix = "",
    [int]$Level = 0,
    [int]$MaxDepth = 3   # 👈 Profundidad máxima configurable
)

# Obtener los elementos ordenados: primero carpetas, luego archivos
$items = Get-ChildItem -LiteralPath $Path | Sort-Object PSIsContainer, Name

foreach ($item in $items) {
    if ($item.PSIsContainer) {
        # Contar elementos dentro de la carpeta
        $count = (Get-ChildItem -LiteralPath $item.FullName | Measure-Object).Count
        Write-Host "$Prefix├── (Nivel $Level) 📁 $($item.Name) [$count elementos]"

        # Solo entrar si no hemos alcanzado la profundidad máxima
        if ($Level -lt $MaxDepth) {
            & $MyInvocation.MyCommand.Path -Path $item.FullName -Prefix ("$Prefix│   ") -Level ($Level + 1) -MaxDepth $MaxDepth
        }
    } else {
        Write-Host "$Prefix├── (Nivel $Level) 📄 $($item.Name)"
    }
}
# Mostrar el árbol de directorios con niveles y conteo de elementos
# Uso: .\ShowTree.ps1 -Path "C:\Ruta\A\Tu