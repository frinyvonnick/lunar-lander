# Plan d'implémentation - Lunar Lander Multijoueur

## Phase 1 : Prototype de base (TERMINÉE)

- [x] Module lunaire (CharacterBody2D, collision, visuel)
- [x] Contrôles solo (rotation et propulsion)
- [x] Feedback visuel propulsion (flamme)
- [x] Physique (gravité, sol, détection contact)
- [x] Détection atterrissage/crash (angle, vitesse)
- [x] UI de debug (vitesse, angle)
- [x] Intégration multijoueur (lander partagé, contrôles séparés)

---

## Phase 2 : Core Loop (jouable de bout en bout) - EN COURS

### 2.1 - Écran de défaite (crash) ✅
- [x] Afficher un écran quand le module crash
- [x] Feedback visuel clair (explosion, message)
- [x] Les deux joueurs voient le même écran

### 2.2 - Écran de victoire (atterrissage) ✅
- [x] Afficher un écran quand l'atterrissage est réussi
- [x] Feedback visuel positif
- [x] Les deux joueurs voient le même écran

### 2.3 - Possibilité de rejouer ⚠️
- [ ] Bouton "Rejouer" sur les écrans victoire/défaite
- [x] Reset du niveau (position, fuel, état)

### 2.4 - Système de fuel
- [ ] Quantité de fuel limitée
- [ ] Consommation lors de la propulsion
- [ ] Consommation lors de la rotation (optionnel)
- [ ] Game over si fuel = 0 et pas atterri

### 2.5 - UI Fuel
- [ ] Jauge de fuel visible
- [ ] Alarme visuelle quand fuel bas
- [ ] Alarme sonore quand fuel bas (optionnel)

---

## Phase 3 : Gameplay complet - À FAIRE

### 3.1 - Indicateur de proximité/danger
- [ ] RayCast pour détecter le sol à l'avance
- [ ] Indicateur visuel (couleur) basé sur vitesse d'impact prévue
- [ ] Indicateur d'alignement avec la surface

### 3.2 - Zones d'atterrissage avec multiplicateur
- [ ] Zones plates = multiplicateur faible (x1)
- [ ] Zones difficiles (petites, en pente) = multiplicateur élevé (x2, x3, x5)
- [ ] Visuel distinct pour chaque zone

### 3.3 - Système de score
- [ ] Points basés sur : fuel restant, multiplicateur zone, précision atterrissage
- [ ] Affichage du score en temps réel
- [ ] Score final à la victoire

### 3.4 - Système de niveaux
- [ ] Plusieurs niveaux avec terrains différents
- [ ] Enchaînement automatique après victoire
- [ ] Score cumulé sur plusieurs niveaux

### 3.5 - Difficulté progressive
- [ ] Gravité plus forte
- [ ] Moins de fuel de départ
- [ ] Terrains plus accidentés
- [ ] Zones d'atterrissage plus petites

### 3.6 - Système de vent
- [ ] Force horizontale variable
- [ ] Indicateur visuel de direction/force du vent
- [ ] Change au cours du niveau ou entre niveaux

---

## Phase 4 : Polish visuel - À FAIRE

### 4.1 - Animation poussière à l'approche
- [ ] Particules de poussière quand proche du sol
- [ ] Intensité basée sur la distance et la puissance du thruster

### 4.2 - Animation glissement + étincelles
- [ ] Sur atterrissage en pente, le module glisse légèrement
- [ ] Étincelles au contact avec le sol

### 4.3 - Explosion au crash
- [ ] Animation d'explosion
- [ ] Débris qui volent
- [ ] Screen shake (optionnel)

### 4.4 - Fond étoilé
- [ ] Étoiles en arrière-plan
- [ ] Parallax scrolling (optionnel)

### 4.5 - Indicateur d'altitude
- [ ] Afficher la hauteur par rapport au sol
- [ ] Barre ou chiffre

---

## Phase 5 : Audio - À FAIRE

### 5.1 - Son du thruster
- [ ] Son continu quand propulsion active
- [ ] Variation selon puissance (optionnel)

### 5.2 - Alarme fuel bas
- [ ] Son d'alerte quand fuel < 20%
- [ ] Bips de plus en plus rapides

### 5.3 - Sons d'événements
- [ ] Son d'explosion au crash
- [ ] Son d'atterrissage réussi
- [ ] Son de contact avec le sol

### 5.4 - Musique d'ambiance
- [ ] Musique spatiale/tension
- [ ] Variation selon situation (calm, danger)

---

## Phase 6 : Meta-game & Social - À FAIRE

### 6.1 - Leaderboard
- [ ] Score par équipe de 2 joueurs
- [ ] Classement global
- [ ] Classement par niveau (optionnel)

### 6.2 - Pause
- [ ] Mettre le jeu en pause
- [ ] Menu pause avec options (reprendre, quitter, recommencer)

---

## Considérations Multijoueur

- **Score** : Score commun aux deux joueurs
- **Écrans** : Victoire/défaite synchronisés
- **Communication** : Les joueurs doivent se coordonner (voice chat externe recommandé)
- **Rôles** : Joueur 1 = rotation, Joueur 2 = propulsion
- **Leaderboard** : Par équipe (pseudo1 + pseudo2)

---

## Ordre de priorité suggéré

1. Phase 2 (Core Loop) - Indispensable pour un jeu jouable
2. Phase 3.1-3.3 (Indicateurs, Zones, Score) - Rend le jeu intéressant
3. Phase 3.6 (Vent) - Mécanique coop intéressante
4. Phase 3.4-3.5 (Niveaux, Difficulté) - Progression
5. Phase 4 (Polish visuel) - Rend le jeu agréable
6. Phase 5 (Audio) - Immersion
7. Phase 6 (Meta-game) - Rejouabilité long terme
