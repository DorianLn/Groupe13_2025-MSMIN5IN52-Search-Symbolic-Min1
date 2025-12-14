# Projet : Recherche Symbolique — Stable Marriage et Wordle

Ce dépôt contient des travaux de groupe sur le problème du mariage stable (Stable Marriage) et un solveur Wordle.

## Aperçu rapide
- `stable_marriage_analysis.ipynb` : notebook principal — implémentation Gale–Shapley, modèle CSP (OR-Tools), validation, benchmark et visualisations. Le notebook a été mis à jour pour :
  - réparer la génération d'instances (`generate_preferences`),
  - proposer une version itérative "lazy" du solveur CSP (`solve_stable_marriage_csp`) qui ajoute des forbidden-assignments seulement pour les paires bloquantes observées,
  - fournir un benchmark adaptatif (paramétrable : `csp_time_limit`, `csp_num_workers`, `csp_max_iterations`).

- `tests/test_stable_marriage.py` : test léger qui importe le notebook, vérifie la présence des fonctions clefs et compare le résultat CSP vs Gale–Shapley sur une instance réduite. Le test peut être automatiquement ignoré (skip) si le solveur CSP ne trouve pas de solution dans le temps imparti.

- `install_requirements.ps1` : script PowerShell d'installation (create/activate `.venv`, `pip install -r requirements.txt`).

Les autres dossiers contiennent le projet Wordle et la suite de tests.

## Exécution recommandée (Windows)

1) Créer et activer un environnement virtuel (PowerShell) :

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
```

2) Installer les dépendances globales :

```powershell
pip install -r requirements.txt
```

Remarque : `requirements.txt` inclut `ortools` et bibliothèques de visualisation. L'installation peut prendre du temps.

3) Ouvrir `stable_marriage_analysis.ipynb` (VS Code ou Jupyter) et exécuter les cellules dans l'ordre. Le notebook contient :
   - une cellule d'installation automatique (utilise `requirements.txt` si présent),
   - la fonction `solve_stable_marriage_csp` avec paramètres ajustables (voir la cellule du benchmark).

Exemple (dans la cellule benchmark) :

```python
# Exemple d'appel paramétré depuis la cellule de benchmark
times_gs, times_csp = benchmark_algorithms([10,50,100], num_trials=2,
                                          csp_time_limit=180.0,
                                          csp_num_workers=4,
                                          csp_max_iterations=20)
```

## `install_requirements.ps1`

Le script `install_requirements.ps1` automatise la création d'un `.venv` et l'installation de `requirements.txt`.
Usage (PowerShell) :

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\install_requirements.ps1
```

Notes:
- Sur certaines machines, l'installation d'`ortools` peut nécessiter une connexion internet stable et prendra du temps.
- Si vous préférez, installez manuellement les paquets essentiels (`ortools`, `numpy`, `matplotlib`, `networkx`, `seaborn`, `nbformat`, `pytest`).

## Tests (`tests/test_stable_marriage.py`)

Le test :
- importe et exécute les cellules du notebook pour charger les définitions (`generate_preferences`, `gale_shapley`, `solve_stable_marriage_csp`, `is_stable`),
- crée une petite instance (n=5),
- vérifie que `gale_shapley` retourne une solution stable,
- tente d'exécuter `solve_stable_marriage_csp` avec `time_limit=5.0` (paramétré pour garder le test rapide) ; si le solveur échoue/timeout, le test est `skip`.

Pour exécuter les tests :

```powershell
.venv\Scripts\python.exe -m pytest -q tests/test_stable_marriage.py
```

Conseil : si votre machine est lente ou si OR-Tools met du temps, éditez temporairement `tests/test_stable_marriage.py` pour augmenter le `time_limit` passé à `solve_stable_marriage_csp` (par ex. `time_limit=30.0`). Le test est conçu pour être tolérant et skip si le solveur ne répond pas.
