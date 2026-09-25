# TechQuest — Quality Rules

## Code

- `flutter analyze` doit être propre.
- Utiliser `const` lorsque pertinent.
- Éviter les rebuilds inutiles.
- Éviter le code mort et les dépendances inutiles.
- Les erreurs techniques doivent être transformées en erreurs compréhensibles
  par l'interface.

## Performance

- Listes avec chargement lazy.
- Images optimisées.
- Pas de jank visible.
- Le countdown ne doit pas reconstruire toute la page.

## Accessibility

Les éléments interactifs importants doivent avoir des semantic labels.

## Internationalisation

Langues obligatoires :

- Français
- Anglais

Les textes visibles ne doivent pas être hardcodés inutilement dans les widgets.

## Sécurité

- RLS activé sur les tables exposées.
- Aucun secret dans Git.
- `service_role` jamais utilisé dans Flutter.
- Les permissions sont vérifiées côté Supabase.