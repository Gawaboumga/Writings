# External Memory

Les deux modèles présentés précédemment sont très différents. D'un part, Floyd introduit la notion de blocs mais sans la notion de cache, et d'autre part, Hong & Kung introduisent le cache (zone où sont effectués les calculs) mais ignore les blocs.

Heureusement, Alok Aggarwal et Jeffrey S. Vitter introduisent, en 1988[^aggarwal88], le modèle de calcul External Memory (ou anciennement appelé Disk Access Model) qui réunit ces deux aspects en un. La complexité est déterminée par le nombre de transferts de blocs effectués lors de l'algorithme, sous l'hypothèse d'une mise à jour du cache optimale. Toutes les opérations de calcul effectuées en cache sont donc originellement sans coût; ceci implique que, par essence, on possède en tout temps les éléments d'un même bloc triés, voir même l'entièreté du cache trié.

-> ![Modèle de l'External Memory](/media/galleries/5209/f0bfa9b5-3dfc-45b2-9c6f-cefb24b1e14c.png) <-

Formellement, il est défini par un ensemble de variables:

- N = la taille du problème (en terme d'objets).
- M = la taille de la mémoire interne (cache) (en terme d'objets).
- B = la taille des blocs transférés (en terme d'objets).
- P = le nombre de blocs transférés simultanément (originellement introduit, mais ne présente un réel intérêt que dans son extension appelé Parallel Disk Model[^vitter98]).

Par la suite, de nombreux résultats feront l'hypothèse que $M \geq B^{O(1)}$ (ou sous une forme plus faible $M = \Omega(B^{1 + \epsilon})$). Cette hypothèse est nommée "tall-cache assumption" puisqu'elle sous-tend qu'il existe plus de blocs que la taille des blocs. Gerth S. Brodal et Rolf Fagerberg [^brodal03] ont démontré que, sans cette hypothèse, trier ne peut pas être effectué de manière optimale (et que permuter les éléments n'est pas cache-oblivious même sous cette propriété).

L'article en lui-même aborde sur de nombreux aspects, des complexités triviales, des preuves d'optimalité et l'équivalence avec le modèle de Hong et Kung. Nous reviendrons sur certains algorithmes plus en détail. Ici, nous aborderons leur théorème principal:

> La complexité pour permuter $N$ éléments est de: $\Theta(\text{min} \{N, \frac{N}{B} \log_{\frac{M}{B}} \frac{N}{B} \})$.

Cette complexité peut quelque peu étonner. À haut niveau, l'argument peut être exprimé comme suit. Trier les éléments est un cas spécial des permutations. Or, nous pouvons conserver le cache trié sans le moindre coût. Maintenant, si nous effectuons un transfert en mémoire interne, nous pouvons apprendre où se situent ces $B$ éléments parmi le cache $M$ ($\binom{M + B}{M}$). Au final, nous devons connaître la position de chacun des éléments ($N!$). Si nous empruntons un argument issu de la théorie de l'information, nous pouvons prendre le logarithme de chacune des expressions et effectuer le rapport.

$$\log N! = N \log N \text{et} \log \binom{M + B}{M} \approx B \log \frac{M}{B} \rightarrow \frac{N \log N}{B \log \frac{M}{B}} = \frac{N}{B} \log_{\frac{M}{B}} \frac{N}{B} $$

Voici la vision rétrospective du problème, mais une preuve différente a été effectuée originellement. L'idée est de borner le nombre maximum de permutations qui peuvent être produites par au plus $T$ I/Os, nous recherchons donc le pire cas du nombre de transferts requis pour effectuer $N!$ permutations. Seulement, une fois que nous avons un bloc en mémoire interne, nous pouvons faire toutes les permutations sans coût (un facteur $B!$) et nous savons qu'il y a $N/B$ blocs en tout, ce qui conduit à $N! / B!^{\frac{N}{B}}$ possibilités de permutations.

Maintenant, nous devons considérer ce qui se passe quand nous considérons une entrée ou une sortie du problème. Chaque fois qu'un nouvel élément est pris en compte, le même processus doit être effectué; cette action doit donc être répétée $N$ fois. Nous devons aussi nous rappeler qu'une fois que nous avons un bloc, nous pourrons générer toutes ses permutations. Donc, nous devons compter le nombre de façons de placer le bloc dans le cache, ce qui correspond à l'ordre de sortie des éléments $\binom{M}{B}$ ou l'ordre dans lequel ils sont lus. Nous arrivons à la relation:

$$ (N \binom{M}{B})^{T} \geq \frac{N!}{B!^{\frac{N}{B}}}$$

Maintenant, en prenant le logarithme des deux côtés et en appliquant la formule de Stirling, on obtient:

$$ T = \Omega(\frac{N}{B} \log_{\frac{M}{B}} \frac{N}{B}) $$

Il ne reste donc plus qu'à déterminer ce mystérieux $N$ (présent dans la fonction min). Il correspond simplement à l'algorithme de permutation classique du modèle RAM, où on ne prête pas attention à ces notions de blocs. Nous verrons par la suite que des algorithmes de tri présentent une complexité supérieure ($O()$) dans cette même borne, et sont donc optimaux en ce sens ($\Theta()$).

[^aggarwal88]: AGGARWAL, Alok, VITTER, Jeffrey, et al. The input/output complexity of sorting and related problems. Communications of the ACM, 1988, vol. 31, no 9, p. 1116-1127.
[^vitter98]: VITTER, Jeffrey Scott. External memory algorithms. In : European Symposium on Algorithms. Springer, Berlin, Heidelberg, 1998. p. 1-25.
[^brodal03]: BRODAL, Gerth Stølting et FAGERBERG, Rolf. On the limits of cache-obliviousness. In : Proceedings of the thirty-fifth annual ACM symposium on Theory of computing. ACM, 2003. p. 307-315.