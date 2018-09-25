#*LL parsers*

Les analyseurs syntaxiques descendants (*top-down parsers*) essayent de retracer la dérivation en partant du symbole initial de la grammaire jusqu'à retrouver le texte en essayant d'appliquer les règles successivement. Le programme est morcelé en éléments de plus en plus petits jusqu'à atteindre les lexèmes. On peut interprêter cette manière d'effectuer comme l'analyse des relations sur des données inconnues en prenant pour hypothèse la structure générale de l'arbre, on cherche alors à confirmer ou infirmer ces hypothèses sur base des lexèmes compatibles.

Lors de la preuve de l'équivalence entre les *PDA* et les *CFG*, nous avions employé une construction de type:

CFGtoPDA

Avec pour automate associé:

CFGtoPDAAutomaton

Cet automate simule la dérivation la plus à gauche et maintient, en tout temps, un suffixe de la forme sententielle (mots directement dérivés du symbole initial).

En terme de configurations, nous avons:

$$ (q, 3 * x + 2, Exp) \vdash (q, 3 * x + 2, Exp + Exp) \vdash (q, 3 * x + 2, Exp * Exp + Exp) $$
$$ \vdash (q, 3 * x + 2, 3 * Exp + Exp) \vdash (q, *~  x + 2, * Exp + Exp) $$
$$ \vdash (q, x + 2, Exp + Exp) \vdash (q, x + 2, x + Exp) \vdash (q, + 2, + Exp) $$ $$ \vdash (q, 2, Exp) \vdash (q, 2, 2) \vdash (q, \epsilon, \epsilon) $$

N'oubliez pas que la pile grandit vers la gauche.

Cet automate possède deux types d'actions. La première consiste à remplacer le côté gauche de la règle de production par son côté droit, on appelle cette opération une *production*. La deuxième vérifie que le mot en entrée correspond bien au résultat de la pile, on parle alors de correspondance (*match*).

Seulement, on comprend bien que cette construction n'est pas déterministe. En effet, il existe plusieurs choix possibles de règles pour dériver en rapport avec un même symbole. Malgré cet indéterminisme, on comprend bien qu'une règle sera préférable à une autre lorsqu'on voit le mot en entrée.

##LL(k)

L'idée naturelle afin de décider quelle règle appliquer est d'utiliser une aide sur les prochains caractères à faire correspondre. Une analyse LL est appelée analyse $LL(k)$ lorsqu'elle utilise une fenêtre de k lexèmes afin de décider comment construire l'arbre syntaxique du mot d'entrée. On étend alors la définition du *PDA* à celui de *PDA with look-ahead* (*LPDA*) où les transitions prennent également en compte les prochains $k$ caractères au lieu d'avoir simplement l'état et le caractère actuel. On précède les transitions par la fenêtre d'entrée: "$ w : $ "
Si on prends un langage composé des deux mots $L = \{ a, b\}$, on peut présenter le *1-LPDA* suivant:

LL1PDA

On observe que cet automate est maintenant déterministe alors que sa version standard *PDA* ne l'est pas. Dès lors, on peut se demaner si ces automates ont plus de puissance que les *PDA* puisqu'ils peuvent reconnaître certains mots de manière déterministes. La réponde est pourtant négative.

> Pour tout *k-LPDA* $P$, il existe un *PDA* $P'$ tel que $L(P) = L(P')$

La démonstration est un peu longue mais l'idée est de représenter la fenêtre dans l'état. Il faut alors s'assurer que les deux puissent se simuler mutuellement.

EquivalenceLPDAPDA1

devient:

EquivalenceLPDAPDA2

Et dans l'autre sens:

EquivalenceLPDAPDA3

devient:

EquivalenceLPDAPDA4

##First & Follow

Imaginons que nous voulons créer un *parser* pour cette grammaire avec un caractère dans la fenêtre:

FirstFollowGrammar

On remarque qu'il existe deux sources possibles de non déterminisme dans cette grammaire, les règles relatives à $A$ et celles à $C$. Seulement, on se rend compte que si on souhaite obtenir un $a$, il est conseillé d'employer la première transition $(1)$. Le $(2)$ pour un $b$ et pour $(3)$, on peut soit obtenir un $c$, soit un $d$ par: $A \rightarrow Cdd \rightarrow cdd$ ou $A \rightarrow Cdd \rightarrow \epsilon dd$. Si on résume, nous avons:

+-----+------+-----+-----+-----+
|     | $Look-ahead$           |
+=====+======+=====+=====+=====+
| Var | $a$  | $b$ | $c$ | $d$ |
+-----+------+-----+-----+-----+
| $A$ |  1   |  2  |  3  |  3  |
+-----+------+-----+-----+-----+

Et bien pour chaque règle de la forme $A \rightarrow \alpha$, nous avons calculé l'ensemble des premiers caractères des mots qui peuvent être dérivés de $\alpha$. Ici, nous avons regarder juste le premier caractère, on parle donc de $Premier^{1}$ ou (*$First^{1}$*).

Maintenant si on souhaite effectuer la même opération depuis la variable $C$, la notion de $First^{1}$ n'est plus suffisante pour la règle $C \rightarrow \epsilon$. Au lieu de considérer dans quel *contexte* la règle $C$ peut se produire, il faut également prendre en compte quels caractères peuvent suivre. Ici, tous les mots générés depuis $C$ seront forcément suivi par un $d$. On parle de $Suivant^{1}$ ou (*$Follow^{1}$*).

// Tree of derivation - first & follow ???

On obtient maintenant:

+-----+------+-----+-----+-----+
|     | $Look-ahead$           |
+=====+======+=====+=====+=====+
| Var | $a$  | $b$ | $c$ | $d$ |
+-----+------+-----+-----+-----+
| $A$ |  1   |  2  |  3  |  3  |
+-----+------+-----+-----+-----+
| $B$ |      |  4  |     |     |
+-----+------+-----+-----+-----+
| $C$ |      |     |  5  |  6  |
+-----+------+-----+-----+-----+

Ce tableau est appelé: "table d'action" puisqu'il donne la règle à appliquer pour obtenir chaque symbole possible au sommet de la pile en fonction du prochain caractère.

De manière plus formelle, on définit $First^{k}$:

$$ 
First^{k}(\alpha) = \left\{
w \in T^{*} |
\begin{array}{l}
  \alpha \Rightarrow^{*} wx \\
  \text{et} \\
  \text{soit } |w| = k \text{ soit } (|w| \lt k \text{ et } x = \epsilon)
\end{array}
\right. 
$$

avec $\alpha$ une forme sententielle de $G$.

Et $Follow^{k}$:

$$ 
Follow^{k}(\alpha) = \{
w \in T^{*} | \exists \beta, \gamma \text{ tels que } S \Rightarrow^{*} \beta \alpha \gamma \text{ et } w \in First^{k}(\gamma)
\}
$$

##$LL(k)$ Grammaires

Dans la grammaire sans contexte, on peut identifier un sous genre qui peuvent être reconnus de manière déterministe par l'emploi d'une fenêtre de $k$ caractères. On appele très logiquement ce sous-ensemble les grammaires $LL(k)$. Elles ont été introduites dans la fin des années 60[^1][^2] parce qu'elles ont une grande importance dans la définition des langages de programmation. En effet, on souhaite être capable de compiler nos programmes de manière déterministe.

Seulement, on comprend bien que si on emploie un $1-LPDA$, deux règles de la forme $A \rightarrow aB$ et $A \rightarrow aC$ resteront non déterministes. Quelles sont donc les conditions à imposer pour être sûr que notre automate soit déterministe s'il est capable de lire $k$ caractères à l'avance ?

Imaginons que nous ayons deux règles de la forme: $A \rightarrow \alpha_{1}$ et $A \rightarrow \alpha_{2}$. Comment obtenir un cas pathologique ? Le problème intervient lorsque $A$ est au sommet de la pile.

$$ S \Rightarrow^{*} wA\gamma $$

avec $w \in T^{*}$ et $\gamma \in (V \cup T)^{*}$.

Maintenant, décidons que ce soit la première règle qui soit appliquée ($A \rightarrow \alpha_{1}$). Et continuons la dérivation:

$$ S \Rightarrow^{*} wA\gamma \Rightarrow w\alpha_{1}\gamma \Rightarrow^{*} wx_{1} $$

Lorsque qu'on est dans l'état $wA\gamma$ et qu'on applique $A \rightarrow \alpha_{1}$, cela veut dire qu'on a déjà lu $w$ et qu'il reste $x_{1}$ à lire avec pour fenêtre $First^{k}(x_{1})$. Si la deuxième dérivation ($A \rightarrow \alpha_{2}$) ne rend pas confu notre *parser*:

$$ S \Rightarrow^{*} wA\gamma \Rightarrow w\alpha_{2}\gamma \Rightarrow^{*} wx_{2} $$

Cela veut dire que $First^{k}(x_{1}) \ne First^{k}(x_{2})$ puisqu'il a pu effectuer le bon choix de manière purement déterministe.

Très logiquement, on qualifie les grammaires de $LL(k)$ si et seulement si, pour toute paire de dérivation:

$$ S \Rightarrow^{*} wA\gamma \Rightarrow w\alpha_{1}\gamma \Rightarrow^{*} wx_{1} $$
$$ S \Rightarrow^{*} wA\gamma \Rightarrow w\alpha_{2}\gamma \Rightarrow^{*} wx_{2} $$

avec $w, x_{1}, x_{2} \in T^{*}, A \in V$ et $\gamma \in (V \cup T)^{*}$. Si on a $First^{k}(x_{1}) = First^{k}(x_{2})$, alors $\alpha_{1} = \alpha_{2}$.

Malheureusement, cette définition est dite "sémantique" et est difficile à tester puisqu'il peut exister une infinité de dérivations possibles.

On introduit les $Strong LL(k)$ grammaires qui se basent une définition dite syntactique, uniquement sur les règle qui sont finies.

on qualifie les grammaires de $Strong LL(k)$[^2] si et seulement si, pour toute paire de règles $A \rightarrow \alpha_{1}$ et $A \rightarrow \alpha_{2}$:

$$ First^{k}(\alpha_{1}Follow^{k}(A)) \cap First^{k}(\alpha_{2}Follow^{k}(A)) = \emptyset $$

Le nom *Strong* laisse sous-entendre que cette définition est plus forte que la simple $LL(k)$ et c'est en effet le cas. Toute grammaire $Strong LL(k)$ est $LL(k)$, par contre l'inverse n'est pas vrai.

// Exemple de LL(k) mais pas Strong ?

Cependant, et heureusement pour nous, $LL(1) = StrongLL(1)$. Les deux notions définissent des grammaires comparables. L'un n'est pas plus restrictif que l'autre. Définissons également qu'un langage est $LL(k)$ s'il existe une grammaire $LL(k)$ pour le dit langage. Très logiquement, on a également que $LL(k) \subset LL(k + 1)$ [^3].

À l'aide de l'*action table*, on peut écrire un *recursive descendent parser* très facilement. Nottons néamoins que la présence simultanée de deux règles dans une cellule de cette table indique que le langage n'est pas $LL(k)$.

[^1]: Lewis II, P. M., & Stearns, R. E. (1968). Syntax-directed transduction. Journal of the ACM (JACM), 15(3), 465-488.
[^2]: Rosenkrantz, D. J., & Stearns, R. E. (1970). Properties of deterministic top-down grammars. Information and Control, 17(3), 226-256.
[^3]: Kurki-Suonio, R. (1969). Notes on top-down languages. BIT Numerical Mathematics, 9(3), 225-238.
