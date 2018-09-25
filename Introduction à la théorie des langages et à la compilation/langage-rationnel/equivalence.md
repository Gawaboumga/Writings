# Théorème de Kleene

Pour le moment, nous avons vu trois notions: les langages rationnels, les expressions rationnelles et les automates finis. Il est donc naturel de se demander quels sont les liens qui les unissent. Heureusement pour nous, il existe un beau théorème informatique dit de "Kleene" qui dit:

> Pour tout langage rationnel $L$, il existe un *DFA* $A$ tel que $L(A) = L$. Et réciproquement, pour tous les *NFA-$\epsilon$* $A, L(A)$ est rationnel.

En d'autres mots, l'ensemble des automates finis reconnaîssent tous les langages rationnels et tous ceux-ci peuvent être reconnus par un automate fini.

La démonstration s'effectue en trois phases de preuve d'équivalence:

## Expression rationnelle vers *NFA-$\epsilon$*: Construction de Thompson

Il existe beaucoup de manière de construire des automates[^1], mais la plus célèbre est sans doute celle de Thompson[^2], basée sur une idée antérieure[^3]:

L'automate est construit inductivement avec, à chaque fois, $L(A_{r}) = L(r)$ et possède un seul et un seul état acceptant.

On a trois cas de bases:

+---------------------+-------------------+
| Regex               | *NFA-$\epsilon$*  |
+=====================+===================+
| $\emptyset$         |  -                |
+---------------------+-------------------+
| $\epsilon$          |  -                |
+---------------------+-------------------+
| $\sigma \in \Sigma$ |  -                |
+---------------------+-------------------+

Et maintenant, les opérations de disjonction, concaténation et de clôture de Kleene:

+---------------------+-------------------+
| Regex               | *NFA-$\epsilon$*  |
+=====================+===================+
| $ r_{1} + r_{2} $   |  -                |
+---------------------+-------------------+
| $ r_{1} . r_{2} $   |  -                |
+---------------------+-------------------+
| $ r_{1}^{*} $       |  -                |
+---------------------+-------------------+

## *NFA-$\epsilon$* vers *DFA*: Construction par sous-ensembles

Le non-déterminisme présente un grand désavantage pour nos ordinateurs déterministes. Même s'il est possible de simuler l'exécution d'un automate fini non déterministe, il est nettement plus simple de simuler un déterministe où la complexité sera directement en relation avec la taille du mot en entrée.

L'idée est de simuler, avec chacun des états du *DFA*, l'ensemble des états dans lequel le *NFA* peut être. Il faut donc retenir, d'un certaine manière, cet ensemble d'états qui servira de "mémoire". Ce concept nous vient directement de Rabin & Scott[^4].

Avant de continuer, il serait bon de donner deux définitions supplémentaires. Tout d'abord, nous pouvons étendre la fonction de transition pour l'appliquer à un ensemble d'états. Cela devient très logiquement, avec $S$ l'ensemble d'états et $\sigma$ un lettre de $\Sigma$:
$$ \delta(S, \sigma) = \bigcup\limits_{q \in S} \delta(q, \sigma) $$

Et deuxièmement, la $\epsilon$-clôture (*$\epsilon$-closure*) est une fonction qui prend pour entrée un état de la machine et retourne l'ensemble des états accessibles depuis celui-ci, en ne lisant que $\epsilon$.

Pour tout $i \in \mathbb{N}$, on définit $\epsilon$-$closure^{i}(q)$ comme:

$$ 
\epsilon\text{-}closure^{i}(q) =  
\begin{cases}
	\{ q \} ~  \text{if } i = 1\\
	\delta(\epsilon\text{-}closure^{i-1}(q), \epsilon) \cup \epsilon\text{-}closure^{i-1}(q) & \text{otherwise}
\end{cases}
$$

Et donc, on a pour tout $q \in Q$, $\epsilon\text{-}closure(q) = \epsilon\text{-}closure^{K}(q)$ lorsque $\epsilon\text{-}closure^{K}(q) = \epsilon\text{-}closure^{K+1}(q)$.

Il "suffit" alors de construire un *DFA* $D = \langle Q^{D}, \Sigma, \delta^{D}, q_{0}^{D}, F^{D} \rangle$ en fonction d'un *NFA-$\epsilon$* $N = \langle Q^{N}, \Sigma, \delta^{N}, q_{0}^{N}, F^{N} \rangle$ avec:

1. $ Q^{D} = 2^{Q^{N}} $
1. $ q_{0}^{D} = \epsilon\text{-}closure(q_{0}^{N}) $
1. $ F^{D} = \{ S \in Q^{D} | S \cap F^{N} \ne \emptyset \} $
1. $ \forall S \in Q^{D}, \forall \sigma \in \Sigma: \delta^{D}(S, \sigma) = \epsilon\text{-}closure(\delta^{N}(S, \sigma)) $

On peut montrer que les langages sont les mêmes, en employant ce théorème de Rabin & Scott[^4]:

> Pour tout *NFA-$\epsilon$*, le *DFA* D obtenu par déterminisation $N$ accepte la même langage que $N$: $L(N) = L(D)$.

Seulement, cette conversion a un coût, au maximum, l'automate déterministe aura $2^{n}$ états si le non-déterministe en avait $n$[^5] parce qu'on pourrait obtenir tous les sous-ensembles de ces états. Les exemples classiques de mauvais comportement sont les langages telles que la n-ième lettre depuis la fin est un "1" ou deux "1" sont séparés par n caractères et sont liés à la notion des automates finis inambigus (*UFA*).

## Un exemple

Au départ, nous prenons l'$\epsilon\text{-}closure(q_{0})$, nous obtenons: \{ 1, 2, 3 \}. Maintenant, où pouvons-nous aller depuis cet ensemble:

+---------------+------------+--------------+
| States        | 0          | 1            |
+===============+============+==============+
| \{ 1, 2, 3 \} | \{ 2, 4 \} | \{ 2, 4 \}   |
+---------------+------------+--------------+
| \{ 2, 4 \}    | \{ 2, 3 \} | \{ 2, 4 \}   |
+---------------+------------+--------------+
| \{ 2, 3 \}    | \{ 2, 4 \} | \{ 4 \}      |
+---------------+------------+--------------+
| \{ 4 \}       | \{ 2, 3 \} | $\emptyset$  |
+---------------+------------+--------------+

Au final, on obtient:



## *NFA-$\epsilon$* vers expression rationnelle: Élimination d'états

Finalement, il ne nous reste plus qu'à terminer notre boucle en convertissant les *NFA-$\epsilon$* (et en particulier les *DFA*) en expression rationnelle. Il existe plusieurs techniques pour effectuer cette tâche, nous en verrons une, celle de Brzozowski \& McCluskey[^6] qui s'appelle, généralement, l'élimination d'états (ou assassinat politique ;-)).

L'idée est de supprimer un à un les états de l'automate en convertissant les transitions en expression rationnelle, jusqu'à n'avoir que deux états, l'initial et l'acceptant. Le formalisme est relativement complexe et nous ne présenterons qu'un exemple afin de donner une bonne perception sur la technique à employer.

Voici l'automate qu'on veut convertir, on commence par associer une expression rationnelle à chaque transition:


Première étape, on retire $q_{1}$, on concatène les expressions rationnelles et si plusieurs transitions mènent au même endroit, on prend la disjonction ce celles-ci:

Maintenant, on retire $q_{2}$:

Et finalement, on obtient:


L'expression rationnelle correspondant est donc:

$$ (1.1 + 0.0.1)^{*} + (1 + 0.0)^{*}.1^{*} $$


Citons également la conversion de Arden[^7] qui est liée à un tout autre concept et qui se base sur un système d'équations.

[^1]: Watson, B. W. (1993). A taxonomy of finite automata construction algorithms.
[^2]: Thompson, K. (1968). Programming techniques: Regular expression search algorithm. Communications of the ACM, 11(6), 419-422.
[^3]: McNaughton, R., & Yamada, H. (1960). Regular expressions and state graphs for automata. IRE transactions on Electronic Computers, (1), 39-47.
[^4]: Rabin, M. O., & Scott, D. (1959). Finite automata and their decision problems. IBM journal of research and development, 3(2), 114-125.
[^5]: Sipser, M. (2006). Introduction to the Theory of Computation (Vol. 2). Boston: Thomson Course Technology.
[^6]: Brzozowski, J. A., & McCluskey, E. J. (1963). Signal flow graph techniques for sequential circuit state diagrams. IEEE Transactions on Electronic Computers, (2), 67-76.
[^7]: Arden, D. N. (1961, October). Delayed-logic and finite-state machines. In Switching Circuit Theory and Logical Design, 1961. SWCT 1961. Proceedings of the Second Annual Symposium on (pp. 133-151). IEEE.
