#Théorème de  Myhill-Nerode

En théorie des langages, il existe un très joli théorème prouvé par J. Myhill et A. Nerode en 1958[^1]. Il donne une condition nécessaire et suffisante pour qu'un langage formel soit un langage rationnel. Le grand résultat de ce théorème est que la condition s'applique sur le langage en lui-même et non sur l'automate fini qui peut le reconnaître. Il définit également une notion fort intéressante.

Son énoncé initial est complexe et je reprendrai donc la formulation proposée par Wikipédia[^2]:

> Un langage $L$ est rationnel si et seulement si la relation $R_{L}$ est d'index fini ; dans ce cas, le nombre d'états du plus petit automate déterministe complet reconnaissant $L$ est égal à l'index de la relation. En particulier, ceci implique qu'il existe un automate déterministe unique avec un nombre minimal d'états.

Tout d'abord, étendons-nous sur la notion de relation à index fini. Myhill & Nerode propose une relation d'équivalence - un opérateur - noté classiquement $ \equiv $ et ayant pour signification que si $A \equiv B$, alors le langage issu de $A$ est le même que $B$, que les suffixes sont équivalents. Exemple: Considérons les langages $A = \{ a, aa, ab \}$ et $B = \{ b, ba, bb \}$, ils sont "équivalents" à partir du premier caractère lu, tous deux acceptent le sous-langage $\{ \epsilon, a, b \}$.

On dit que, étant donné un langage $L$, et une paire de mots $x$ et $y$, on dit que $z$ sépare $x$ et $y$ si un et un seul des mots $xz$ et $yz$ est dans le langage $L$. On définit la relation $R_{L}$ sur les mots telle que $x R_{L} y$ s'il n'y a pas d'extension distinguable pour $x$ et $y$, s'il n'existe pas de $z$ qui les sépare. La relation $R_{L}$ définit une relation d'équivalence et divise l'ensemble des mots en classes d'équivalence. Ce nombre de classes est appellé index de la relation.

Ce théorème établit qu'un langage est rationnel si et seulement si, l'opérateur $R_{L}$ possède un nombre fini de classes d'équivalence. De plus, le nombre minimal d'états nécessaires dans le plus petit automate fini déterministe qui reconnaît ce langage est égale à ce nombre de classes.

Il est peut-être plus simple pour certaines personnes de voir cette propriété au travers des automates finis. Mais, d'abord, définissons l'équivalence entre états: soit $q_{1}$ et $q_{2} \in Q$, $q_{1}$ est équivalent à $q_{2}$ (noté $q_{1} \equiv q_{2}$) si et seulement si $L(A, q_{1}) = L(A, q_{2})$. Le langage accepté depuis ces deux états est le même.

Il reste alors à construire cet automate minimal, il existe plusieurs algorithmes classiques, les plus classiques étant ceux de Brzozowski[^3] et de Hopcroft[^4]. Mais il en existe plusieurs[^5] parce que ce problème présente de nombreux intérêtes en théorie de la complexité.

[^1]: Nerode, A. (1958). Linear automaton transformations. Proceedings of the American Mathematical Society, 9(4), 541-544.
[^2]: https://fr.wikipedia.org/wiki/Th%C3%A9or%C3%A8me_de_Myhill-Nerode
[^3]: Brzozowski, J. A. (1962). Canonical regular expressions and minimal state graphs for definite events. Mathematical theory of Automata, 12(6), 529-561.
[^4]: Hopcroft, J. E., Motwani, R., & Ullman, J. D. (2006). Automata theory, languages, and computation. International Edition, 24.
[^5]: Watson, B. W. (1993). A taxonomy of finite automata minimization algorithms.