# TechQuest — Database Contract

## Tables

### users

- id
- email
- full_name
- role
- avatar_url
- created_at
- updated_at

Roles :

`STUDENT | PROFESSOR | ADMIN`

---

### challenges

- id
- professor_id → users.id
- title
- description
- required_members
- duration_days
- deliverable
- validation_criteria
- status
- created_at
- updated_at

Status :

`PUBLISHED | ARCHIVED`

---

### groups

- id
- challenge_id → challenges.id
- status
- started_at
- deadline
- created_at
- updated_at

Status :

`WAITING | ACTIVE | COMPLETED | FAILED`

---

### group_members

- group_id → groups.id
- user_id → users.id
- joined_at

Clé primaire :

`(group_id, user_id)`

---

### penalties

- id
- user_id → users.id
- penalty_until
- reason
- created_at

---

### notifications

- id
- user_id → users.id
- type
- title
- body
- read_at
- created_at

## Relations

```text
users 1 ─── N challenges
challenges 1 ─── N groups
groups 1 ─── N group_members
users 1 ─── N group_members
users 1 ─── N penalties
users 1 ─── N notifications
````

## Règle

Toute modification du schéma doit passer par une migration Supabase versionnée.
