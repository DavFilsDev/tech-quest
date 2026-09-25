# TechQuest — Business Rules

## Étudiants

- Un étudiant doit être authentifié pour rejoindre un challenge.
- Un étudiant ne peut rejoindre qu'une seule fois un même challenge.
- Un étudiant pénalisé ne peut pas rejoindre de nouveau challenge pendant
  sa période de pénalité.
- Un étudiant peut refaire un challenge déjà terminé.

## Groupes

- Les groupes sont créés automatiquement.
- Un étudiant ne choisit pas son groupe.
- Un groupe WAITING accepte de nouveaux membres.
- Lorsqu'un groupe atteint `required_members`, il devient ACTIVE.
- Lorsqu'il devient ACTIVE, sa composition est verrouillée.
- Chaque groupe possède son propre `started_at` et `deadline`.

## Temps

Le chronomètre commence uniquement lorsque le groupe devient ACTIVE.

`deadline = started_at + durée du challenge`

Si la deadline est dépassée alors que le groupe est ACTIVE, il devient FAILED.

## Validation

Le professeur propriétaire du challenge peut marquer un groupe ACTIVE comme
COMPLETED.

Un groupe COMPLETED ou FAILED ne peut plus être modifié par les étudiants.

## Sécurité métier

Les règles critiques ne doivent jamais dépendre uniquement du client Flutter.

Elles doivent être vérifiées côté Supabase/PostgreSQL.