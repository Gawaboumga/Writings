# Cache-oblivious

Lorsqu'on aborde les thèmes liés à l'I/O complexité, le modèle *cache-oblivious* émerge comme un véritable chef d'œuvre. Introduit en 1999 par Matteo Frigo, Charles E. Leierson, Harald Prokop et Sridhar Ramachandran[^frigo99], il est semblable au modèle EM mais propose une différence fondamentale. On ne connaît ni la taille de $B$ ni de $M$, ces éléments seront employés a posteriori pour analyser la complexité de l'algorithme, l'algorithme n'en a pas conscience. Cette notion est très forte parce qu'elle implique que l'algorithme est optimal de manière globale et donc sous n'importe quelle circonstance, peu importe les valeurs de $B$ ou de $M$. Cette notion d'*obliviousness* a évidemment été portée à d'autres complexités (temporelle ou réseau).

## Propriétés

Nous allons parcourir brièvement certains résultats issus de ce modèle afin de vous donner l'essence de la beauté mais nous ne nous attarderons pas en profondeur.

### Parcours

Parcourir $N$ éléments reste en $O(\frac{N}{B})$. Seulement, il devient plus difficile d'en effectuer plusieurs en parallèle puisque nous ne connaissons pas la taille du cache. Des petites constantes sont donc envisageables.

### Recherche

Pour rechercher un élément dans une collection triée, nous pourrions employer un *B-tree*. Seulement, celui-ci n'est plus optimal dans ce modèle de calcul, pas sans modification.

-> ![Disposition de van Emde Boas](/media/galleries/5209/0305965e-5738-456a-a42e-38a656d74aa6.png) <-

L'idée est de créer un arbre binaire (puisque nous ignorons $B$) et de diviser récursivement les données de sorte que le sommet contienne $\sqrt{N}$ éléments et que les $\sqrt{N}$ restes contiennent les $\sqrt{N}$ données. Nous stockons le sommet et puis chacun des enfants à la suite en mémoire. Nous effectuons cette opération de découpage jusqu'à des éléments uniques, cette disposition est qualifiée de [Van Emde Boas](https://fr.wikipedia.org/wiki/Peter_van_Emde_Boas). Entre temps, nous aurons croisé des sous-ensembles ayant une taille légèrement inférieure ou égale à $B$. La question consiste à se demander combien de triangles de taille au maximum $B$ doit-on traverser afin d'atteindre les feuilles ? Nous savons que la taille de ceux-ci est au moins $\frac{1}{2} \log B$ puisqu'en subdivisant, on risque de rater la taille de $B$ d'un facteur de 2. Ensuite, chaque bloc peut être mal aligné et être placé à l'intersection de 2 blocs. Au final, nous obtenons $O(4 \log_{B} N)$. Il est toutefois possible de décrire des *B-trees* dynamiques atteignant la borne optimale[^bender03].

### Tri fusion

Il est possible de définir l'équivalent du tri fusion dans un modèle *cache-oblivious*. L'algorithme s'appelle le « *funnel sort* » et se base sur la construction de « *funnel* » qui permette de fusionner $k$ listes triées de taille $\Theta(k^{3})$ en $O(\frac{k^{3}}{B} \log_{\frac{M}{B}} \frac{k}{B} + k)$.

L'idée est assez farfelue, on définit récursivement les *funnels* comme étant composé de *sous-funnels*. De telle sorte qu'on arrive au final à la fusion de 2 listes simples. La récursion est toujours la clef en algorithmie !

-> ![Fonctionnement du funnel sort](/media/galleries/5209/f033260b-ac43-4e77-bfee-d567f4a5dd69.png) <-

### Un peu de recul

Le modèle *cache-oblivious* est simple et élégant. En s'affranchissant explicitement des paramètres relatifs au cache, on obtient des résultats très généraux et les algorithmes deviennent optimaux par rapport à n'importe quelle configuration.  Cela permet, par la même occasion, de supprimer les problèmes qui émergent avec des hiérarchies de caches d’un seul tenant puisqu’on sait que la situation est optimale entre chaque paire.

En pratique, on connaît (ou tout du moins, on a des bonnes idées sur) la configuration sur laquelle on va faire tourner l’algorithme. On peut donc affiner au mieux les paramètres de l'algorithme EM et battre les *cache-oblivious*. On peut d'ailleurs tenter de quantifier le gain d’information théorique que l’on a lorsqu’on connaît les paramètres du problème a priori mais il est somme toute faible[^bender03].

Seulement, le problème majeur est que les algorithmes *cache-oblivious* sont des monstruosités à programmer alors que les EM sont nettement plus commodes à implémenter. La récursivité est un point crucial pour ce type d'algorithmes et permet d'offrir des solutions d'une simplicité remarquable à des problèmes pourtant complexes. Mais ces belles récursions entraînent des détails d'implémentation très techniques. Pour s’en convaincre, il suffit d’écrire un algorithme qui fusionne un nombre arbitraire de listes triées, on se confronte très vite à un mur.

[^frigo99]: FRIGO, Matteo, LEISERSON, Charles E., PROKOP, Harald, et al. Cache-oblivious algorithms. In : Foundations of Computer Science, 1999. 40th Annual Symposium on. IEEE, 1999. p. 285-297.
[^bender03]: BENDER, Michael A., BRODAL, Gerth Stølting, FAGERBERG, Rolf, et al. The cost of cache-oblivious searching. In : Foundations of Computer Science, 2003. Proceedings. 44th Annual IEEE Symposium on. IEEE, 2003. p. 271-282.