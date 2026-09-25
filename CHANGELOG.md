# Changelog

Toutes les modifications importantes de TechQuest sont documentées dans ce
fichier.

Le format utilisé suit une structure inspirée de
[Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Added

- Fondation Supabase/PostgreSQL et configuration de la CLI.
- Migrations de base de données pour les six tables métier.
- Schéma, relations, contraintes, index et triggers (mise à jour et
  création de profil).
- Baseline RLS pour la lecture de son profil et de ses notifications.
- Validation des migrations avec `supabase db reset` localement et avec
  `supabase db push` sur le projet Cloud.

## [0.1.0] - 2026-09-25

### Added

- Initialisation du projet Flutter.
- Mise en place de la structure du repository.
- Ajout de la documentation du projet dans `docs/`.
- Ajout de la configuration GitHub Actions.
- Mise en place des checks CI :
  - Format
  - Analyze
  - Tests
  - Coverage
- Ajout du README du projet.
- Ajout du CHANGELOG.
