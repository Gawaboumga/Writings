#Conclusion

Il ne reste plus qu'à conclure ce chapitre en présentant les opérations possibles sur les langages rationnes et à se demander quels langages ne sont pas réguliers.

#Opération sur les langages rationnels

Les langages définissent des ensembles de mots et il est donc naturel de se demander que deviennent les opérateurs ensemblistes classiques dans de telles conditions.

##Union
Étant donné deux langages représentés par leur automate $A_{1} = \langle Q^{1}, \Sigma, \delta^{1}, q_{0}^{1}, F^{1} \rangle$ et $A_{2} = \langle Q^{2}, \Sigma, \delta^{2}, q_{0}^{2}, F^{2} \rangle$, calculer leur union, soit $L(A_{1}) \cup L(A_{2})$, est relativement simple. Il suffit de se souvenir de la construction qu'on avait employé dans le théorème de Kleene.

##Complément
Étant donné un automate et son langage associé $ = \langle Q, \Sigma, \delta, q_{0}, F \rangle$, construire $\bar{A}$ tel que $L(\bar{A}) = \overline{L(A)} = \Sigma^{*} \setminus L(A)$. L'idée naturelle est d'inverser les états acceptants et rejettants mais cela ne fonctionne pas. Il faut d'abord rendre l'automate déterministe.

##Intersection
Pour calculer l'intersection, c'est un petit peu plus complexe. Il faut construire un nouvel automate qui simule l'exécution des deux automates en même temps. Le mot est accepté s'il l'est par les deux simultanément.

##Vide
Tester si un automate accepte au moins un mot est trivial. Il suffit de chercher s'il existe un chemin dans ce graphe qui mène à un état acceptant.

##Inclusion
Est-ce que tous les mots de $A_{1}$ sont également acceptés par $A_{2}$, avons-nous $L(A_{1}) \subseteq L(A_{2})$. Il suffit de trouver l'équivalence $L(A_{1}) \subseteq L(A_{2})$ si et seulement si $L(A_{1}) \cap \overline{L(A_{2})} = \emptyset$. En pratique, il peut être plus rapide de calculer à la volée cette propriété.

##Égalité
On vérifie les deux sens, si $L(A_{1}) \subseteq L(A_{2})$ et $L(A_{2}) \subseteq L(A_{1})$, alors $L(A_{1}) = L(A_{2})$.

##Universalité
Est-ce que $L(A) = \Sigma^{*}$. Cette question a l'air pourtant peu complexe, il suffirait de construire son complémentaire et de tester le vide mais ce n'est pas aussi simple d'un point de vue de la complexité[^1].

#Langage non rationnel

Les langages rationnels ont l'air de représenter une bonne partie des langages existants. Quels sont donc ces autres langages ?

Les automates finis possèdent en quelque sorte une mémoire finie; ils sont capables de simuler toutes les exécutions jusqu'à un certain nombre et si un mot est plus long que ce nombre d'états, nous avons des mots non-reconnus ou supplémentaires.

Il existe énormément d'exemples de langages non rationnels, mais les principaux sont ceux dits de Dyck[^2] (les mots bien parenthésés) ou dans leur version plus abstraite ($L = \{ a^{n}b^{n} ~ | ~ \forall n \in \mathbb{N} \}$) qui sont dits algébriques ou "sans contexte" et auxquels le théorème de Chomsky–Schützenberger est attaché[^3]. Penser également aux palyndromes. Citons, en plus, ceux de la forme: $L = \{ a^{n}b^{n}c^{n} ~ | ~ \forall n \in \mathbb{N} \}$, dits contextuels.

Pour montrer qu'un langage n'est pas rationnel, on emploie, soit le théorème de Myhill-Nerode, soit le lemme de la pompe (*pumping lemma*). Ce lemme était déjà plus ou moins présent dans l'article de Rabin & Scott[^4] mais prit son réel essor dans sa version simplifiée[^5].

C'est une preuve par contradiction. Imaginons que le langage des mots bien parenthésés ($L = \{ (^{n})^{n} ~ | ~ \forall n \in \mathbb{N} \}$) soit rationnel, il existe donc un automate fini, avec $k$ états, qui le reconnaît. Supposons que l'on veuille reconnaître le mot $(^{k})^{k}$:



Le problème est que, lors de la transition de $q_{k}$ à $q_{k+1}$, on a déjà réalisé $k+1$ états sur les $k$ existants. Cela veut dire qu'il existe deux états $q_{i}$ et $q_{j}$ telle que $ 0 \leq i \leq j \leq k $ et qui forment une "boucle". On peut courcircuiter cette boucle et le mot sera également accepté, or, il ne fait pas parti du dit langage. Et donc, la proposition initiale était éronnée, le langage n'est pas rationnel.

[^1]: Meyer, A. R., & Stockmeyer, L. J. (1972, October). The equivalence problem for regular expressions with squaring requires exponential space. In SWAT (FOCS) (pp. 125-129).
[^2]: McNaughton, R. (1967). Parenthesis grammars. Journal of the ACM (JACM), 14(3), 490-500.
[^3]: Chomsky, N., & Schützenberger, M. P. (1963). The algebraic theory of context-free languages. Studies in Logic and the Foundations of Mathematics, 35, 118-161.
[^4]: Rabin, M. O., & Scott, D. (1959). Finite automata and their decision problems. IBM journal of research and development, 3(2), 114-125.
[^5]: Bar-Hillel, Y., Perles, M., & Shamir, E. (1961). On formal properties of simple phrase structure grammars. Sprachtypologie und Universalienforschung, 14, 143-172.
