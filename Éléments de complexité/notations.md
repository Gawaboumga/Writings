Une fois qu'on a défini une machine de calcul - un ensemble des règles de calcul que l'on s'autorise - on peut se demander quels sont les problèmes que l'on peut résoudre, quel est le nombre minimal de règles qu'il faut appliquer pour répondre à un certain problème ou, plus simplement, comment fournir une solution. D'un point de vue historique, c'est l'inverse qui s'est produit, on a d'abord trouvé des manières de résoudre des problèmes et puis on a cherché à avoir un formalisme dans des modèles de calcul.

Laissons la question de la calculabilité de côté et attardons nous sur l'aspect lié à la complexité. Il faut d'abord observer que la complexité est généralement liée à la taille de l'entrée, que l'on dénotera $n$ par la suite, chercher une aiguille toute seule dans une boîte est plus simple que de chercher dans toute une botte de foin. On essaye donc d'associer une fonction à la complexité d'un problème en fonction de la taille de l'entrée. Naturellement, plus la taille du problème sera grande, plus sa complexité sera élevée (trier un paquet de cartes est plus compliqué que de ne trier que 3 cartes). Cela offre l'avantage de pouvoir comparer deux algorithmes, soit pour une même taille de données, soit pour le comportement général de ces complexités sur la manière dont elles évoluent en fonction de la taille de l'entrée. En pratique, on connait rarement la taille des données en entrée et on préférera étudier la manière dont la fonction grandit mais nous reviendrons sur cet aspect, plus loin.

Pour évaluer l'efficacité d'un algorithme, on le caractérise par un *ordre d' accroissement*. L'idée est que lorsque la taille de l'entrée devient suffisamment grande, on parle de *comportement asymptotique*, seuls les termes de plus grands ordres de la fonction vont demeurer. Si mon algorithme avait une complexité de type: $f(x) = x^{2}+1$, le terme $+1$ devient négligeable par rapport à $x^{2}$, et l'on dira qu'il est quadratique. Cela offre trois avantages:
- Il est plus simple de raisonner avec des ordres de grandeur pour pouvoir les comparer, plus de précisions n'apporte que peu d'intérêt dans ce type d'étude.
- Même si on est capable de fournir une fonction très précise de la complexité d'un algorithme, l'effort en vaut rarement la chandelle car tant les facteurs multiplicatifs des termes que ceux d'ordres inférieurs se feront de toute façon dominés par les effets liés à l'augmentation de la taille.
- Le seul intérêt des analyses détaillées apparaît lorsqu'il existe plusieurs algorithmes qui possèdent le même comportement général et que l'on souhaite les comparer plus finement. Mais, malheureusement, généralement les modèles de calcul sont des abstractions de la réalité et les résultats théoriques que l'on pourrait obtenir pourraient s'avérer loin des performances réellement observées.

Dans l'idée de ne garder que les ordres de grandeur, on introduit les notations suivantes pour décrire les comportements des fonctions.
- La notation la plus connue, la notation dite "grand O" $O(.)$:

$O(g(n)) = \{ f(n) | \exist c > 0, \exist n_{0}, \forall n \geq n_{0}, \quad 0 \leq f(n) \leq c g(n) \}$

C'est une définition très barbare qui exprime l'idée que la complexité qui nous intéresse $f(n)$ est bornée asymptotiquement et supérieurement par la fonction $g(n)$. Il existe toujours une valeur $c$ et une $n_{0}$ à partir de laquelle $g(n)$ sera toujours plus grande que $f(n)$.

![O(g(n)), malgré que la fonction g(n) soit inférieure à f(n) au début, à partir d'une certaine valeur n0, elle reste toujours supérieure.](/media/galleries/12233/147a7fbd-932c-44a3-973d-9eb39c126153.png)

Plus que ça, les plus assidus auront remarqué l'usage des accolades $\{\}$ synonyme d'ensemble. En effet, cette notation reprend ce qui a été dit plus tôt, puisqu'on ne s'intéresse qu'aux termes de plus haut degré, il reste une certaine flexibilité pour le restant des termes, cela décrit donc une très grande famille de fonctions. Inversement, c'est la raison pour laquelle on préfère noter $O(.)$ lorsqu'on aborde cette notion pour bien insister sur le fait qu'on s'intéresse à des fonctions. $O(n)$ a donc une sémantique en elle-même, c'est l'ensemble des fonctions bornées par la fonction $f(n)=cn$.

- Le pendant du "Grand O" est le "Grand Omega" $\Omega(.)$:

$\Omega(g(n)) = \{ f(n) | \exist c > 0, \exist n_{0}, \forall n \geq n_{0}, \quad 0 \leq c g(n) \leq f(n) \}$

Au lieu de chercher une "borne supérieure", on s'intéresse ici à une "borne inférieure asymptotiquement", c'est à dire que la complexité de la fonction ne sera jamais inférieure à une autre (à partir d'un certain $n_{0}$ bien entendu).

- Si on associe les deux notions, on obtient la notion de "(Grand)-Theta" $\Theta(.)$:

$\Theta(g(n)) = \{ f(n) | \exist c_{1}, c_{2} > 0, \exist n_{0}, \forall n \geq n_{0}, \quad 0 \leq c_{1} g(n) \leq f(n) \leq c_{2} g(n) \}$.

La fonction $f(n)$ est bornée supérieurement et inférieurement par les fonctions $c_{1}g(n)$ et $c_{2}g(n)$. C'est une relation très forte parce qu'elle borne la fonction $f(n)$ à une constante près. Cela est équivalent à dire qu'on a à la fois: $O(g(n))$ et $\Omega(g(n))$.

![Θ(g(n)), la fonction f(n) reste coincée entre les deux autres fonctions c1g(n) et c2g(n).](/media/galleries/12233/12b1fda3-482b-43eb-b4a3-13b0d1846eaa.png)

Il existe d'autres notations mais qui ont tendance à être moins utilisées ou tout du moins, confinées à des usages plus spécifiques. Notamment $f(n) = o(g(n))$ (et $\omega(.)$) qui représente le fait que $f(n)$ est dominé (respectivement domine) asymptotique $g(n)$. Ainsi que "Soft-O", noté $Õ(.)$, qui est défini comme suit: $f(n) = O(g(n) log^{k}(g(n))) \exist k$ qui traduit l'idée qu'on s'en fiche de certains détails techniques par rapport à l'algorithme en lui-même et que c'est bien la taille des données en entrée ($n$) qui incombe. Mais ces notations sont nettement plus marginales et interviennent dans des questions plus avancées.