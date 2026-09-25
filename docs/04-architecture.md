# TechQuest — Architecture

## Stack

- Flutter / Dart
- Supabase
- PostgreSQL
- Supabase Auth
- Supabase Realtime
- Supabase RPC / Edge Functions
- Firebase Cloud Messaging si les notifications push sont implémentées
- GitHub Actions

## Architecture Flutter

```text
Presentation
     ↓
Domain
     ↓
Data
     ↓
Supabase
````

### Presentation

Screens, widgets et gestion de l'état.

### Domain

Entities, use cases et contrats des repositories.

### Data

Models, data sources et implémentations des repositories.

## Règle

Les widgets ne doivent pas contenir de logique métier complexe ni de requêtes
Supabase dispersées.

Les opérations critiques utilisent une logique serveur.

## Opération critique : rejoindre un challenge

```text
Flutter
  ↓
Repository
  ↓
RPC join_challenge
  ↓
Supabase/PostgreSQL
```

La RPC vérifie notamment :

* authentification ;
* rôle étudiant ;
* pénalité ;
* challenge disponible ;
* participation existante ;
* groupe disponible ;
* capacité du groupe ;
* activation du groupe si complet.

L'opération doit être atomique.

## Realtime

Realtime sert à synchroniser l'interface.

Il ne remplace pas les règles métier.