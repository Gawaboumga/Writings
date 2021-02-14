
On peut également démontrer cette complexité d'une autre manière. En effet, on peut représenter la charge de travail sous la forme d'un arbre, où chaque décision, chaque nœud, peut avoir une plus ou moins grande complexité et où le nombre de sous-branches considérés importe.

Commençons par compter le le nombre d'appels récursifs qui doivent être effectués au final. Au début, on a une collection de $n$ éléments. À chaque appel récursif, on va supprimer un élément de cette collection (le pivot) et recommencer sur la partie qui nous intéresse. Il y aura donc au plus $n + 1$ = $\Theta(n)$ appels récursifs, peu importe comment ceux-ci opèrent, pour aboutir aux feuilles terminales de taille 0. La preuve se fait par induction, étant donné que les entrées seront divisées en deux intervalles de $k$ et $n - k - 1$ éléments respectivements.

Maintenant, chaque décision de l'arbre, chaque partitionnement des données, peut s'effectuer en $n - 1 = \Theta(n)$ comparaisons.

Il ne reste plus qu'à combiner ces deux éléments ensemble. Il existe deux techniques:

- Soit on additionne toutes les tailles d'entrées associées à tous les appels récursifs.
- Soit on compte le nombre de fois où chaque paire est comparée entre-elle.

C'est une approche plus "verticale" que "horizontale" de l'arbre de travail.

On note $a_{i}$ la valeur de $A$ au rang $i$ (à comptant les rangs à partir de 1). Et on note $C_{ij}$ le nombre de fois que les valeurs $a_{i}$ et $a_{j}$ sont comparées. Le nombre total de comparaisons sera alors notée par la variable aléatoire:

$$X = \sum_{i=1}^{n}\sum_{j=i+1}^{n} C_{ij}$$

Ici, on s'intéresse à l'espérance:

$$\begin{align*}
E[X] & \leq E[\sum_{i=1}^{n}\sum_{j=i+1}^{n} C_{ij}] \\
& = \sum_{i=1}^{n}\sum_{j=i+1}^{n} E[C_{ij}] \\
\end{align}$$

Mais comment évaluer cette partie $C_{ij}$ ? Il faut observer que, si une paire est comparée, elle ne le sera plus par la suite. Ceci est lié au fait que les comparaisons n'opèrent que dans le cadre du partitionnement, où le pivot est comparé à tous les autres éléments une seule et unique fois, et aucune autre comparaison est effectuée.

Donc pour avoir $a_{i}$ et $a_{j}$ comparés entre-eux, il faut que: 1) l'un des deux soit le pivot. 2) ils soient dans le même sous-ensemble de la récursion.

On se retrouve avec le fait que, par définition:

$$\begin{align*}
E[C_{ij}] & 0 P(C_{ij} = 0) + 1 P(C_{ij} = 1) \\
& = P(C_{ij} = 1) \\
& = P(a_{i} et a_{j} soient comparés) \\
\end{align}$$

Ceci est beaucoup plus "simple" à calculer ! Nous l'avons dit, pour être comparés, les éléments doivent appartenir au même sous-ensemble et que l'un des deux éléments soit choisi pour pivot.

Commençons par le cas simple du *quicksort*. La probabilité correspond au problème du **coupon collector problem**, chacun des éléments a une chance d'être choisi parmi tout le sous-ensemble et les deux éléments sont indépendants, on a $ 2 / (j-i + 1)$.

$$\begin{align*}
E[X] & \sum_{i=1}^{n}\sum_{j=i+1}^{n} P(a_{i} et a_{j} soient comparés) \\
& = \sum_{i=1}^{n}\sum_{j=i+1}^{n} 2 / (j-i + 1) \\
& = \sum_{i=1}^{n}\sum_{k=1}^{n-i} 2 / (k + 1) \\
& \leq \sum_{i=1}^{n}\sum_{k=1}^{n} 2 / (k + 1) \\
& = 2n \sum_{k=1}^{n} 1 / (k + 1) \leq 2n 2n \sum_{k=1}^{n} 1 / k \\
& = 2n H_{n} \\
& = 2n \Theta(\log{n}) \\
& = O(n \log{n}) \\
\end{align}$$

Avec $H_{n}$, le $n$ième élément des nombres harmoniques.
Or, dans le cas du *quickselect*, la position du rang intervient puisqu'on ne considère que le sous-ensemble qui le contient. Au lieu du facteur: $ 2 / (j-i + 1)$, on se retrouve avec l'expression:

$$\frac{2}{max(j-i + 1, j-k + 1, k-i + 1)}$$

C'est nettement plus gênant à analyser ... Une astuce bête et méchante consiste à diviser l'espace des possibilités en région. Ici, on prendra le cas que $k < n/2$, l'autre étant symmétrique.

IMAGE GENIALE

Comment interpréter ce diagramme ? Prenons, la région où $i,j > k$, le plus grand triangle, borné par $i=k, i=j$ et $i=j$. À l'horizontal, les points sont de la forme: $k + x$ où il y a donc $x$ éléments à traiter, avec une probabilité de $2/x$ et on a $n-k$ "verticales", au final, on se retrouve avec $2(n-k)$.

On peut additionner toutes les parties ensemble et obtenir une expression du type:

$$ (2n (1 + ln \frac{n}{n-k}) + 2k ln \frac{n-k}{k}(1 + o(1))$$

Expression qui est maximisée pour $k = n/2$, on se retrouve au final avec:

$$2n (1 + ln 2 + o(1)) \leq 4n + o(n) = O(n)$$

CLÉMENT, Julien, FILL, James Allen, THI, Thu Hien Nguyen, et al. Towards a realistic analysis of the QuickSelect algorithm. Theory of Computing Systems, 2016, vol. 58, no 4, p. 528-578.

BLUM, Manuel, FLOYD, Robert W.. , PRATT, Vaughan R.. , et al. Time bounds for selection. J. Comput. Syst. Sci., 1973, vol. 7, no 4, p. 448-461.
SCHÖNHAGE, Arnold, PATERSON, Michael S., et PIPPENGER, Nicholas. Finding the median. 1975.