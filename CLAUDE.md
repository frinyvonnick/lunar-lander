# Règles de développement pour Claude

## Débogage et hypothèses

**IMPORTANT** : Lors du débogage, toujours suivre cette méthodologie :

1. **Observer** : Analyser les logs et le comportement réel
2. **Hypothèse** : Formuler une hypothèse claire sur la cause du problème
3. **Validation** : Proposer un moyen de valider l'hypothèse (logs, tests, etc.)
4. **Attendre l'approbation** : NE PAS implémenter de correctif sans validation explicite de l'utilisateur
5. **Implémenter** : Une fois l'hypothèse validée, implémenter le correctif approprié

### Règle : Pas d'implémentation sans validation

Quand je fais des hypothèses pendant le débogage, je **NE DOIS PAS** implémenter de correctif sans validation de l'utilisateur. On doit **toujours valider l'hypothèse avant d'implémenter un correctif**.

### Approche préférée

- Ajouter des logs pour observer le comportement
- Tester des scénarios spécifiques
- Utiliser git pour comparer les versions
- Poser des questions sur le comportement observé

### À éviter

- Faire des changements "au hasard" basés sur des suppositions
- Implémenter plusieurs correctifs à la fois sans savoir lequel résout le problème
- Modifier du code qui fonctionnait sans preuve qu'il est la cause du problème
