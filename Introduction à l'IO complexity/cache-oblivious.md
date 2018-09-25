# Cache oblivious

Lorsqu'on aborde les thèmes liées à l'I/O complexité, le modèle cache oblivious émerge comme un véritable chef d'oeuvre. Introduit en 1999 par Matteo Frigo, Charles E. Leierson, Harald Prokop et Sridhar Ramachandran[^frigo99], il est semblable au modèle EM mais propose une différence fondamentale. On ne connaît ni la taille de $B$ ni de $M$, ces éléments seront employés a posteri pour analyser la complexité de l'algorithme, l'algorithme n'en a pas conscience. Cette notion est très forte parce qu'elle implique que l'algorithme est optimal de manière globale et donc sous n'importe quelle circonstance, peu importe les valeurs de $B$ ou de $M$. Cette notion d'obliviousness a évidemment été portée à d'autres complexités (temporelles ou réseau).

## Propriétés

Nous allons parcourir brièvement certains résultats issus de ce modèle afin de vous donner l'essence de la beauté mais nous ne nous attarderons pas en profondeur.

### Parcours

Parcourir $N$ éléments reste en $O(\frac{N}{B})$. Seulement, il devient plus difficile d'en effectuer plusieurs en parallèle puisque nous ne connaissons pas la taille du cache. Des petites constantes sont donc envisageables.

### Recherche

Pour rechercher un élément dans une collection triée, nous pourrions employer un B-tree. Seulement, celui-ci n'est plus optimal dans ce modèle de calcul, pas sans modification.

-> ![Disposition de van Emde Boas](/media/galleries/5209/0305965e-5738-456a-a42e-38a656d74aa6.png) <-

L'idée est de créer un arbre binaire (puisque nous ignorons $B$) et de diviser récursivement les données de sorte que le sommet contienne $\sqrt{N}$ éléments et que les $\sqrt{N}$ restes contiennent les $\sqrt{N}$ données. Nous stockons le sommet et puis chacun des enfants à la suite en mémoire. Nous effectuons cette opération de découpage jusqu'à des éléments uniques. Entre temps, nous aurons croisé des sous-ensembles ayant une taille légèrement inférieure ou égale à $B$. La question consiste à se demander combien de triangles de taille au maximum $B$ doit-on traverser afin d'atteindre les feuilles ? Nous savons que la taille de ceux-ci est au moins $\frac{1}{2} \log B$ puisqu'en subdivisant, on risque de rater la taille de $B$ d'un facteur de 2. Chaque bloc peut être mal aligné et être placé à l'intersection de 2 blocs. Au final, nous obtenons $O(4 \log_{B} N)$. Il est toutefois possible de décrire des B-trees dynamiques atteignant la borne optimale[^bender03].

### Tri fusion

Il est possible de définir l'équivalent du tri fusion dans un modèle cache-oblivious. L'algorithme s'appelle le "funnel sort" et se base sur la construction de "funnel" qui permette de fusionner $k$ liste triée de taille $\Theta(k^{3})$ en $O(\frac{k^{3}}{B} \log_{\frac{M}{B}} \frac{k}{B} + k)$.

L'idée est assez farfelue, on définit récursivement les funnel comme étant composé de sous-funnels. De telle sorte qu'on arrive au final à la fusion de 2 listes simples.

-> ![Fonctionnement du funnel sort](/media/galleries/5209/504eacd3-e6f6-4737-a94a-f72ab39a9cdb.png) <-

[^frigo99]: FRIGO, Matteo, LEISERSON, Charles E., PROKOP, Harald, et al. Cache-oblivious algorithms. In : Foundations of Computer Science, 1999. 40th Annual Symposium on. IEEE, 1999. p. 285-297.
[^bender03]: BENDER, Michael A., BRODAL, Gerth Stølting, FAGERBERG, Rolf, et al. The cost of cache-oblivious searching. In : Foundations of Computer Science, 2003. Proceedings. 44th Annual IEEE Symposium on. IEEE, 2003. p. 271-282.