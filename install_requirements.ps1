<#
Script PowerShell pour créer un environnement virtuel et installer les dépendances
Usage (PowerShell) :
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
  .\install_requirements.ps1
#>

$venvDir = ".venv"
if (-not (Test-Path $venvDir)) {
    Write-Host "Création de l'environnement virtuel..."
    python -m venv $venvDir
} else {
    Write-Host "Environnement virtuel déjà présent : $venvDir"
}

Write-Host "Activation de l'environnement virtuel"
& "$PWD\$venvDir\Scripts\Activate.ps1"

Write-Host "Installation des dépendances depuis requirements.txt"
pip install --upgrade pip
pip install -r "$PWD\requirements.txt"

Write-Host "Terminé. Pour lancer les tests : .\$venvDir\Scripts\python.exe -m pytest -q tests/test_stable_marriage.py"
