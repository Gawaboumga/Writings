#Équivalence

## Déterminisme

À l'instar de l'équivalence des *NFA-$\epsilon$* et des *DFA*, sont peut se demander s'il existe une équivalence entre les *PDA* déterministes et les non-déterministes. Malheureusement pour nous, la réponse est négative[^1]. On peut se rendre compte de cette propriété en étudiant le langage $L_{pal} = \{ w w^{R} | w \in \{ 0, 1 \}^{*} \} $, l'automate doit alors décider par lui-même quand changer d'état.

Les *DPDA* sont des *PDA* telle que:

- $ \forall q \in Q, \sigma \in \Sigma \cup \{ \epsilon \}, \gamma \in \Gamma: |\delta(q, \sigma, \gamma)| \leq 1$. Au plus, un déplacement possible;
- $ \forall q \in Q, \gamma \in \Gamma$; si $ \delta(q, \epsilon, \gamma) \ne \emptyset$, alors  $ \forall \sigma \in \Sigma ~ \delta(q, \sigma, \gamma) \ne \emptyset $. S'il existe une transition $\epsilon$, alors c'est la seule possible;

Ces règles sont suffisantes pour n'avoir à chaque fois qu'un choix déterministe. Attention, l'équivalence entre les $L(P)$ et les $N(P)$ n'est pas garantie. À noter également que ceci n'empêche pas qu'on puisse déterminer certains *PDA*; il suffit de prendre le sous-ensemble des *NFA*.

## Grammaire sans contexte

Nous avons introduit ces automates à pile en disant qu'ils permettaient de reconnaître les langages sans contexte. Il est tant de le démontrer:

> Pour tout *PDA* $P$, $L(P)$ et $N(P)$ sont tous deux des langages sans contexte. Réciproquement, à tout langage sans contexte $L$, il existe des *PDA* $P$ et $P'$ tels que $L(P) = N(P') = L$.

La démonstration s'effectue en trois étapes:

1. On commence par montrer qu'un langage sans contexte peut être accepté par *PDA* associé à la notion de pile vide. En fournissant une conversion d'une grammaire sans contexte vers un *PDA*.
1. L'inverse, depuis un *PDA* à pile vide, on peut construire un *CFG*.
1. On peut convertir le *PDA* à pile vide en un à état acceptant.

### *CFG* en *PDA*

Cette partie consiste à effectuer le travail d'un *parser*. Nous verrons plus tard différentes techniques possibles pour accomplir cette tâche. Mais voyons d'abord le concept général des dérivations les plus à gauche.

Si on prend l'exemple de la grammaire qui décrit des expressions algébriques, il est possible de simuler son exécution à l'aide d'une pile. Reprenons notre exemple de: "$3 * x + 2$"

$$Exp \Rightarrow^{(1)} Exp + Exp \Rightarrow^{(2)} Exp * Exp + Exp \Rightarrow^{(5)} 3 * Exp + Exp \Rightarrow^{(4)} 3 * x + Exp \Rightarrow^{(5)} 3 * x + 2$$

CFGtoPDA

L'idée est de représenter ces applications de règles directement dans la pile. Si il s'agit d'une variable, on remplace par le contenu par la bonne règle à appliquer et si c'est un terminal, on le retire simplement.

CFGtoPDAAutomaton

### *PDA* en *CFG*

Le "but" d'un *PDA* est de vider sa pile. Cela peut sembler tomber sous le sens mais lorsqu'on ajoute un symbole sur cette pile, il faudra le retirer. On va définir des variables de la forme:

$$ [p \gamma q] $$

où $p$ et $q$ sont deux états et $\gamma$ un symbole de la pile. On donne alors pour sémantique que l'ensemble des mots générés à partir de $ [p \gamma q] $ est exactement l'ensemble de mots acceptés par un *PDA* tel que, son exécution part de l'état $p$ avec le contenu de la pile $\gamma$ et termine en l'état $q$. Exprimé d'une autre manière:

$$ [p \gamma q] \Rightarrow^{*} w \text{ ssi } (p, w, \gamma) \vdash_{P}^{*} (q, \epsilon, \epsilon) $$

La variable initiale est en toute logique: $ [q_{0} Z q] ~ \forall q \in Q$. Maintenant comment écrire notre ensemble de règles ? À chaque fois que j'ajoute un symbole à la pile, je devrai le supprimer. Sinon, je peux simplement changer d'état ou mieux, retirer un symbole. On a alors trois types de règles:

$$ [p0q] \rightarrow 1[q1r][r0s] \text{quand on ajoute un 1} $$
$$ [p0q] \rightarrow 1[q0r] \text{quand on lit juste un 1} $$
$$ [p0q] \rightarrow 1 \text{quand on retire un 1} $$

### $L(P) = N(P') = L$

L'explication est un peu longue si on se veut rigoureux, nous ne présenterons que les idées principales. On peut simuler l'exécution d'un $L(P)$ à l'aide d'un $N(P)$. On ajoute un nouvel état initial qui mène à l'ancien et qui rajoute un nouveau symbole sur la pile. Le $N(P)$ finira son exécution en terminant sur ce symbole sentinelle et on ajoutera une transition de chaque état vers un acceptant. Et pour convertir un $L(P)$ en $N(P)$, il suffit de rajouter des transitions $\epsilon$ depuis les états finis vers un état qui vide la pile.

[^1]: Sipser, M. (2012). Introduction to the Theory of Computation. Cengage Learning.