#Automate à pile

Les langages sans contexte peuvent s'interpréter comme un ensemble de petits morceaux qui peuvent être reconnus par un automate fini mais dont le nombre d'appel (récursif) n'est pas borné et où on stocke un peu d'information à chaque étape.

Formellement, un automate à pile (*PushDown Automaton*) est déterminé par un tuple:

$$ A = \langle Q, \Sigma, \Gamma, \delta, q_{0}, Z, F\rangle $$

où:

1. $Q$ est un ensemble fini d'état;
1. $\Sigma$ est l'alphabet (fini) d'entrée;
1. $\Gamma$ est l'alphabet (fini) de la pile;
1. $\delta: Q \times (\Sigma \cup \{ \epsilon \}) \times \Gamma \rightarrow 2^{Q \times \Gamma^{*}}$;
1. $q_{0} \in Q$ est l'état initial;
1. $Z \in \Gamma$ le contenu initial de la pile;
1. $F \subseteq Q$ l'ensemble des états acceptants;

Si on reprend notre exemple, on a:

1. $Q = \{ q_{word}, q_{word^{R}} \}$;
1. $\Sigma = \{ 0, 1 \}$;
1. $\Gamma = \{ 0, 1, Z \}$;
1. $q_{0} = q_{word}$;
1. $Z = Z$;
1. $F = \{ q_{word^{R}} \}$;
1. $\delta$ sont tous les: $\delta(word, 1, \epsilon) = \{ (word, 1) \}$, $\delta(word, 0, \epsilon) = \{ (word, 0) \}$, $\delta(word^{R}, 1, 1) = \{ (word^{R}, \epsilon) \}$, $\delta(word^{R}, 0, 0) = \{ (word^{R}, \epsilon) \}$;

Avec pour notation que "a, $\beta / \gamma$" signifie que: "Si on lit le caractère a en entrée, on retire le mot $\beta$ de la pile (si cela est possible) et on met le mot $\gamma$ au sommet". La pile grandit donc par la gauche avec cette notation.

## Exécution, configuration et sémantique

Une configuration d'un automate à pile, a l'instar des automates finis, est un triple $\langle q, w, \gamma \rangle \in Q \times \Sigma^{*} \times \Gamma^{*} $ où $q$ représente l'état courrant, $w$ le suffixe du mot qu'il reste encore à lire et $\gamma$ le contenu de la pile, elle définit de manière unique un état de cette machine. La configuration initiale est donc $\langle q_{0}, w, Z \rangle$, avec $w$ le mot en entier à tester et une configuration acceptante est de la forme: $\langle q, \epsilon, \gamma \rangle$ avec $q \in F$ ou $\langle q, \epsilon, \epsilon \rangle$, nous reviendrons sur ce dernier point plus tard.

Une exécution de la machine est une suite de changements de configurations telles que, soit $\langle q_{1}, w_{1}, \gamma_{1} \rangle$ et $\langle q_{2}, w_{2}, \gamma_{2} \rangle$, deux configurations de l'automate se succèdent s'il existe une lettre $a \in \Sigma \cup \{ \epsilon \}$ telle que $w_{1} = a w_{2}$ et que $q_{2} \in \delta(q_{1}, a, X)$, avec $X \subseteq \gamma_{1}$. On note cette relation:

$$ \langle q_{1}, w_{1}, \gamma_{1} \rangle \vdash_{P} \langle q_{2}, w_{2}, \gamma_{2} \rangle $$

Il y a donc bel et bien trois étapes à chaque fois:

- Lire le caractère actuel
- Vérifier si le haut de la pile correspond et le changer si nécessaire
- Changer d'état

Il existe deux manière de définir qu'un langage est accepté:

$$ L(P) = \{ w \in \Sigma^{*} ~ | ~ \exists q \in F ~ \text{telle que} ~ \langle q_{0}, w, Z \rangle \vdash_{P}^{*} \langle q,\epsilon, \gamma \rangle \} $$

Ce sont les langages acceptés par un état final et traditionnellement noté $L(P)$.

$$ N(P) = \{ w \in \Sigma^{*} ~ | ~ \exists q \in Q ~ \text{telle que} ~ \langle q_{0}, w, Z \rangle \vdash_{P}^{*} \langle q,\epsilon, \epsilon \rangle \} $$

Ceux acceptés par une pile vide et traditionnellement noté $N(P)$.

Ces deux notions sont équivalentes, il suffit de rajouter un état qui vide la pile à partir d'un $L(P)$ et de rendre acceptant le dernier état où la transition vide la pile depuis $N(P)$. Dans notre exemple de $L_{pal@}$ est un $N(P)$, à contrario $L(P) = \emptyset$.
