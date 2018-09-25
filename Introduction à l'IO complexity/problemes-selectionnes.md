# Certains problèmes sélectionnés

Il existe une quantité astronomique de problèmes étudiés dans ce modèle de calcul, nous en avons sélectionné certains qui nous semblaient plus remarquables ou intéressants. Nous sommes très loin d'être exhaustifs.

## Algorithmes sur les matrices

Lorsqu'on considère des algorithmes sur les matrices, il est nécessaire de considérer la manière dont les éléments sont positionnés en mémoire. Pour les matrices denses, on distingue généralement trois formes:

- Par colonne: Les éléments sont d'abord ordonnés par colonnes et puis par lignes et ce dans une même colonne.
- Par ligne: Les éléments sont ordonnés par lignes et puis par colonnes.
- Récursif ou zig-zag: Cette disposition particulière est souvent employée afin de construire des algorithmes optimaux. Nombreux théorèmes impliquent une courbe remplissant l'espace de manière récursive afin de déterminer l'ordre des éléments.

### Transposition de matrice

> Transposer une matrice $N = N_{x} * N_{y}$ requiert $\Theta(\frac{N}{B} \log_{\frac{M}{B}} \text{min} \{ M, N_{x}, N_{y}, N \})$.

Ce résultat n'est pas tellement étonnant, il faut se convaincre qu'une transposition de matrice est un cas particulier de permutation, surtout lorsque $B$ est relativement grand ($\approx \frac{1}{2} M$) et $N$ est en $O(M^{2})$. Pour des $B$ plus petits, la structure spéciale de la permutation associée à la transposition rend l'opération plus simple. En effet, la matrice peut être divisée en sous-matrices qui contiennent $B^{2}$ éléments, afin que chaque sous-matrice contienne $B$ blocs en ligne ainsi que $B$ blocs en colonne. Ainsi, si $B^{2} < M$, la transposition peut être effectuée une seule passe en transposant les sous-matrices directement en mémoire interne.

Mais ce n'est peut-être pas le résultat principal. En effet, la transposition de matrice est également un cas particulier d'une classe plus générale de permutation et dite "bit-permute/complement" (BPC), qui est lui-même un sous-ensemble des "bit-matrix-multiply/complement" (BMMC). En résumant de manière très concise, il est possible d'exprimer les permutations en terme d'une matrice de permutations (pas forcément unitaire). Cette forme est également capable d'exprimer d'autres problèmes, notamment les problèmes posés sur des DAG. Cormen et al.[^cormen98] ont obtenu un résultat prodigieux:

> Le nombre de transferts requis pour effectuer une permutation BMMC définie par une matrice $A$ et un vecteur $c$ est:

$$ \Theta(\frac{N}{B} (1 + \frac{rank(\gamma)}{\log \frac{M}{B}})) $$

où $\gamma$ est la sous-matrice $\log \frac{N}{B} \times \log B $ située dans le coin inférieur gauche de $A$. Ce résultat peut sembler anecdotique, mais représente une avancée majeure. Jusqu'à présent, la complexité était essentiellement démontrée de manière "existentielle", c'est à dire qu'il existait au moins une instance du problème qui nécessitait cette complexité. Ici, le résultat est dit "universel", la complexité est déterminée par une catégorisation de l'instance du problème.

### Multiplication de matrices

Si nous appliquons l'algorithme classique de multiplication de matrices, avec la première en ligne et la seconde en colonne. Nous devrions, pour chacun des éléments, effectuer deux parcours, ce qui aboutirait à une complexité en $O(\frac{N^{3}}{B})$, ce qui n'est pas optimal. En effet, il est possible d'atteindre $\Theta(\frac{N^{3}}{B\sqrt{M}})$[^ballard12], ce qui coïncide avec le résultat de Hong et Kung. Il faut remarquer que lors d'une multiplication classique, les mêmes lignes et colonnes sont lues de nombreuses fois, ce qui est évidemment inefficace. La solution consiste à stocker les éléments des matrices de manière récursive, chaque fois subdivisant les quatre coins les uns après les autres afin d'obtenir une disposition proche de: $\text{layout}(Z) = \text{layout}(Z_{11})\text{layout}(Z_{12}) ... \text{layout}(Z_{22})$.

La complexité est décrite par ce système:
$$
\left\{
    \begin{array}{ll}
        MT(N) = 8MT(\frac{N}{2}) + O(\frac{N^{2}}{B}) \\
        MT(\sqrt{\frac{M}{3}}) = O(\frac{M}{B})
    \end{array}
\right.
$$

En effet, chaque coin de la matrice résultante peut être obtenue comme la somme du produit des deux sous-matrices, comme il existe 4 coins avec 2 produits ($Z_{11} = X_{11}*Y_{11} + X_{12}*Y_{21}$), nous avons 8 récursions. Les sommations sont indépendantes de la récursion et coûte $O(\frac{N^{2}}{B})$ vu que nous devons effectuer le parcours en $X$ et en $Y$. Finalement, lorsque les matrices peuvent être entièrement contenues dans la mémoire interne, et qu'elles sont stockées de manière continue, le pire cas consisterait à parcourir chacun des blocs, $O(\frac{M}{B})$. Maintenant, grâce au Master Theorem, nous devons compter le nombre de feuilles puisque le coût de la somme est plus petit que celui de la récursion, il y a donc $8^{\log N / \sqrt{M / 3}} = (N / \sqrt{M / 3})^{3}$ feuilles. Le coût total est donc déterminé par:

$$ (\frac{N}{\sqrt{M / 3}})^{3} O(\frac{M}{B}) = \Theta(\frac{N^{3}}{M^{3/2}}) O(\frac{M}{B}) = \Theta(\frac{N^{3}}{B\sqrt{M}}) $$

# Algorithmes sur les graphes

Les algorithmes sur les graphes représentent une vrai difficulté pour l'I/O complexité. En effet, des algorithmes optimaux, par rapport au modèle RAM, ne semblent pas toujours possibles. Chiang et al.[^chiang95] ont d'ailleurs conjecturé une certaine équivalence entre les complexités liés à l'I/O et le parallélisme, suite aux nombreux problèmes facilement parallélisables issus d'algorithmes I/O.

## Classement de liste

> Étant donné une liste d'éléments $N$, chacun identifié par une adresse unique (identifiant) et pointant vers son successeur. Le but est de définir le rang de chaque élément, où le rang correspond au nombre d'éléments entre la tête de liste et l'élément.

Étonnamment, la complexité du classement de liste est en $\Theta(\frac{N}{B} \log_{\frac{M}{B}} \frac{N}{B})$ et est donc aussi complexe que de trier une collection en raison de la difficulté de transférer l'information et de son lien étroit (et loin d'être évident) avec le problème de permutation.

L'idée principale consiste à créer des ensembles indépendants via 3-coloring (sous-ensembles de taille $\frac{N}{3}$) et son algorithme des arêtes avant/arrière ou via un tirage au sort déterministe (sous-ensembles de taille $\frac{N}{4}$, "deterministic coin tossing"), résoudre les sous-problèmes et recomposer la solution. Cette opération de décomposition et de reconstruction de la liste est appelée brigde-out/in, elle consiste à faire une copie de la liste originale, à trier la liste originale par l'identifiant du successeur, à parcourir l'original et la copie en même temps pour obtenir l'information sur le successeur et à trier de nouveau la liste originale modifiée par son identifiant.

3-coloring peut être fait comme suit, on colore alternativement les pointeurs avant en rouge et bleu, et en arrière, en vert et bleu; chaque nœud aura une couleur à l'exception de tête/queue qui peuvent en avoir deux, il ne reste plus qu'à les colorier de la couleur de la tête de liste. En pratique, nous devons mettre les nœuds dans une file à priorité basée sur l'index, parce que nous ne pouvons accéder aux éléments dans n'importe quel ordre, cela entraînerait trop de transferts, et une file à priorité peut avoir une complexité en $O(\frac{1}{B}\log_{\frac{M}{B}} \frac{N}{B})$ par élément et par opération (Buffer-tree).

## Tour eulérien

Le problème précédent vous aura sans doute laisser quelques peu nébuleux. Mais il est employé comme base pour de nombreux algorithmes et souvent combiné avec la notion de tour eulérien. Le tour eulérien a été introduit par Robert E. Tarjan et Uzi Vishkin[^tarjan85], il est défini comme étant être capable de faire le tour d'un graphe en visitant chaque arête exactement deux fois, et ce, dans les deux directions. l'idée sous-jacente est que nous pouvons employer un algorithme de type all-prefix-sum (ou scan) sur le tour eulérien. Ceci permet de représenter des graphes comme des collections plates d'éléments et ainsi appliquer nos techniques plus avancées. La conséquence est également qu'un arbre peut être traité d'une même manière, malgré qu'il soit dégénéré sous la forme d'une liste.

Par exemple, le problème du plus petit ancêtre commun (lowest common ancestor - LCA), qui consiste à, étant deux nœuds $v$ et $w$ dans un arbre $T$, trouver le nœuds le plus bas dans l'arbre qui possède $v$ et $w$ commes descendents. Ce problème peut également être réduit à celui de requête du plus petit dans un intervalle (range minimum query - RMQ). Dans l'exemple suivant, nous effectuons un parcours préfixe où nous notons les nœuds visités d'un part et la profondeur associée d'autre part. Par exemple, le LCA de 7 et 5 revient à chercher le RMQ dans l'intervalle associé: 2101, la réponse est donc 0, soit le nœud 3.

-> ![Tour eulérien](/media/galleries/5209/4e6735b0-cea2-4ab1-bd85-398e91d9b7ed.png) <-

## Techniques généralistes sur les graphes

Vous pouvez aisément imaginer que déterminer l'I/O complexité sur des graphes posent quelques problèmes. On peut imaginer des réductions vers des problèmes de matrices par le biais des matrices d'adjacence mais la complexité en pâtirait très certainement. Certains outils et techniques ont été développés afin d'étudier ces problèmes. Généralement, il s'agit d'extensions de notions algorithmiques avancées. Nous ne ferons, encore une fois, qu'effleurer un sujet tellement vaste.

Une bonne partie des algorithmes sur les graphes se reposent sur la construction d'une structure de données auxiliaires afin de résoudre le problème. La clef réside dans ces fameux *Buffer (repository) tree* (BRT) qui correspondent grossièrement à de simples B-tree, où un *buffer* d'opérations est ajouté à chaque nœud afin d'amortir son coût. Celles-ci sont donc effectuées uniquement lorsque ce *buffer* est rempli. On peut prouver que la complexité amortie d'une insertion est bornée par: $O(\frac{1}{B}\log_{\frac{M}{B}} \frac{N}{B})$ et d'une extraction l'est par: $O(\log_{\frac{M}{B}} \frac{N}{B} + \frac{S}{B})$ où $S$ désigne la taille de l'ensemble retourné[^buchsbaum00].

### Parcours en profondeur sur un graphe dirigé

Nous pouvons maintenant étudier la complexité d'un *directed DFS*. Nous commencerons par rappeler qu'un DFS consiste à placer sur la pile le premier sommet, ajouter ceux adjacents et qui n'ont pas déjà été visités et recommencer la procédure avec le sommet de la pile jusqu'à ce qu'elle soit vide. Les opérations de pile coûtent naturellement (et de manière amortie) $O(\frac{1}{B})$ par élément; le problème consiste donc à trouver les sommets non visités. L'astuce consiste à introduire deux autres structures de données, un Buffer tree qui s'occupera de stocker toutes les arêtes $(v, w)$ par la clef $v$ et une file à priorité par sommet afin de conserver les arêtes sortantes non encore explorées. L'invariant consiste à ce que, à tout instant et ce pour chaque sommet, les arêtes présentent dans la file à priorité et absentes du Buffer tree pointent vers des sommets non visités.

Cet algorithme s'en suit à chaque fois qu'on possède un nouveau sommet $v$ (le premier ou sur la pile):
- On commence par extraire toutes les arêtes ayant pour clef $v$. $O(|V| \log_{\frac{M}{B}}\frac{|E|}{B} + \frac{|E|}{B})$
- On supprime ces arêtes des files à priorité. Celles-ci conservent alors uniquement des arêtes vers des sommets non visités. $O(|V| + \text{sort}(|E|))$
- Si la file à priorité du sommet $v$ est vide, il faut revenir en arrière dans la parcours (extraction du sommet de la pile).
- Sinon, on extrait le minimum de la file à priorité liée à $v$ et on se retrouve avec l'arête $(v, w)$. $O(\text{sort}(|E|))$
- On place $w$ sur la pile. $O(\frac{|V|}{B})$
- Les arêtes menant à $w$ sont recherchées $(x, w)$ et insérées dans le Buffer tree selon $x$. $O(\frac{|E|}{B} \log_{\frac{M}{B}} \frac{|E|}{B}))$

$$ O((|V| + \frac{|E|}{B}) \log_{\frac{M}{B}} \frac{|E|}{B})) $$

L'algorithme est essentiellement le même dans le cas d'un parcours en largeur même si les files à priorité ne sont plus indispensables puisqu'on visite les sommets exactement une fois ;-) Étonnamment, sur un graphe non dirigé, un BFS peut être effectué en $O(|V| + \text{sort}(|E|))$ de manière déterministe et dans des complexités étranges (fonction du diamètre du graphe) de manière (plus ou moins) non déterministe[^mehlhorn02].

### Plus court chemin

Une autre avancée majeure fut la résolution des problèmes de plus courts chemins. Et notamment, celui à source unique (SSSP) et qui correspond à Dijkstra. L'idée était d'introduire des *Tournament tree*[^kumar96], suite au fait que les Buffer tree ne peuvent supporter l'opération de réduction des clefs (*DecreaseKey*), essentielle à l'algorithme. Ils ont l'avantage de supporter cette fameuse opération mais ajoutent un surcoût de $\log_{2} \frac{M}{B}$ aux opérations (par rapport au Buffer tree). Brièvement, ce tournament tree est un arbre binaire fixe avec $\frac{N}{M}$ feuilles et, à chaque nœud, on retrouve un buffer de taille $M$ qui contient tous les éléments ayant une priorité plus faible dans le sous-arbre. Il existe également un buffer qui permet d'effectuer des signaux pour mettre à jour les clefs.

Il suffit ensuite d'appliquer l'algorithme classique sur cette structure de données. Seulement, il y aurait un petit problème et une modification doit y être apportée afin d'obtenir une meilleure complexité. En effet, Dijkstra demande de vérifier si un des sommets voisins est terminal afin d'effectuer l'opération de réduction des clefs. La solution consiste à introduire une opération de mise à jour sur les voisins directs (excepté le parent) mais ceci entraîne un nouveau problème lié à la seconde visite d'un même sommet[^kumar96]. Bref, c'est compliqué ^^. Au final, il est quand même possible d'obtenir:

$$ O(|V| + \frac{|E|}{B} \log \frac{|E|}{B}) $$

### Autres notions

De nombreux autres notions et outils ont été créés en algorithmique afin de répondre à moultes questions. Nous penserons notamment au partitionnement de graphes, qui a permis d'aider au problème de SSSP sur des graphes planaires[^maheshwari02]. Au ratissage et compressage (rake and compress) introduit dans un très long article originellement pour le parallélisme[^miller89]. Ou encore, une notion connexe appelée: block-cut point tree et qui possède certains structures mathématiques intéressantes[^kulli76].

Nous terminerons par insister sur le fait que nous n'avons en aucun cas aborder la notion de complexité optimale pour ces algorithmes. Ceux-ci sont encore sujets à nombreuses questions et certaines bornes théoriques restent encore très floues et fort dépendantes de la structure du graphe. Cela reste des problèmes ouverts.

[^cormen98]: CORMEN, Thomas H., SUNDQUIST, Thomas, et WISNIEWSKI, Leonard F. Asymptotically tight bounds for performing BMMC permutations on parallel disk systems. SIAM Journal on Computing, 1998, vol. 28, no 1, p. 105-136.
[^ballard12]: BALLARD, Grey, DEMMEL, James, HOLTZ, Olga, et al. Graph expansion and communication costs of fast matrix multiplication. Journal of the ACM (JACM), 2012, vol. 59, no 6, p. 32.
[^chiang95]: CHIANG, Yi-Jen, GOODRICH, Michael T., GROVE, Edward F., et al. External-Memory Graph Algorithms. In : SODA. 1995. p. 139-149.
[^tarjan85]: TARJAN, Robert E. et VISHKIN, Uzi. An efficient parallel biconnectivity algorithm. SIAM Journal on Computing, 1985, vol. 14, no 4, p. 862-874.
[^buchsbaum00]: BUCHSBAUM, Adam L., GOLDWASSER, Michael H., VENKATASUBRAMANIAN, Suresh, et al. On external memory graph traversal. In : SODA. 2000. p. 859-860.
[^mehlhorn02]: MEHLHORN, Kurt et MEYER, Ulrich. External-memory breadth-first search with sublinear I/O. In : European Symposium on Algorithms. Springer, Berlin, Heidelberg, 2002. p. 723-735.
[^kumar96]: KUMAR, Vijay et SCHWABE, Eric J. Improved algorithms and data structures for solving graph problems in external memory. In : Parallel and Distributed Processing, 1996., Eighth IEEE Symposium on. IEEE, 1996. p. 169-176.
[^maheshwari02]: MAHESHWARI, Anil et ZEH, Norbert. I/O-optimal algorithms for planar graphs using separators. In : Proceedings of the thirteenth annual ACM-SIAM symposium on Discrete algorithms. Society for Industrial and Applied Mathematics, 2002. p. 372-381.
[^miller89]: MILLER, Gary L. et REIF, John H. Parallel Tree Contraction--Part I: Fundamentals. 1989.
[^kulli76]: KULLI, V. R. et BIRADAR, M. S. The point block graph of a graph. Journal of Computer and Mathematical Sciences Vol, 2014, vol. 5, no 5, p. 412-481.