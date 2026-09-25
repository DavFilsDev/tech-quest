
# TechQuest — Development Roadmap

## Phase 1 — Initialisation

- [x] Créer le projet Flutter
- [x] Connecter le repository GitHub
- [x] Créer `.gitignore`
- [x] Créer `CHANGELOG.md`
- [x] Ajouter la première version `0.1.0`
- [x] Ajouter les fichiers `docs/`
- [x] Créer la structure de dossiers
- [x] Configurer l'analyse Dart/Flutter
- [x] Configurer le formatage Dart
- [x] Créer `.github/workflows/flutter_ci.yml`
- [x] Configurer les checks `Format`, `Analyze`, `Tests` et `Coverage`
- [x] Vérifier la CI sur GitHub
- [x] Créer un premier commit

## Phase 2 — Supabase Foundation

- [x] Installer et configurer la CLI Supabase
- [x] Créer le projet Supabase
- [x] Lier le projet Supabase au repository
- [x] Créer les migrations
- [x] Créer les tables
- [x] Ajouter les contraintes
- [x] Ajouter les indexes
- [x] Configurer la baseline RLS
- [x] Tester les migrations avec `supabase db reset`
- [x] Appliquer et vérifier les migrations sur le Cloud
- [ ] Configurer les variables d'environnement
- [ ] Configurer Auth
- [ ] Tester la connexion Flutter/Supabase

> La fondation Supabase est terminée. La prochaine étape est la Phase 3 — Authentification.

## Phase 3 — Authentification

- [ ] Register
- [ ] Login
- [ ] Logout
- [ ] Session persistante
- [ ] Profil utilisateur
- [ ] Gestion des rôles

## Phase 4 — Challenges

- [ ] Liste des challenges
- [ ] Détails d'un challenge
- [ ] Création par professeur
- [ ] Modification par professeur
- [ ] Archivage

## Phase 5 — Groupes

- [ ] RPC `join_challenge`
- [ ] Formation automatique
- [ ] Groupe WAITING
- [ ] Activation automatique
- [ ] Verrouillage du groupe
- [ ] Affichage des membres

## Phase 6 — Temps et résultats

- [ ] Countdown
- [ ] Progression temporelle
- [ ] Deadline
- [ ] Échec automatique
- [ ] Validation professeur
- [ ] Pénalité
- [ ] Historique

## Phase 7 — UI finale

- [ ] Navigation complète
- [ ] États loading
- [ ] États empty
- [ ] Gestion des erreurs
- [ ] FR
- [ ] EN
- [ ] Accessibility

## Phase 8 — Tests

- [ ] ≥ 10 tests unitaires
- [ ] ≥ 5 tests widget
- [ ] ≥ 2 tests intégration
- [ ] Tests des règles métier critiques

## Phase 9 — Performance

- [ ] Vérifier les rebuilds
- [ ] Optimiser les listes
- [ ] Optimiser les images
- [ ] Vérifier le countdown
- [ ] Vérifier les performances avec DevTools

## Phase 10 — CI/CD

- [ ] Vérifier et améliorer le workflow GitHub Actions
- [ ] Ajouter les éventuelles étapes spécifiques au projet
- [ ] Vérifier que la CI reste verte

## Phase 11 — Documentation

- [ ] README
- [ ] Captures d'écran
- [ ] Badges
- [ ] Mettre à jour le CHANGELOG
- [ ] Vérifier que les versions importantes sont documentées
- [ ] Vérification des documents

## Phase 12 — Validation finale

- [ ] `flutter analyze`
- [ ] Tous les tests passent
- [ ] Vérifier les 5+ écrans
- [ ] Vérifier FR/EN
- [ ] Vérifier accessibility
- [ ] Vérifier performance
- [ ] Vérifier RLS
- [ ] Vérifier repository public
- [ ] Générer APK
- [ ] Dernier contrôle certification