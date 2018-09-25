# Algorithmes primordiaux

Nous allons commencer par aborder les algorithmes primordiaux. Ceux-ci servent généralement de primitives pour de nombreux autres algorithmes et leur étude fournit donc une base solide pour traiter des problèmes plus complexes. Il est donc d'autant plus important d'avoir des algorithmes efficaces pour ceux-ci.

## Parcours

Le parcours (scanning) est l'opération de base qui consiste simplement à consulter chacun des éléments d'une collection contiguë en mémoire. Naturellement, sa complexité est limitée par $O(\frac{N}{B})$. Il en va de même si nous exécutons plusieurs parcours en parallèle, comme lors d'une inversion de l'entrée, par exemple. Cette complexité correspond à ce qu'on peut s'attendre de la linéarité dans un tel modèle, de même $O(\frac{1}{B})$ est l'équivalent du temps constant pour un élément.

## Recherche

La recherche d'un élément dans une collection triée bénéficie relativement peu de ces notions de blocs. En effet, nous pouvons utiliser un argument lié à la théorie de l'information, s'il y a $N$ éléments, notre élément peut être trouvé n'importe où dans ces $N$ positions, donc nous avons besoin de $\Omega(\log N)$ bits d'information (pour encoder la position). Or, quand nous lisons un bloc, nous obtenons $\Omega(\log B)$ bits d'information à la fois, puisque chaque bloc lu révèle atomiquement où se trouve l'élément de requête parmi ces $B$ éléments, ceci conduit à $\Omega(\frac{\log N}{\log B}) = \Omega(\log_{B} N)$. Les $B$-trees représentent une solution à ce problème.

## Partitionnement multiple

Le partitionnement multiple consiste à fractionner un ensemble de $N$ éléments non triés en $d$ paquets de telle sorte que tous les éléments du $i$e paquet soient plus petits que le $i$e pivot et plus grands que le $i-1$e pivot étant donné une liste de $d-1$ pivots triés dans l'ordre croissant.

L'idée est tout à fait naturelle. Nous effectuons $\frac{d}{B}$ parcours où on compte le nombre d'éléments plus petit ou plus grand pour chacun des pivots. Ensuite, il suffit de combiner ces informations (all-prefix-sum / scan pour les haskelliens) afin de déterminer à quel index nous pourrons écrire sans conflits les éléments relatifs à un pivot. Ceci aboutit à une complexité en $O(\frac{N}{B})$

## Sélection

De manière analogue, étant donné un ensemble non ordonné de taille $N$ et un entier $k$ (avec $1 \leq k \leq k \leq N$). Le problème de sélection consiste à trouver un élément tel qu'il est plus grand que tous les $k - 1$ éléments précédents.

L'idée est assez similaire à celle du "$k$th sort". Nous effectuons un partitionnement multiple sur les entrées et effectuons la récursion sur le sous-ensemble ciblé. Cela conduit à une complexité équivalente au problème précédent, soit $O(\frac{N}{B})$.

## Tri fusion

Revenons d'abord sur la complexité du tri fusion classique, c'est-à-dire avec la fusion de deux listes à la fois. La complexité est décrite par le système ci-dessous:
$$
\left\{
    \begin{array}{ll}
        MT(N) = 2MT(\frac{N}{2}) + O(\frac{N}{B}) \\
        MT(M) = O(\frac{M}{B})
    \end{array}
\right.
$$

En effet, nous effectuons à chaque fois deux récursions, et au retour de celle-ci, nous fusionnons les résultats de celles-ci en une seule liste. Nous devons donc effectuer un parcours simultanément afin de produire notre résultat, donc $O(\frac{N}{B})$. Maintenant, remarquons que la hauteur de la récursion est bornée par $O(\log N - \log M) = O(\log \frac{N}{M})$ puisqu'une fois que nous arrivons à la taille du cache, les opérations deviennent essentiellement gratuites. Finalement, la quantité de travail reste la même pour chacun des niveaux de l'arbre de récursion, ce qui conduit à $O(\frac{N}{B} \log \frac{N}{M})$.

Seulement, ce n'est pas optimal. En effet, nous n'utilisons pas à pleines capacités la taille du cache. Au lieu de fusionner deux listes à la fois, nous pourrions en fusionner jusqu'à $\frac{M}{B}$ à la fois (nous précisons que ce n'est pas trivial). Il suffit de remplacer le coefficient "$2$" par $\frac{M}{B}$ et nous retombons sur la borne optimale, soit $O(\frac{N}{B} \log_{\frac{M}{B}} \frac{N}{B})$.

## Tri par distribution

Le tri par distribution consiste à partitionner un ensemble de $N$ éléments non triés en $d$ paquets, chacun étant trié et concaténé de façon récursive pour obtenir le résultat final, il peut être considéré comme une généralisation du tri rapide. L'algorithme, par lui-même, échantillonne au hasard des éléments des données pour obtenir $\sqrt{\frac{M}{B}}$ pivots, partitionne les données et s'appelle lui-même sur ces sous-ensembles. Quand il n'y a plus assez de données pour en recréer une autre, nous effectuons un tri classique et optimal en mémoire interne.