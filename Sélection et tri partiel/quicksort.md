
Une solution élégante et générale au problème de sélection est basée sur l'algorithme du *quicksort*. En effet, celui-ci se base sur la propriété fondamentale que, sur base d'un élément pivot, tous les éléments plus petits que celui-ci seront du même côté et ceux plus grands, de l'autre. La position du pivot étant de facto le rang de celui-ci. Il ne restera plus qu'à prendre l'embranchement qui contiendra le rang souhaité jusqu'à aboutir à celui-ci.

```python
def selection(A, i, j, rank):
    if i == j:
        return A[i]

    pivot = chose_pivot(A, i, j) # Stratégie de sélection du pivot
    partition(A, i, j, pivot) # Partitionement, tous les éléments entre i et pivot - 1 seront plus petits que le pivot et pivot + 1 à j seront plus grands
    k = pivot - i + 1
    if rank == k: # Si le pivot correspond au rang
        return A[pivot]
    elif rank < k: # Si le rank est à gauche du pivot
        return selection(A, i, pivot - 1, rank)
    else: # A droite
        return selection(A, pivot + 1, j, rank - k)
```

La complexité d'une telle fonction est déterminée par deux critères:
- L'algorithme de partitionnement, qui sépare tous les éléments inférieurs au pivot de ceux supérieurs. Néanmoins, celui-ci peut facilement être implémenté en $\Theta(j-i)=\Theta(n)$.
- Le choix du pivot et toutes ses conséquences.

Commençons par le cas idéal, supposons que le pivot sélectionné correspond pile-poil à l'élément médian. L'espace de travail sera alors divisé en 2 et, on va effectuer la récursion sur l'un des deux. La charge de travail sera donc $O(n) + O(n/2) + O(n/4) + ... = \Omega(n)$, soit linéaire et seulement avec un facteur 2 ! On fera remarquer que, contrairement au quicksort idéal, la charge de travail diminue à chaque étape, alors que dans le tri, la charge de travail reste constante, on continue de partitionner $O(n)$ éléments à chaque étape, sachant qu'il existe $O(\log n)$ étapes, d'où le $\Omega(n \log n)$.

D'autre part, le pire cas peut être beaucoup plus catastrophique. Il suffirait que les pivots choisis soient, à chaque étape, l'élément maximal ou minimal. Il n'y aurait donc, de fait, pas de partitionnement et la charge de travail ne diminuerait que de $1$. On se retrouverait alors avec $n$ étapes et une complexité en $O(n^2)$. Ce qui est catastrophique en pratique.

Seulement, on peut se demander quelle est la probabilité de choisir le mauvais pivot à chaque étape ?

Dans ce pire cas, seuls $2$ éléments sur les $n$ sont totalement problématiques. À chaque étape, on effectue le même choix et ce, de manière indépendante, on se retrouve avec:

$$\prod_{i=2}^{n} \frac{2}{i} = \frac{2^{n-1}}{n!}$$

Si vous êtes comme moi, cette probabilité ne vous dit strictement rien, mais si on prend $n = 20$, $2^{n-1} = 5.2\mathrm{e}{5}$ et $n! = 2.4\mathrm{e}{18}$. Ce qui est extrêmement peu probable.

Or, ce raisonnement est un peu fallacieux parce que si on avait pris le second pire élément, la situation n'aurait pas été franchement différent, ni même le troisième, etc... Il vaut mieux se poser la question de quelle probabilité peut-on espérer en moyenne ?



En tentant de majorer la complexité, on peut considérer que l'élément que l'on cherche se retrouvera, à chaque fois, du côté de la partition ayant le plus d'éléments. On définit également une variable aléatoire, indicatrice, $X_{k}$ qui représentera le choix du pivot $k$ et qui vaut $1$ pour la valeur de $k$ et $0$ sinon. On se retrouve avec la récurrence suivante:

$$T(n) \leq \sum_{k=1}^{n} X_{k} (T(max(k - 1, n - k) + O(n)) = \sum_{k=1}^{n} X_{k} T(max(k - 1, n - k) + O(n)$$

La complexité $T(n)$ est bornée par la taille de la plus grande partition (fonction max) additionnié du coût du partitionnement ($O(n)$ et qui ne dépend pas du pivot) et pondéré par le choix du pivot. 

Mais on s'intéresse au cas moyen, on va chercher à calculer l'espérance de cette fonction de travail:

$$\begin{align*}
E[T(n)] & \leq E[\sum_{k=1}^{n} X_{k} T(max(k - 1, n - k) + O(n)] \\
& = E[\sum_{k=1}^{n} X_{k} T(max(k - 1, n - k)] + O(n) \\
& = \sum_{k=1}^{n} E[X_{k}] E[T(max(k - 1, n - k)] + O(n) \\
& = \sum_{k=1}^{n} \frac{1}{n} E[T(max(k - 1, n - k)] + O(n) \\
\end{align}$$

Maintenant, on sait que la fonction max travaillera avec au plus $n/2$ éléments.

$$E[T(n)] \leq \frac{1}{n} \sum_{k=n/2}^{n-1} E[T(n)] + O(n)$$

Et, supposons que, pour une taille suffisamment petite, la charge de travail soit essentiellement constante: $\exist k, T(n \leq k) = O(1)$ ainsi que $O(n)$ soit la solution de $E[T(n)]$. Cela voudrait dire que:

$$\begin{align*}
E[T(n)] & \leq \frac{1}{n} \sum_{k=n/2}^{n-1} ck + an \\
& = \frac{c}{n} (\sum_{k=1}^{n-1} k - \sum_{k=1}^{n/2} k) + an \\
& = \frac{c}{n} (\frac{3n^2}{8} + \frac{n}{4} - 1) + an \\
& = c (\frac{3n}{8} + \frac{1}{4} - \frac{1}{n}) + a \\
& = cn - o(n) = O(n)\\
\end{align*}$$

On en conclue que la complexité est en moyenne linéaire.
