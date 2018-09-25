# Contexte

Les notions liées à l'I/O complexité sont apparues au début des années 70 mais n'ont vraiment été popularisées que vers la fin des années 80 avec l'apanage qu'on leur a connu lors de la charnière 2000 et l'implémentation de certains résultats dans le cadre des bases de données. Elles sont issues de différents phénomènes qui ont émergé petit à petit et pour des raisons fort spécifiques.

## Une question de temps

Classiquement, lorsqu'on apprend aux étudiants les notions de complexité, on le fait au travers d'un modèle de calcul spécifique et temporel. Ce modèle de calcul qualifié de "(word-)RAM" n'est pourtant apparu qu'en 1990[^word-RAM] ! Il est conceptuellement très simple et correspond fort bien à la perception que l'on se fait de la complexité; en simplifiant, c'est le modèle qui se rapproche des capacités du C. On associe à chaque opération un coût unitaire $O(1)$, que ce soit une addition, une multiplication, un accès mémoire, un saut dans un branchement conditionnel, ... Et les complexités supérieures apparaissent naturellement, comme lorsqu'on doit parcourir une collection de $n$ éléments avec son facteur $O(n)$ associé, par exemple. Rien de bien sorcier.

Seulement, celui-ci présente certains défauts:

- Premièrement, toutes les opérations de base sont en temps constant. Or, on comprend bien que l'évaluation d'une fonction sinus prend plus de temps qu'effectuer un "and" entre deux nombres. On présente généralement un aspect haut niveau pour ces opérations, et on revient plus précisément sur ces notions uniquement si l'on doit calculer la complexité de manière plus précise afin de déterminer quel algorithme choisir pour évaluer la fonction sinus de la manière la plus rapide possible. Ce sont alors davantage des aspects quantitatifs que qualitatifs.
- Deuxièmement, il ne permet pas de représenter des phénomènes plus complexes liés à l'accélération matérielle, par exemple. Une opération peut prendre plus ou moins de temps en fonction du contexte. Nous évoquons notamment le cas des "branch prediction" ou des instructions SIMD.
- Troisièmement, qu'en est-il de la complexité liée à la mémoire ? Écrire dans un fichier est-il réellement en O(1) ? Vaut-il mieux accéder à tous les éléments de manière contiguë et non de manière aléatoire ? Ce sont sans doute les points les plus discutables de ce modèle.

## Les débuts - Floyd

Le temps d'accès aux ressources est certes un des principaux défauts du modèle RAM, mais ce n'est pas ce qui a motivé ce champ d'étude à l'origine. En 1972, Robert W. Floyd[^floyd72] (prix Turing 1978, auteurs de *très* nombreux travaux et entré à l'université à l'âge de 14 ans), introduit un modèle de calcul un peu particulier en vue de répondre à une problématique bien précise. Les mémoires de l'époque étaient extrêmement petites, quelques KB, et les disques durs à peine plus, de l'ordre du MB, mais souvent bien moins. Il était donc impossible de faire tenir toutes les données directement en mémoire et il s'était demandé combien de transferts étaient nécessaires afin de permuter l'ensemble des éléments d'un même "fichier".

-> ![Modèle originel de Floyd](/media/galleries/5209/c26c03f0-ddd3-4138-ae56-cba71d8ddd36.png) <-

Ce modèle ce d'ordinateur se décrit comme suit:

- La RAM est composée de blocs d'au maximum $B$ objets.
- On est capable de lire jusqu'à $B$ objets provenant de deux blocs ($i, j$) en même temps et d'écrire dans un troisième ($k$). Ceci détermine l'opération en $O(1)$ de ce modèle.
- L'ordre des éléments dans un bloc n'a aucune importance.
- Les opérations effectuées sur le CPU n'ont pas de coût.
- Les objets sont atomiques, on ne peut pas les diviser en plusieurs objets.

Vous en conviendrez, ce modèle est très spécial. Il a néanmoins permis d'établir un théorème:

> Permuter N éléments dans $\frac{N}{B}$ blocs (préalablement définis et remplis) nécessite $\Omega(\frac{N}{B} \log B)$ opérations en moyenne. Sous l'hypothèse que $\frac{N}{B} > B$.

Pour trouver cette complexité, il définit une fonction dite de "potentielle". C'est outil sera employé de très nombreuse fois par la suite afin de démontrer des propriétés dynamiques sur des structures de données. Elle est définie comme suit: $\Phi = \sum_{i, j} n_{i, j} \log n_{i, j}$ où la quantité $n_{i, j}$ représente le nombre d'objets du bloc $i$ destiné au bloc $j$.

Certains verront des similitudes avec les travaux de Shannon, notamment, portant sur l'entropie et la théorie de l'information. L'argument s'exprime comme suit: nous cherchons à maximiser ce potentiel (puisque c'est l'"inverse" de l'entropie), plus nous sommes loin de la configuration visée, plus nous devrons effectuer d'opérations. Et inversement, si tous les objets sont déjà à leur place ($n_{i,i}$ pour chaque $B$), on obtient $\Phi = N \log B$.

Au début, dans une configuration aléatoire, l'entropie est faible. L'espérance de chaque élément d'être à sa position finale est faible: $E[n_{i,j}] = O(1)$ (à condition qu'il y ait plus d'éléments que de blocs), le potentiel a donc une espérance linéaire: $E[\Phi] = O(N) \approx N * O(1)$. Les opérations visent donc à augmenter le potentiel afin d'arriver à ce facteur $\log B$ de différence. Or, chaque opération ne peut augmenter ce potentiel d'au maximum $B$. Il faut voir cela au travers du fait que fusionner deux blocs n'entraîne qu'une augmentation en terme de leurs nombres ($(x + y) \log (x + y) \leq x \log x + y \log y + x + y$). Le nombre d'opérations est donc déterminé comme suite:

$$ \text{Nombres d'opérations} \geq \frac{N \log B - O(N)}{B} $$

## Red-blue pebble game

Vous en conviendrez, le modèle précédent, de Floyd, tombe un peu comme un cheveu sur la soupe. Il est difficile de voir son intérêt réel. Néanmoins, son article initiateur lançait quelques pistes de réflexions et des problématiques qui ont mené à cette branche de l'algorithmie. Il y a eu quelques variantes par rapport au modèle de Floyd[^tsuda83], mais rien de transcendant.

La prochaine grande innovation dans cette branche fut le modèle développé par Hong Jia-Wei et Hsiang-Tsung Kung en 1981[^hongkung81] et appelé (érronément) Hong & Kung. Ils ont démontré la complexité de différents algorithmes grâce à un jeu, le "Red-blue pebble game" (jeu des galets rouges-bleus, littéralement). L'idée est qu'effectuer des transferts mémoires est long (surtout à l'époque des bandes magnétiques où c'était parfois manuel) et on cherche donc à minimiser de telles opérations. Ils partent sur une toute autre vision du problème (sur base de travaux effectués quelques années auparavant et établissant un lien entre la complexité temporelle et spatiale[^hopcroft77]).

On associe à un algorithme un graphe de calcul. Celui-ci s'exprime au travers d'un graphe dirigé acyclique (DAG) où chaque nœud $v$ correspond, soit à une entrée (s'il n'existe pas d'arêtes entrantes), soit à une sortie (s'il n'y a pas d'arêtes sortantes), ou soit à un calcul où les arêtes représentent les dépendances entre les opérandes.

L'idée est de jouer à un jeu, sur ce graphe de calcul, basé sur quelques règles. Un galet rouge représente de la mémoire interne et rapide et bleu externe et lente. On peut mettre un galet bleu sur un rouge ou vice-versa, cela représente un transfert de données entre les deux types de mémoire. La complexité s'exprime donc en terme du nombre de transferts effectués entre ceux deux endroits. De surcroît, nous avons besoin d'avoir toutes les arêtes entrantes couvertes de galets rouges afin d'effectuer un calcul et de faire naître un nouveau galet rouge. Nous pouvons également enlever les galets à tout moment et nous pouvons disposer d'au maximum $M$ de galets rouges en même temps sur le graphe. Le but du jeu consiste à couvrir certains nœuds de sortie avec des cailloux bleus selon une distribution bleue initiale.

Ils ont prouvé qu'un partitionnement du graphe de calcul donnait une limite inférieure sur le nombre d'opérations d'I/O. Tout ensemble de partitions peut avoir un ensemble dominant (nœuds à partir desquels il existe un chemin des nœuds d'entrée vers cet ensemble, le flux d'exécution) d'une taille maximale de $2M$. Et qu'il en existe au maximum $\mathcal{P}(2M)$ (avec $\mathcal{P}(.)$ l'ensemble des parties d'un ensemble) et donc que le nombre minimal d'I/O est borné par $M (\mathcal{P}(2M) - 1)$. On peut exprimer la complexité par rapport à ce $M$ par la fonction W de Lambert.

Ils ont alors démontré la complexité de nombreux problèmes qui pouvaient s'exprimer sous la forme d'un DAG (certaines conjectures impliquent une correspondance par rapport à certains problèmes polynomiaux ou avec la classe de complexité $AC^{0}$). Notamment, que calculer une transformée de Fourier était en $\Theta(N \log_{M} N)$ (ce qui peut être vu comme une forme particulière de permutations), la multiplication d'un vecteur et d'une matrice en $\Theta(\frac{N^{2}}{M})$, la multiplication de deux matrices en $\Theta(\frac{N^{3}}{\sqrt{M}})$, et ainsi de suite ...

## Travaux postérieurs

Quelques modèles dérivés ont vu leur apparition dans les années qui ont suivi. La principale innovation consiste en la représentation de différents niveaux de mémoire avec leur propre caractéristiques en terme de vitesse. Ceci vise à représenter les ordinateurs actuels, composées d'une hiérarchie de mémoire possédant des caractéristiques diverses, d'une vitesse prodigieuse et faisant quelques KB pour les caches L1 des CPU, à des GB pour une bande passante raisonnable pour les barrettes de mémoire. On parle notamment du modèle HMM[^aggarwal87] qui vise à représenter une hiérarchie infinie, avec la notion de politique de remplacement dans les caches.
Seulement, ils sont généralement moins commodes à employer. On leur préfère généralement une version plus simple dite "EM" avec seulement deux niveaux de mémoires. En outre, ils ont été élégamment généralisés par la notion de cache obliviousness qui offre des propriétés beaucoup plus fortes.

[^word-RAM]: FREDMAN, Michael L. et WILLARD, Dan E. Blasting through the information theoretic barrier with fusion trees. In : Proceedings of the twenty-second annual ACM symposium on Theory of Computing. ACM, 1990. p. 1-7.
[^floyd72]: FLOYD, Robert W. Permuting information in idealized two-level storage. In : Complexity of computer computations. Springer, Boston, MA, 1972. p. 105-109.
[^tsuda83]: TSUDA, Takao, SATO, Takashi, et TATSUMI, Takaaki. Generalization of floyd's model on permuting information in idealized two-level storage. Information Processing Letters, 1983, vol. 16, no 4, p. 183-188.
[^hongkung81]: JIA-WEI, Hong et KUNG, Hsiang-Tsung. I/O complexity: The red-blue pebble game. In : Proceedings of the thirteenth annual ACM symposium on Theory of computing. ACM, 1981. p. 326-333.
[^hopcroft77]: HOPCROFT, John, PAUL, Wolfgang, et VALIANT, Leslie. On time versus space. Journal of the ACM (JACM), 1977, vol. 24, no 2, p. 332-337.
[^aggarwal87]: AGGARWAL, Alok, ALPERN, Bowen, CHANDRA, Ashok, et al. A model for hierarchical memory. In : Proceedings of the nineteenth annual ACM symposium on Theory of computing. ACM, 1987. p. 305-314.