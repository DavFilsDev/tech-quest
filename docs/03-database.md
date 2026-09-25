# TechQuest — Database Contract

## État actuel

Le schéma décrit dans ce document est celui créé par les quatre migrations
versionnées de `supabase/migrations/`. Il a été appliqué sur la base Supabase
locale puis sur le projet Cloud. Les migrations restent la source de vérité.

Les six tables métier actuelles sont :

- `public.users`
- `public.challenges`
- `public.groups`
- `public.group_members`
- `public.penalties`
- `public.notifications`

L'email est géré par `auth.users`. Il n'existe pas de colonne `email` dans
`public.users`.

## Tables

### public.users

- `id uuid` — clé primaire, référence `auth.users.id`, `ON DELETE CASCADE`
- `full_name text` — nullable
- `role text` — non null, valeur par défaut `STUDENT`
- `avatar_url text` — nullable
- `created_at timestamptz` — non null, `now()` par défaut
- `updated_at timestamptz` — non null, `now()` par défaut
- `deleted_at timestamptz` — nullable

Contrainte de rôle :

```text
role IN ('STUDENT', 'PROFESSOR', 'ADMIN')
```

### public.challenges

- `id uuid` — clé primaire, `gen_random_uuid()` par défaut
- `professor_id uuid` — non null, référence `public.users.id`, `ON DELETE RESTRICT`
- `title text` — non null
- `description text` — non null
- `required_members integer` — non null, supérieur à zéro
- `duration_days integer` — non null, supérieur à zéro
- `deliverable text` — non null
- `validation_criteria text` — non null
- `status text` — non null, `PUBLISHED` par défaut
- `created_at timestamptz` — non null, `now()` par défaut
- `updated_at timestamptz` — non null, `now()` par défaut

Contraintes :

- `required_members > 0`
- `duration_days > 0`
- `title` non vide après `btrim`
- `status IN ('PUBLISHED', 'ARCHIVED')`

### public.groups

- `id uuid` — clé primaire, `gen_random_uuid()` par défaut
- `challenge_id uuid` — non null, référence `public.challenges.id`, `ON DELETE RESTRICT`
- `status text` — non null, `WAITING` par défaut
- `started_at timestamptz` — nullable
- `deadline timestamptz` — nullable
- `created_at timestamptz` — non null, `now()` par défaut
- `updated_at timestamptz` — non null, `now()` par défaut

```text
WAITING | ACTIVE | COMPLETED | FAILED
```

La contrainte `groups_status_dates_check` impose :

- `WAITING` : `started_at` et `deadline` nuls ;
- `ACTIVE`, `COMPLETED` ou `FAILED` : `started_at` et `deadline` non nuls ;
- `deadline > started_at`.

### public.group_members

- `group_id uuid` — non null, référence `public.groups.id`, `ON DELETE RESTRICT`
- `user_id uuid` — non null, référence `public.users.id`, `ON DELETE RESTRICT`
- `joined_at timestamptz` — non null, `now()` par défaut

Clé primaire composite :

```text
(group_id, user_id)
```

Cette table ne contient pas de colonne `challenge_id` et n'impose pas de
contrainte globale `(user_id, challenge_id)`. Elle représente l'appartenance
d'un utilisateur à un groupe ; il n'existe pas de table `participations` ou
`attempts`.

### public.penalties

- `id uuid` — clé primaire, `gen_random_uuid()` par défaut
- `user_id uuid` — non null, référence `public.users.id`, `ON DELETE CASCADE`
- `penalty_until timestamptz` — non null
- `reason text` — non null
- `created_at timestamptz` — non null, `now()` par défaut

Contrainte :

```text
penalty_until > created_at
```

Les pénalités peuvent se chevaucher. Leur effet métier sera vérifié côté
serveur lors des opérations de join.

### public.notifications

- `id uuid` — clé primaire, `gen_random_uuid()` par défaut
- `user_id uuid` — non null, référence `public.users.id`, `ON DELETE CASCADE`
- `type text` — non null et non vide
- `title text` — non null
- `body text` — non null
- `read_at timestamptz` — nullable
- `created_at timestamptz` — non null, `now()` par défaut

## Relations

```text
auth.users 1 ─── 1 public.users
public.users 1 ─── N public.challenges
public.challenges 1 ─── N public.groups
public.groups 1 ─── N public.group_members
public.users 1 ─── N public.group_members
public.users 1 ─── N public.penalties
public.users 1 ─── N public.notifications
```

## Index

Index métier actuels :

- `challenges_professor_status_created_idx` sur `professor_id`, `status`,
  `created_at DESC`
- `challenges_published_created_idx` sur `created_at DESC` où
  `status = 'PUBLISHED'`
- `groups_challenge_status_idx` sur `challenge_id`, `status`
- `groups_active_deadline_idx` sur `deadline` où `status = 'ACTIVE'`
- `group_members_user_group_idx` sur `user_id`, `group_id`
- `penalties_user_until_idx` sur `user_id`, `penalty_until DESC`
- `notifications_user_created_idx` sur `user_id`, `created_at DESC`
- `notifications_user_unread_idx` sur `user_id`, `created_at DESC` où
  `read_at IS NULL`

Les clés primaires créent également leurs index uniques implicites.

## Triggers et fonctions

- `public.set_updated_at()` met `updated_at` à `now()` avant chaque mise à jour.
- `users_set_updated_at` est déclenché avant `UPDATE` sur `public.users`.
- `challenges_set_updated_at` est déclenché avant `UPDATE` sur
  `public.challenges`.
- `groups_set_updated_at` est déclenché avant `UPDATE` sur `public.groups`.
- `public.handle_new_user()` crée un profil dans `public.users` après chaque
  insertion dans `auth.users`.
- `on_auth_user_created` est déclenché après `INSERT` sur `auth.users`.

`handle_new_user()` est `SECURITY DEFINER`, utilise un `search_path` vide et
insère uniquement `new.id`. Le rôle est donc initialisé implicitement à
`STUDENT` par la valeur par défaut de `public.users.role`. La fonction n'est pas
exécutable par `anon` ou `authenticated`.

## RLS actuellement implémenté

RLS est activé sur les six tables :

- `public.users`
- `public.challenges`
- `public.groups`
- `public.group_members`
- `public.penalties`
- `public.notifications`

L'accès direct `anon` et `authenticated` est révoqué sur les six tables. Seuls
deux accès de lecture sont accordés à `authenticated` :

- `users_read_own` : lecture de la ligne dont `id = auth.uid()` ;
- `notifications_read_own` : lecture des notifications dont
  `user_id = auth.uid()`.

Aucune policy n'autorise actuellement l'insertion, la modification ou la
suppression directe par un client sur les tables métier. Les règles de gestion
des challenges, groupes, pénalités et rôles ne sont pas encore implémentées
dans des policies ou des RPC.

## Règles métier futures

Les éléments suivants restent à implémenter côté serveur :

- RPC `join_challenge` et contrôle atomique de la participation active ;
- activation automatique d'un groupe complet ;
- calcul et contrôle des deadlines ;
- échec automatique d'un groupe `ACTIVE` ;
- application effective des pénalités ;
- changement de rôle autorisé ;
- suppression ou anonymisation des profils ;
- notifications métier automatiques.

Ces éléments ne doivent pas être exposés comme déjà réalisés par le schéma
actuel.

## Règle

Toute modification du schéma doit passer par une migration Supabase versionnée.
