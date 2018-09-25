# Transformation

Les grammaires sont parfois ambiguës, il existe donc plusieurs arbres de dérivation qui mènent au même résultat. Il existe des méthodes pour lever certaines de ces ambiguités; seulement celles-ci ne fonctionnent pas toujours et il existe également des grammaires nativement ambiguës. On parle davantage de langages inambigus s'ils possèdent une grammaire inambiguës.

Dans ce chapitre, nous n'aborderons que des grammaires sans contexte. L'ambiguité étant une propriété orthogonale des classes de langages. Et les langages sans contexte sont ceux employés pour décrire des langages de programmation (grammaire sans contexte déterministe) tout en évitant toute la complexité liée à des modèles plus avancés.

##Inaccessible & non productif

La première chose à se demander est s'il existe des symboles non productifs ou non accessibles. Les symboles non productifs sont un ensemble de règles tel qu'il ne sera jamais possible de construire des mots à partir d'elles et les non accessibles sont tels qu'il n'existe pas de dérivation menant à eux.

UselessGrammar

Dans cet exemple, les parties relatives à $B$ sont non productives, aucun symbole ne sera jamais produit et celles relatives à $C$ sont non accessibles. Il suffit de retirer toutes ces règles de la grammaire vu qu'elles n'ont aucune utilité.

##Factorisation gauche

Il arrive qu'on soit parfois confronté à des règles qui possèdent une partie commune.



Il vaut mieux alors factoriser l'expression malgré le fait qu'une seule dérivation soit bonne. En effet, lorsqu'on va lire le fichier, de gauche vers la droite, on va d'abord lire le $IF$ et on ne saura choisir quelle règle appliquer que bien plus tard, lorsqu'on lira la présence éventuelle du $ELSE$. Tandis que si on factorise, le problème ne se pose pas.



##Récursion gauche

En modélisant un langage, il peut arriver qu'on crée une récursion gauche avec une règle, où la même variable apparaît du côté gauche et en première position à droite. Soit: $A \Rightarrow^{*}_{G} A\alpha$. On peut difficilement savoir combien de fois nous devrons effectuer la récursion, qui plus est, on peut avoir plusieurs dérivations si une des règles produit un $\epsilon$.



Il faut alors convertir la récursion à gauche par une récursion à droite.



##Précédence et associativité des opérateurs

Nous avons introduit la notion d'ambiguité avec notre exemple de grammaire des expressions algébriques. Le problème étant qu'on pouvait générer l'addition avant la multiplication ou l'inverse. Un phénomène analogue peut arriver dans le cas de l'associativité, on peut faire croître l'arbre vers la gauche ou vers la droite tout en gardant la même signification.



Pour respecter la précédence des opérateurs, il faut rajouter des niveaux de variables et règles. Plus un opérateur sera généré tard, plus sa priorité sera élevée et plus il est tôt, moins elle le sera. Pour générer le code ou pour l'évaluer, on privilégiera un parcours en profondeur, de gauche à droite, sur l'arbre de dérivation qu'on aura créé.



L'associativé est un peu avec la même idée. Si on veut qu'elle soit à gauche, il suffit d'avoir des règles récursives à gauche $E \Rightarrow E + T$, sinon pour l'associativé à droite $E \Rightarrow T + E$. Mais ces considérations sont surtout liées à la manière dont on évalue l'arbre.

#Forme normale de Chomsky

Citons également les grammaires qui sont dites en forme normale de Chomsky si toutes les règles sont de la forme:

- $X \rightarrow YZ$;
- $X \rightarrow a$;
- $S \rightarrow \epsilon$;

avec $X, Y, Z \in V$ et $a \in T$.

Toute grammaire écrite en forme normale de Chomsky est non contextuelle et toute grammaire sans contexte peut être transformée en une grammaire équivalente en forme normale[^1].

Cette forme à l'avantage de donner une complexité pour reconnaître un mot directement proportionnelle à sa longueur.

[^1]: Chomsky, N. (1959). On certain formal properties of grammars. Information and control, 2(2), 137-167.