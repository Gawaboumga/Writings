#Dérivation et arbre

## Dérivation

Une dérivation est tout simplement définie comme une séquence d'application des règles de la grammaire qui transforme le symbole initial en mot qui est reconnu.

Dans l'exemple précédent, nous avons montré qu'il était possible d'obtenir l'expression "$3 * x + 2$", à l'aide de la grammaire des expressions algébriques donnée en exemple, en donnant cette *dérivation*:

$$Exp \Rightarrow^{(1)} Exp + Exp \Rightarrow^{(2)} Exp * Exp + Exp \Rightarrow^{(5)} 3 * Exp + Exp \Rightarrow^{(4)} 3 * x + Exp \Rightarrow^{(5)} 3 * x + 2$$

On aurait très bien pu faire:

$$Exp \Rightarrow^{(2)} Exp * Exp \Rightarrow^{(1)} Exp * Exp + Exp \Rightarrow^{(5)} Exp * Exp + 2 \Rightarrow^{(4)} Exp * x + 2 \Rightarrow^{(5)} 3 * x + 2$$

Ou toute autre séquence de remplacement de règles qui aurait mené à la preuve que l'expression est belle est bien acceptée par la grammaire. Il y a une certaine notion de non-déterminisme; il doit y avoir au moins une dérivation possible qui accepte le mot. Si on remplace à chaque fois la variable la plus à gauche, on parle de dérivation gauche (*leftmost derivation*) et si il s'agit de la plus à droite, de dérivation droite (*rightmost derivation*). Ceci permet de lever une partie du non déterminisme.

Soit une grammaire $G$ sans contexte, une dérivation $ \alpha S \beta \Rightarrow \alpha \gamma \beta $ est obtenue en appliquant $ S \Rightarrow \gamma $ est le plus à gauche si $ \alpha \in T^{*} $ et le plus à droite si  $ \beta \in T^{*} $. Cette séparation est importante dans le cadre des *parsers* qui se doivent d'être déterministes. Leur usage permet également de les déterminer uniquement par les règles de remplacement.

## Arbre de dérivation

Une autre manière de représenter la séquence de règles à appliquer est d'utiliser un arbre de dérivation:


Toutes les feuilles de l'arbre sont composées de terminaux et, en lisant de gauche à droite, donnent le mot reconnu. À chaque embranchement, on a le parent qui est la variable et les enfants qui sont le résultat de l'application de la règle. Cette vision en arbre fonctione uniquement pour les grammaires sans contexte parce qu'il n'y a qu'une seule variable du côté gauche des règles, pour une grammaire contextuelle, on obtiendrait un graphe.

Ces arbres de dérivations contiennent beaucoup d'information sur le code, sa structure et la manière de l'interpréter. Ceci permet de donner du sens à un ensemble de mots. Dans notre exemple, nous voyons que soit l'opérateur "+" est en haut, soit "*"; si on évalue cette arbre en faisant un parcours en profondeur, on obtiendra des résultats différents, alors qu'on s'attend à avoir l'ordre usuel (PEMDAS).

C'est ce qu'on appelle une *ambiguité*, il existe plusieurs manières de créer un arbre de dérivation pour un même mot. On dit qu'une grammaire est ambiguë s'il existe au moins un mot qui admet deux arbres de dérivations différents. C'est un grand problème pour les compilateurs et il faut éviter que cela se produise en ajoutant de l'information supplémentaire par rapport à la précédence des opérateurs ou à leur associativité.