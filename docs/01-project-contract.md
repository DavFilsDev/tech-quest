# TechQuest — Project Contract

## Vision

TechQuest est une application mobile permettant aux étudiants en informatique
de participer à des challenges techniques proposés par des professeurs.

Les étudiants rejoignent un challenge et sont automatiquement regroupés.
Lorsqu'un groupe est complet, son challenge démarre avec une durée limitée.

## MVP

Le MVP comprend :

- authentification ;
- consultation des challenges ;
- création de challenges par les professeurs ;
- inscription à un challenge ;
- formation automatique des groupes ;
- démarrage automatique d'un groupe complet ;
- compte à rebours ;
- validation ou échec d'un groupe ;
- pénalité temporaire ;
- historique ;
- gestion minimale professeur et administrateur.

## Concepts

### Challenge

Définition réutilisable d'un défi.

### Group

Instance d'un challenge réalisée par plusieurs étudiants.

Un challenge peut avoir plusieurs groupes.

## Statuts

Challenge :

`PUBLISHED → ARCHIVED`

Group :

`WAITING → ACTIVE → COMPLETED`

ou

`WAITING → ACTIVE → FAILED`

## Règle fondamentale

Le client Flutter affiche et orchestre l'interface.

Supabase/PostgreSQL reste la source de vérité pour les règles métier et les
données critiques.
