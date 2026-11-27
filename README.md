# TP2 — EDO — S4 — Groupe 2

Ce fichier est un modèle à adapter puis à nommer `README.md` dans votre dépôt.

## Groupe et contributions

| Membre | Identifiant GitHub | Contributions concrètes |
|---|---|---|
| BORO Aliou Adama | Malone-ai280 | Programmation de Heun et RK4 dans "TP_02_Outils_EDO.sci" ; Correction d'un oubli de k4 dans RK4 (RK4 donnait 0,846 au lieu de 0,818733, repéré par le controle de Q1) ; calcul à la main de Q1 ; étude de stabilité Q6( facteur R(z), trajectoires pour h=0,2 et h=0,1, fig_stabilite.png) et diagnostic Q7 (Euler sur y'=-10y) ; Euler N=5 recalculé à la main (y indice 5 = (-2)^5 = -32, donc E indice 5 = 32) ; ordre Euler entre N=10 et N=20 recalculé (1,70) ; budget égal relancé (nfev = 400, RK4 le plus précis) ; export CSV de la convergence (TP2_convergence.csv)  |
| HIEN Désiré| desihien379 | Calcul à la main de Q1 ; tests Q1/Q2 pour les trois méthodes dans "TP_02_Application_Etudiant.sce" ; exécution à partir de la version github : tous les contrôles OK ; Q9 : erreurs et couts pour N= 100, 10, 4 avec les trois méthodes; stabilité prédite avec z=-H.h/C_th; choix RK4 N=10(0,0712°C, 40 évaluations) ; Q10 : étude de la sensibilité du paramètre H à temps d'observation fixes|
| ATCHOLADI Christian | Essozimna11 | Calcul des erreurs de convergence Q3 pour Euler, Heun et RK4 ; figure Q4 en echelles log-log avec les points instables repérés ; comparaison à budget égal Q5 ; facteurs R(z) de Q6 et Q7 recalculés à la main (h = 0,2 : -2, 2,5, 1,375 ; h = 0,25 : R = -1,5), identiques à la console ; figure de stabilité cohérente avec les signes prédits ; le calcul à la main de Q8 est confirmé par les lignes de code du commentaire de Q8|

## Objectif

Comparer Euler, Heun et RK4 puis choisir une méthode et un pas pour un modèle thermique.

## Dépôt

- Lien du dépôt : https://github.com/Malone-ai280/TP2_EDO_S4_G02/edit/main/README.md
- Le rapport déposé sur Moodle donne le lien du commit final. Le ZIP remis correspond à ce commit.

## Environnement et relance

- Version Scilab réellement 2025.1.0
- Placer TP_02_Outils_EDO.sci et TP_02_Application_Etudiant.sce dans le même dossier, puis lancer :exec("TP_02_Application_Etudiant.sce", -1);
- Le script se place lui-même dans son dossier (chdir) et charge le solveur. Aucune dépendance ajoutée.
- Sorties écrites dans ce dossier : TP2_methodes.csv, TP2_convergence.csv, TP2_convergence_complet.csv, fig_convergence.png,
  fig_stabilite.png.
- Q1, Q2, Q5 et Q7 à Q10 sont affichés dans la console uniquement.
-Fermer Excel avant de relancer : il verrouille les CSV.

## Vérifications effectuées

- Vérification ( BORO Aliou Adama) : -  Q1 recalculé à la main (0,8 ; 0,82 ; 0,8187333), identique à la console ; Euler N=5 recalculé à la main : y5 = (−2)^5 = −32, donc E = 32, identique au CSV ; ordre Euler entre N=10 et N=20 recalculé (1,70) ; budget égal relancé (nfev = 400 pour les trois méthodes) ; CSV relu dans un éditeur de texte (21 lignes).

- Vérification (HIEN Désiré ) : Q1 recalculé à la main ; tests Q1/Q2 lancés depuis la version GitHub : tous les contrôles OK ; Q9 : stabilité prédite avec z = −H·h/C_th, cohérente avec les erreurs affichées (h = 250 s : instable pour Euler et Heun).

- Vérification ( ) : 

## Fichiers et résultats

**Scripts**

-"TP_02_Outils_EDO.sci" : solveur "integrer_edo" (Euler fourni ; Heun et RK4 complétés) et fonction ordre_edo
qui calcul l'ordre observé entre deux erreurs.
-"TP_02_Application_Etudiant.sce" : application complète à lancer : contrôles Q1/Q2, étude de convergence
(Q3, Q4), comparaison à budget égal (Q5), stabilité (Q6, Q7).

**Données (CSV)**

-"TP2_methodes.csv" : correspondance des identifiants de méthode (1 = Euler, 2 = Heun, 3 = RK4), fourni par le kit.
-"TP2_convergence.csv" : erreur maximale aux noeuds, coût en évaluations de f et ordre observé, pour chaque méthode et
chaque N (de 5 à 320)
-TP2_convergence_complet.csv : même tableau avec z, |R|, stabilité (stable/instable), ordre interprétable (oui/non) et 
diagnostic.
**Figures**

-"fig_convergence.png" : erreur en fonction h, échelles log-log, pour les trois méthodes ; les ronds repèrent le 
calcul instable (N=5).
-"fig_stabilite.png" : trajectoires numériques et solution exacte pour h=0,2 (instable) et h=0,1 (stable) sur y'=-15y.

**Documents**



## Synthèse et limites

Résumer les méthodes comparées, le choix thermique et les limites. Renvoi au rapport
de trois pages maximum déposé sur Moodle.

## Sources et aides
- Énoncé et kit du TP02 (EDO : Euler, Heun, RK4), MN2 S4, 2iE, Dr Babacar LEYE. Code fourni par le kit : structure des fichiers, solveur Euler dans integrer_edo, fonction ordre_edo.
- Nos ajouts : Heun et RK4, tests Q1/Q2, études Q3 à Q10, exports CSV, figures, README.
- Documentation de Scilab (aide intégrée) pour les fonctions de tracé et d'écriture de fichiers.
- Usage de l'IA : nous avons utilisé Claude pour comprendre le TP et la démarche GitHub, aider à corriger le code Scilab.

