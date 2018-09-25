#Grammaire

##Syntaxe & Sémantique

Une grammaire est un ensemble de règles de production pour des mots d'un langage. Elle ne définit pas le sens de ces mots mais permet de fournir des contextes d'apparition.

La notion de grammaire est fortement liée à la personne de Noam Chomsky[^1] et date des années 1950. Formellement, on définit une grammaire par un tuple:

$$ G = \langle V, T, P, S \rangle $$

avec:

- $V$ un ensemble fini de variables;
- $T$ un ensemble fini de terminaux;
- $P$ un ensemble fini de règles de production ayant pour forme: $(V \cup T)^{*} V (V \cup T)^{*} \rightarrow (V \cup T)^{*}$;
- $S \in V$, une variable définie comme le symbole initial;

Exemple de grammaire pour des expressions algébriques:



avec:

- $V = \{ Exp \}$;
- $T = \{ Identifier, Constant \}$;
- $P$, l'ensemble des règles de la forme $Exp \rightarrow ...$;
- $S = Exp$;

Avec cet exemple, nous voyons que nous sommes capables d'exprimer des morceaux de phrases tels que: $3 * x + 2$ ou $((2 + 3))$. En effet, nous avons:
$$Exp \Rightarrow^{(1)} Exp + Exp \Rightarrow^{(2)} Exp * Exp + Exp \Rightarrow^{(5)} 3 * Exp + Exp \Rightarrow^{(4)} 3 * x + Exp \Rightarrow^{(5)} 3 * x + 2$$

Outre l'aspect syntaxique de la grammaire, on y apporte un côté semantique.

Soit $\gamma \in (V \cup T)^{*} V (V \cup T)^{*}$ et $\delta \in (V \cup T)^{*}$, on dit que $\delta$ peut être dérivé de $\gamma$ (et noté $\gamma \Rightarrow_{G} \delta$) si et seulement si, il existe $\gamma_{1}, \gamma_{2} \in (V \cup T)^{*}$ et une règle de type $\alpha \rightarrow \beta \in P$ tel que: $\gamma = \gamma_{1} \alpha \gamma_{2}$ et $\delta = \gamma_{1} \beta \gamma_{2}$. Par abus de notation, on note $\gamma \Rightarrow_{G}^{*} \delta$ la clôture transitive et reflexive avec pour sémantique qu'on peut dériver $\delta$ à partir de $\gamma$.

On définit $\gamma \in (V \cup T)^{*}$ comme une forme sententielle si et seulement si $S \Rightarrow_{G}^{*} \gamma$ et le langage d'une grammaire $G$ est donné par:

$$ L(G) = \{ w \in T^{*} | S \Rightarrow_{G}^{*} w \} $$

##Hiérarchie de Chomsky

La hiérarchie de Chomsky est le nom qu'on donne à une hiérarchie de classes de langages formelles décrite pour la première fois en 1956[^1]. Elle définit quatre classes syntaxiques de grammaire qui possèdent différents intérêts tant théoriques que pratiques:

- Type 0: Grammaire générale (*unrestricted grammar*). Elle contient toutes les grammaires possibles. Elle génère tous les langages pouvant être reconnus par une machine de Turing, on les appelle également les "Récursivement énumérables" (*RE*).
- Type 1: Grammaire contextuelle (*context-sensitive grammar*). Les règles de production sont de la forme: $ \alpha A \beta \rightarrow \alpha \gamma \beta ~ (A \in T, \alpha, \beta, \gamma \in V^{*}, \gamma \ne \epsilon)$. Cela signifie que le remplacment d'une variable peut dépendre des éléments autour de lui, son contexte. Les langages (*CSL*) sont reconnus exactement par un automate linéairement borné.
- Type 2: Grammaire non contextuelle ou algébrique (*context-free grammar*). Les règles de production sont de la forme: $ A \rightarrow \alpha ~  (A \in V, \alpha \in (V \cup T)^{*})$ et les langages (*CFL*) sont reconnus par un automate à pile.
- Type 3: Grammaire régulière/rationnelle (*regular*). Elle soit dite "gauche" si: $A \rightarrow B\alpha$ ou $A \rightarrow \alpha$ ($A, B \in V, \alpha \in T$), soit dite "droite", si: $A \rightarrow \alpha B$ ou $A \rightarrow \alpha$ ($A, B \in V, \alpha \in T$). Les langages (*REG*) sont reconnus par un automate fini. Attention, la présence simultanée de règles gauches et droites mène à une grammaire dite "linéaire" qui est intermédiaire entre les types 2 et 3.

Attention également au fait qu'il s'agit bien d'une hiérarchie de langages et non de grammaires.

[^1]: Chomsky, N. (1956). Three models for the description of language. IRE Transactions on information theory, 2(3), 113-124.