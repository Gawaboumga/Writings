# Automate fini

Alors que les expressions rationnelles nous fournissent une notation compacte et lisible afin de décrire les langages réguliers. Il n'est pas évident de déterminer quelle procédure adopter afin de manipuler de manière automatisée de tels langages. Ainsi, il semble nécessaire de rajouter un niveau d'abstraction qui permettrait de définir des algorithmes utiles et qui permettraient de répondre à la question de l'appartenance.

Un modèle possédant des caractéristiques très intuitives tout en étant fort simple a été proposé en 1951 par S. Kleene[^1], dans un très long et passionant article. Mais n'a réellement pris son essor dans la théorie des langages que sous l'action de M. Rabin & D. Scott (prix Turing conjointement déscerné en 1976)[^2] après la publication de leur article en 1959.

Un automate fini (*finite automaton*) ou machine à états finis, est une machine abstraite qui lit un mot fourni en entrée, lettre par lettre et qui, en fonction de ce qu'elle lit, change d'état. Elle termine son exécution lorsqu'elle termine la lecture de son entrée et accepte le mot si elle termine dans un état dit "acceptant".

Formellement, un automate fini est déterminé (comme beaucoup d'autres concepts en informatique) par un tuple:

$$ A = \langle Q, \Sigma, \delta, q_{0}, F\rangle $$

où:

1. $Q$ est un ensemble fini d'état;
1. $\Sigma$ est l'alphabet (fini) d'entrée;
1. $\delta: Q \times (\Sigma \cup \{ \epsilon \}) \rightarrow 2^{Q}$;
1. $q_{0} \in Q$ est l'état initial;
1. $F \subseteq Q$ l'ensemble des états acceptants;

Si on reprend notre exemple, on a:

1. $Q = \{ q_{odd}, q_{even} \}$;
1. $\Sigma = \{ 0, 1 \}$;
1. $q_{0} = q_{odd}$;
1. $F = \{ q_{odd} \}$;
1. $\delta$ sont tous les: $\delta(odd, 1) = \{ even \}$, $\delta(odd, 0) = \{ odd \}$, $\delta(even, 1) = \{ odd \}$, $\delta(even, 0) = \{ even \}$;

Effectuons plusieurs remarques sur cette définition:

Le codomaine (l'image) de la fonction de transition est un ensemble d'états ($2^{Q}$), cela veut dire que depuis un état, en lisant une même entrée, on peut se rendre dans plusieurs états. Ceci permet d'introduire une notion de non-déterminisme, comme dans cet exemple où $\delta(q_{0}, a) = \{ q_{1}, q_{2} \}$.

Évidemment, plusieurs questions apparaissent avec cette notion:

- Quel est donc le langage d'un tel automate ? Et bien, on considère qu'un mot est accepté si il existe une exécution sur l'entrée qui mène à l'état acceptant.
- Pourquoi a-t-on besoin de cette notion ? Difficile de répondre à cette question sans diverger. L'idée est que cela permet de faciliter la modélisation de certains automates (nous nous attarderons là-dessus un peu plus tard). Et que certains modèles de calcul (machine abstraite) possèdent différentes caractéristiques si on rajoute cette notion. Or, nous verrons que tout automate non-déterministe peut être converti en un, équivalent, déterministe. C'est-à-dire qu'ils reconnaissent des mêmes classes de langages mais ils n'ont pas la même complexité. Il est donc parfois plus facile de réfléchir avec ce concept tout en sachant que la version déterministe est "équivalente".
- Les transitions peuvent être qualifiées par le mot vide $\epsilon$, on parle alors de transitions "spontanées", et cela permet, aux automates, de changer leur état sans lire aucun caractère de l'entrée.

## Classes d'automates finis

Usuellement, on distingue trois classes d'automates finis:

- Les automates finis non déterministes avec transitions epsilon (*NFA-$\epsilon$*), conforme à la définition donnée plus haut.
- Les automates finis non déterministes (*NFA*) qui sont des NFA-$\epsilon$ mais où on interdit les transitions $\epsilon$. $ \forall q \in Q: \delta (q, \epsilon) = \emptyset $ ou on redéfinit la fonction de transition $\delta$ comme: $Q \times \Sigma \rightarrow 2^{Q}$.
- Les automates finis déterministes (*DFA*) sont des *NFA* où on a: $\forall q \in Q, \forall a \in \Sigma: |\delta (q, a)| \le 1 $ ou on redéfinit la fonction de transition $\delta$ comme: $Q \times \Sigma \rightarrow Q$ qui envoie vers une sorte d'état "poubelle" lorsque la transition n'existe pas et qui rejette automatiquement le mot.

## Exécution, configuration et sémantique

Pour le moment, on a surtout agité les mains en l'air pour expliquer la notion de mots acceptés ou d'exécution. Il ne reste plus qu'à les définir et nous aurons alors suffisament de notions pour pouvoir attaquer les choses sérieuses.

Une configuration d'un automate fini est une paire $\langle q, w \rangle \in Q \times \Sigma^{*}$ où $q$ représente l'état courrant et $w$ le suffixe du mot qu'il reste encore à lire, elle définit de manière unique un état de cette machine. La configuration initiale est donc $\langle q_{0}, w \rangle$, avec $w$ le mot en entier à tester et une configuration acceptante est de la forme: $\langle q, \epsilon \rangle$ avec $q \in F$.

Une exécution de la machine est donc une suite de changements de configurations telles que, soit $\langle q_{1}, w_{1} \rangle$ et $\langle q_{2}, w_{2} \rangle$, deux configurations de l'automate se succèdent s'il existe une lettre $a \in \Sigma \cup \{ \epsilon \}$ telle que $w_{1} = a w_{2}$ et que $q_{2} \in \delta(q_{1}, a)$. On note cette relation:

$$ \langle q_{1}, w_{1} \rangle \vdash_{A} \langle q_{2}, w_{2} \rangle $$

Par abus de notation, la séquence de configurations, notée: $\langle q_{1}, w_{1} \rangle, \langle q_{2}, w_{2} \rangle, \cdots, \langle q_{n}, w_{n} \rangle$ telle  $\langle q_{i}, w_{i} \rangle \vdash \langle q_{i+1}, w_{i+1} \rangle$, est appellée exécution de l'automate sur le mot $w_{1}$. Une exécution est qualifié d'acceptante si la dernière configuration est acceptante.
On notera également $\vdash_{A}^{*}$ la fermeture transitive et réflexive.

Un langage accepté est finalement défini par:

$$ L(A) = \{ w \in \Sigma^{*} ~ | ~ \exists q \in F ~ \text{telle que} ~ \langle q_{0}, w \rangle \vdash_{A}^{*} \langle q,\epsilon \rangle \} $$

[^1]: Kleene, S. C. (1951). Representation of events in nerve nets and finite automata (No. RAND-RM-704). RAND PROJECT AIR FORCE SANTA MONICA CA.
[^2]: Rabin, M. O., & Scott, D. (1959). Finite automata and their decision problems. IBM journal of research and development, 3(2), 114-125.
