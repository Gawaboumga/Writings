#*LR parsers*

Les analyseurs syntaxiques ascendants (*bottom-up parsers*) essayent de retracer la dérivation en partant du texte jusqu'à retrouver le symbole initial de la grammaire en essayant d'appliquer les règles successivement dans le sens inverse. Les lexèmes sont associés de plus en plus jusqu'à reformer le programme  en entier. On peut interprêter cette manière d'effectuer comme une déterminitation du rôle de petites unités lexicales qui sont ensuite combinés afin de donner petit à petit une sémantique.

LRPDAStack

Avec pour automate associé:

LRPDAStackAutomaton

Cet automate simule la dérivation la plus à droite mais à l'envers puisque l'entrée est lue de gauche à droite.

En terme de configurations, nous avons:

$$ (q, 3 * x + 2, \epsilon) \vdash (q, *~  x + 2, 3) \vdash (q, *~  x + 2, Exp)  \vdash (q, x + 2, Exp * ) $$
$$ \vdash (q, +~ 2, Exp * x) \vdash (q, +~ 2, Exp * Exp) \vdash (q, +~ 2, Exp) $$
$$ \vdash (q, 2, Exp +) \vdash (q, \epsilon, Exp + 2) \vdash (q, \epsilon, Exp + Exp) $$ $$ \vdash (q, \epsilon, Exp) $$

Cet automate possède deux types d'actions. La première consiste à remplacer le côté droite de la règle de production par son côté gauche, on appelle cette opération une réduction (*reduce*). La deuxième ajoute un caractère du mot en entrée au sommet de la pile, on parle alors de transfert (*shift*).

Seulement, on comprend bien que cette construction n'est pas déterministe. En effet, il existe plusieurs choix possibles pour réduire des règles en rapport avec un même ensemble de symboles. Ou plus simplement, on ne sait pas s'il faut réduire ou transférer. Malgré cet indéterminisme, on comprend bien qu'une règle sera préférable à une autre lorsqu'on voit le mot en entrée. Sans guide, il faudrait tester à chaque fois toutes les possibilités.

##LR(k)

L'idée naturelle afin de décider quelle règle appliquer est d'utiliser une aide sur les prochains caractères à faire correspondre. Une analyse LR est appelée analyse $LR(k)$ lorsqu'elle utilise une fenêtre de k lexèmes afin de décider comment construire l'arbre syntaxique du mot d'entrée. On étend alors la définition du *PDA* à celui de *Automate fini caractéristique* (*Characteristic Finite State Machine - CFSM*) où on tente de reconnaître les préfixes viables qui pourront être employés dans une réduction future. On introduit des *LR items* afin de représenter l'état d'une expansion éventuelle donnée. Cet objet représente l'état actuel dans l'expansion des règles.

Prenons le cas du $LR(0)$. Un *LR item* est une règle de production avec un "$\cdot $" dans sa partie droite. Si nous avons une règle: $A \rightarrow \alpha$ avec une expansion de type: $A \rightarrow \alpha_{1} \cdot \alpha_{2}$, cela veut dire qu'il est possible que:

- On soit en train d'analyser la règle $A \rightarrow \alpha$;
- On soit après l'analyse de $\alpha_{1}$ ($\alpha_{1}$ est donc sur la pile);
- On soit avant l'analyse de $\alpha_{2}$;

Il est logique de regrouper des règles différentes mais offrant une même possibilité:

$$ S \rightarrow \alpha \cdot \beta $$
$$ S \rightarrow \alpha \cdot \gamma $$

Et il existe deux types de *LR item* particuliers:

- $A \rightarrow \cdot \alpha $ signifie qu'on peut commencer notre analyse et qu'on devra sans doute transférer des symboles;
- $A \rightarrow \alpha \cdot $ qui "reconnaît" la fin de l'analyse de cette règle et peut donc mener à une réduction;

Maintenant, il ne reste plus qu'à utiliser ces *LR items* et construire ce fameux *CFSM*. On commence très simplement par écrire une première relation $S \rightarrow \cdot \alpha$ qui définit l'entrée de manière unique. Maintenant, imaginons que ce $\alpha$ commence par une variable, cela veut dire qu'il faut prédire cette variable qu'on va analyser juste après (soit son côté droit); il faut rajouter toutes ces variables liées jusqu'à obtenir la clôture. Cet ensemble de possibilités défini un état dans l'analyse et forme un état de notre automate. Il ne reste plus qu'à rajouter les transitions qui consistent en la lecture du symbole à droite du point et à avancer ce point.

Prenons la grammaire:

LRGrammar

Nous pouvons obtenir le *LR(0)-CFSM* suivant:

CFSM

Avec la signification suivante, si le "\cdot" est situé à droite (à la fin de la règle), on peut réduire et sinon, on peut transférer un caractère et prendre la transition adéquate. Si les deux configurations sont présentes dans un même état, nous sommes confrontés à une ambiguité qui peut nécessiter l'usage de la fenêtre de $k$ caractères.

##$LR(k)$ Grammaires

Les grammaires $LR(k)$ ont été définies par Knuth[^1]. Elles représentent un sous genre de grammaire sans contexte qui peuvent être identifiées de manière déterministe par l'emploi d'une fenêtre de $k$ caractères. En comparaison des grammaires $LL(k)$, elles sont plus puissantes. En effet, en pratiquant une approche *top-down*, il faut effectuer un choix bien plus tôt dans l'exécution que dans le cas des *bottom-up*. Ceci est lié au fait que seuls les premiers caractères sont analysés afin de décider de la dérivation à emprunter pour les $LL$.

Exemple de grammaire $LR(0)$ mais non $LL(0)$:

LRGrammarButNotLL

Si on désire rajoute un fenêtre de $k$ caractères à notre automate pour le rendre déterministe. Il faut modifier un peu les *LR-items* afin de leur rajouter un *follow* local: $[A \rightarrow \alpha_{1} \cdot \alpha_{2}, u]$. Avec ce *follow* $u$ définit comme une clôture:

$$ 
\left\{
\begin{array}{l}
  \exists [B \rightarrow \delta \cdot A \rho, l] \in s \\
  A \rightarrow \gamma \in P
\end{array}  \Rightarrow \right. \forall u \in First^{k}(\rho l): s \Leftarrow^{\cup} [A \rightarrow \cdot \gamma, u].
$$

Ceci est sans doute très obscur, un exemple sera plus clair:

CFSM1

Par définition, la première règle n'a pas de *follow*. Le caractère $\$ $ signifie "fin de la chaine de caractère". Ensuite, on calcule le *follow* de la variable dans le cadre de son contexte d'apparition.

Le problème des *CFSM* est qu'ils peuvent devenir très vite immense. En effet, si une des règles possède un caractère *follow* différent, alors les deux états sont différents ! On crée alors des modèles intermédiaires qui sont plus compacts mais peut-être moins puissantes. Les *SLR(k)* consistent à calculer le *follow* global et à l'appliquer à chaque état afin de déterminer quand réduire. Et les *LALR(k)* regroupent les états qui possèdent les mêmes règles mais des *follow* locaux différents.[^2]

[^1]: Knuth, D. E. (1965). On the translation of languages from left to right. Information and control, 8(6), 607-639.
[^2]: Aho, A. V., Sethi, R., & Ullman, J. D. (1986). Compilers, Principles, Techniques (pp. 670-671). Boston: Addison wesley.