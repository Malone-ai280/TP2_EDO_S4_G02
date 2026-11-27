# TP2 — EDO — S4 — Groupe 2

Ce fichier est un modèle à adapter puis à nommer `README.md` dans votre dépôt.

## Groupe et contributions

| Membre | Identifiant GitHub | Contributions concrètes |
|---|---|---|
| BORO Aliou Adama | Malone-ai280 | Programmation de Heun et RK4 dans "TP_02_Outils_EDO.sci" ; Correction d'un oubli de k4 dans RK4 (RK4 donnait 0,846 au lieu de 0,818733, repéré par le controle de Q1) ; calcul à la main de Q1 ; étude de stabilité Q6( facteur R(z), trajectoires pour h=0,2 et h=0,1, fig_stabilite.png) et diagnostic Q7 (Euler sur y'=-10y). |
| HIEN Désiré| desihien379 | calcul à la main de Q1 ; tests Q1/Q2 pour les trois méthodes dans "TP_02_Application_Etudiant.sce" ; exécution à partir de la version github : tous les contrôles OK |
| ATCHOLADI Christian | Essozimna11 | Calcul des erreurs de convergence Q3 pour Euler, Heun et RK4 ; figure Q4 en echelles log-log avec les points instables repérés ; comparaison à budget égal Q5  |

## Objectif

Comparer Euler, Heun et RK4 puis choisir une méthode et un pas pour un modèle thermique.

## Dépôt

- Lien du dépôt : à compléter.
- Pour un dépôt privé : vérifier que les membres et l’enseignant ont effectivement accès.
- Le rapport déposé sur Moodle donne le lien du commit final. Le ZIP remis correspond à ce commit.

## Environnement et relance

- Version Scilab réellement utilisée : à compléter.
- Placer les fichiers `.sci` et `.sce` dans le même dossier.
- Ouvrir ce dossier dans Scilab, puis lancer :

```scilab
exec("TP_02_Application_Etudiant.sce", -1);
```

- Le script travaille dans son propre dossier. Décrire ici tout fichier ou dépendance ajouté.
- Indiquer les sorties réellement produites et leur emplacement.

## Vérifications effectuées

Décrire les résultats des contrôles Q1/Q2, y compris le test dépendant du temps.
Expliquer les valeurs NaN légitimes dans les ordres et les diagnostics de stabilité.

## Fichiers et résultats

**Scripts**

"TP_02_Outils_EDO.sci" : solveur "intergrer_edo" (Euler fourni ; Heun et RK4 complétés) et fonction ordre_edo
qui calcul l'ordre observé entre deux erreurs.
"TP_02_Application_Etudiant.sce" : application complète à lancer : contrôles Q1/Q2, étude de convergence
(Q3, Q4), comparaison à budget égal (Q5), stabilité (Q6, Q7).

**Données (CSV)**

"TP_methodes.csv" : correspondance des identifiants de méthode (1 = Euler, 2 = Heun, 3 = RK4), fournipar le kit.
"TP_convergence.csv" : erreur maxiale aux noeuds, coût en évaluations de f et ordre observé, pour chaque méthode et
chaque N (de 5 à 320)

**Figures**

"fig_convergence.png" : erreur em fonction h, échelles log-log, pour les trois méthodes ; les ronds répèrent le 
calcul instable (N=5).
"fig_stabilite.png" : trajectoires numériques et solution exacte pour h=0,2 (instable) et h=0,1 (stable) sur y'=15y.

**Documents**



## Synthèse et limites

Résumer les méthodes comparées, le choix thermique et les limites. Renvoi au rapport
de trois pages maximum déposé sur Moodle.

## Sources et aides

Citer les documents utilisés et l’usage éventuel de l’IA. Distinguer le code fourni
dans le kit et vos propres ajouts. Ne pas publier de mots de passe ou de documents du cours.
