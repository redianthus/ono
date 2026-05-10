# Rapport — Projet Ono

## Équipe

- Archie Beales — 22201677
- Mathéo Piget — 22200611
- Méril Leforestier — 22104824
- Valentin Regnault — 22510264
- Thibault Rolland — 22010976

## Vue d'ensemble

Ce projet implémente un interpréteur WebAssembly (concret et symbolique) en
OCaml, et utilise cet interpréteur pour faire tourner un Jeu de la Vie écrit
en Wasm avec deux modes de rendu : terminal et fenêtre graphique (Raylib).

## Ce qui a été réalisé

### Première partie — Interpréteur concret

- **Préliminaires** : modules Wasm `factorial`, `square_i64` (avec `print_i64`
  ajoutée côté OCaml), et `random_i32` avec une option `--seed` pour rendre
  les sorties reproductibles. Cram tests associés.
- **Interface textuelle** : primitives `sleep`, `print_cell`, `newline`,
  `clear_screen` exposées au Wasm. Jeu de la Vie complet en Wasm avec
  rendu terminal.
- **Extensions** : option `read_int` pour saisir des dimensions, options
  `--steps` et `--display-last`, format de fichier de configuration et
  option `--config FILE` pour charger une grille initiale.
- **Interface graphique** : version Raylib activable via le flag
  `--use-graphical-window`, partageant le même programme Wasm que le mode
  texte.

### Seconde partie — Interpréteur symbolique

- **Solveur de polynômes** de degré ≤ 3 avec lecture des coefficients sur
  l'entrée standard et énumération des racines entières.

### Tests

- Tests cram couvrant les principales commandes et options.
- Tests unitaires Alcotest pour les modules `Concrete_ono_text`,
  `Concrete_ono_module`, `Symbolic_ono_module`, `Config_parser`,
  `Cmd_concrete` et `Ono_cli`.
