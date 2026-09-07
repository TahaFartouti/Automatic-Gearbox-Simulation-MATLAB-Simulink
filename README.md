
# Modélisation d'une boîte de vitesse automatique sous Simulink

Ce projet est né d'une envie simple : apprendre MATLAB/Simulink en partant de zéro, sur un sujet qui me parle vraiment. Étudiant en Génie Mécatronique, je voulais un projet qui sorte un peu du programme scolaire (orienté automobile de toute façon), donc j'ai choisi de modéliser complètement le fonctionnement d'une boîte de vitesse automatique, de A à Z.

Le véhicule de référence est une **Volkswagen Golf 1.5 TSI (150 ch)**, avec sa vraie boîte automatique, une **DSG DQ200 à 7 rapports**. J'ai voulu utiliser des données réelles plutôt que des chiffres inventés, pour que les résultats aient un vrai sens.

## Ce que le modèle fait concrètement

Le modèle simule toute la chaîne : le moteur produit un couple selon son régime et l'accélérateur, la boîte le démultiplie selon le rapport engagé, ce couple pousse le véhicule qui prend de la vitesse, et cette vitesse détermine à son tour le régime moteur — une vraie boucle physique fermée.

Par-dessus cette physique, une logique construite avec Stateflow (l'outil de machine à états de Simulink) décide toute seule quand changer de rapport, en fonction de la vitesse et de l'accélérateur — exactement comme le fait une vraie boîte automatique.

J'ai aussi ajouté un modèle simplifié de consommation de carburant, pour pouvoir comparer objectivement trois modes de conduite (Sport, Normal, Éco), puis utilisé un algorithme génétique pour laisser MATLAB chercher lui-même le meilleur réglage plutôt que de deviner à la main.

## Les fichiers du projet

- `init_params.m` : tous les paramètres du véhicule (masse, couple moteur, ratios de boîte, etc.), centralisés dans un seul fichier
- `gearbox_sim.slx` : le modèle Simulink complet
- `tester_mode_facteur.m` : une fonction utilisée pour automatiser les tests lors de l'optimisation

## D'où viennent les chiffres utilisés

| Paramètre | Valeur | Source |
|---|---|---|
| Véhicule | Golf 1.5 TSI, 150 ch | Fiche constructeur |
| Boîte de vitesse | DSG DQ200, 7 rapports, double embrayage sec | Fiche constructeur |
| Masse à vide | 1310 kg | Fiche constructeur (poids DIN) |
| Rayon de roue | 0.316 m | Calculé à partir du pneu 205/55 R16 |
| Coefficient de traînée (Cx) | 0.275 | Données constructeur/presse |
| Surface frontale | 2.23 m² | Données constructeur/presse |
| Couple maximal | 250 Nm, entre 1500 et 3500 tr/min | Fiche constructeur |
| Ratios de boîte (1 à 7) | 3.769 / 2.150 / 1.452 / 1.109 / 0.848 / 0.667 / 0.541 | Données de référence DQ200 |
| Rapport de pont | 3.94 | Données de référence DQ200 |

## Pour le faire tourner

1. Ouvrir MATLAB dans ce dossier
2. Exécuter `init_params` pour charger les paramètres
3. Ouvrir `gearbox_sim.slx` et cliquer sur Run

## Résultats

En accélération à fond sur route plate, le modèle atteint 100 km/h en environ 6.5 secondes, contre 8.5 secondes pour la vraie Golf. Cet écart n'est pas une erreur cachée : il vient de simplifications assumées (les changements de rapport sont instantanés dans le modèle, et il n'y a pas de glissement d'embrayage au démarrage).

La comparaison des modes de conduite sur un petit cycle simulé donne des résultats cohérents avec l'intuition : le mode Sport consomme plus que le Normal, qui consomme lui-même un peu plus que l'Éco.

| Mode | Consommation sur le cycle (60 s) |
|---|---|
| Éco | 1069.5 g |
| Normal | 1078.7 g |
| Sport | 1135.6 g |

L'algorithme génétique, lancé pour chercher le meilleur réglage possible, a trouvé une valeur encore plus économe que mon meilleur essai manuel : environ 6.5% de consommation en moins que le mode Sport.

## Ce que ce projet n'a pas (encore)

Pour rester honnête sur les limites du modèle : pas de vrai temps de transition entre les rapports (le changement est instantané), pas de glissement d'embrayage au démarrage, et la logique de passage de rapport utilise une formule plutôt qu'une vraie cartographie 2D calibrée comme le ferait une vraie unité de contrôle de transmission.

## Ce que j'en retiens

C'était mon premier vrai contact avec MATLAB, Simulink et Stateflow. La leçon la plus utile que j'en tire : ne jamais faire confiance à un résultat juste parce qu'il "a l'air bon" — vérifier systématiquement avec un calcul à la main m'a permis de repérer plusieurs erreurs qui auraient autrement faussé tout le reste du travail sans que je m'en aperçoive (un rapport de démultiplication oublié, une valeur figée à la place d'une variable).

## Auteur

Taha Fartouti, étudiant en Génie Mécatronique à l'ENSA Tetouan .
