# TechQuest

[![Flutter CI](https://github.com/DavFilsDev/tech-quest/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/DavFilsDev/tech-quest/actions/workflows/flutter_ci.yml)

TechQuest est une application mobile permettant aux étudiants en informatique
de participer à des challenges techniques proposés par des professeurs.

Les étudiants rejoignent automatiquement des groupes. Lorsqu'un groupe atteint
le nombre requis de membres, le challenge démarre et dispose d'une durée
limitée.

## Fonctionnalités

- Authentification
- Consultation des challenges
- Création de challenges par les professeurs
- Formation automatique des groupes
- Compte à rebours
- Validation ou échec d'un groupe
- Pénalité temporaire
- Historique des participations
- Gestion des rôles étudiant, professeur et administrateur

## Stack

- Flutter / Dart
- Supabase
- PostgreSQL
- Supabase Auth
- Supabase Realtime
- Supabase RPC
- GitHub Actions

## Documentation

La documentation du projet est organisée dans le dossier [`docs/`](docs/).

| Document | Description |
|---|---|
| [Project Contract](docs/01-project-contract.md) | Vision, périmètre du MVP et concepts principaux |
| [Business Rules](docs/02-business-rules.md) | Règles métier et comportements attendus |
| [Database](docs/03-database.md) | Structure de la base de données et relations |
| [Architecture](docs/04-architecture.md) | Architecture Flutter et communication avec Supabase |
| [Quality](docs/05-quality.md) | Qualité, sécurité, performance et accessibilité |
| [Certification](docs/06-certification.md) | Exigences et checklist de certification |
| [Roadmap](docs/07-roadmap.md) | Phases et progression du développement |

## Installation

### Prérequis

- Flutter
- Dart
- Git
- Un projet Supabase

### Installation

```bash
git clone https://github.com/DavFilsDev/tech-quest.git
cd tech-quest
flutter pub get
````

### Configuration

Configurer les variables d'environnement nécessaires à Supabase avant de
lancer l'application.

### Lancer l'application

```bash
flutter run
```

### Vérifications locales

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter test --coverage
```

## Tests

Le projet utilise :

* tests unitaires ;
* tests de widgets ;
* tests d'intégration.

La CI GitHub vérifie automatiquement le formatage, l'analyse statique, les
tests et la couverture.

## Développement

Les changements importants sont documentés dans
[`CHANGELOG.md`](CHANGELOG.md).

Le projet suit une approche progressive : les fonctionnalités du MVP sont
développées avant les fonctionnalités prévues pour les versions futures.

## Licence

Projet réalisé dans le cadre d'un projet de formation Flutter.