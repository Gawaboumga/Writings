Nous allons illustrer ces notions par un exemple très classique: le tri. C'est une primitive essentielle à une multitude d'algorithmes et c'est un problème relativement simple.

Le problème posé est le suivant:
On possède une collection $L$ de $N$ éléments et on souhaiterait que tous les éléments soient triés en ne sachant comparer que des éléments deux à deux. Au final, on souhaiterait avoir: $\forall i, \forall j > i, L[i] < L[j]$ en notant $L[i]$ l'élément à la $i$e position dans la collection.

On va chercher à étudier deux solutions à ce problème en analysant la complexité liée à deux algorithmes choisis. On présentera les idées de la démonstration des complexités associées à ces algorithmes et on finira par donner des indications sur la complexité minimale de ce problème en particulier.

## Tri par sélection:

Une solution simple au problème est le tri par sélection, il consiste à toujours sélectionner le plus petit élément et à le rajouter à la liste déjà triée.

```python
def tri_par_selection(L):
    N = len(L)
    # On cherche à chaque fois l'élément le plus petit dans tous ceux qui restent, tous les positions plus petites que i sont triées.
    for i in range(N): 
        # On cherche l'élément le plus petit situé après la position i
        min_idx = i 
        for j in range(i + 1, N): 
            if L[min_idx] > L[j]: 
                min_idx = j 

        # On échange le plus petit élément qu'on a trouvé avec la valeur à la position i
        L[i], L[min_idx] = L[min_idx], L[i] 
```

Lorsqu'on commence l'algorithme, il faut chercher le plus petit élément parmi tous les éléments $N$, puis dans $N-1$ parce qu'on sait que tous les éléments restant sont supérieurs au premier élément commençant à former la liste triée, puis $N-2$ parce qu'on connaît les deux premiers éléments, et ainsi de suite ... et ce jusqu'à 0. On effectue bien cela $N$ fois, ce qui correspond à la première boucle for.

On effectuera donc: $N-1 + N-2 + ... + 1 = \sum_{i=0}^{N-1}i = \frac{1}{2}N(N-1)$ comparaisons au total et $N$ échanges de positions, car on commence par considérer le premier élément comme base de comparaison, donc c'est bien $N-1$.

La complexité s'exprime donc de la forme:
$$
f(N) = \frac{1}{2}N(N - 1) + N = \frac{1}{2}N(N + 1) = \frac{N^{2}}{2} + \frac{N}{2} = O(N^{2})
$$

## Tri fusion:

Le tri fusion consiste à fusionner des plus petites listes triées ensemble afin d'arriver à une plus grande liste triée, et ce récursivement jusqu'à arriver à la solution. Le principe de base étant que, par définition, un élément esseulé est trié. On commence donc par diviser récursivement la liste en plus petites listes jusqu'à arriver à des éléments uniques. On commence alors à les fusionner, ce qui est relativement simple à faire parce que les sous-listes sont déjà triées.

![Représentation du tri fusion](/media/galleries/12233/c22c59c8-e1f2-49f7-8706-2157ee29dfbb.png)

On peut transcrire la logique dans un langage de programmation tel que Python:

```python
def tri_fusion(L):
    tri_fusion_recursif(L, 0, len(L))

def tri_fusion_recursif(L, p, r):
    # On trie les données dans l'interval qui va de p à r
    if p < r:
        # On prend l'élément situé au milieu de l'interval p et r
        q = floor((p + r) / 2)
        # On effectue la même procédure sur la partie gauche
        tri_fusion_recursif(L, p, q)
        # Ainsi que la droite
        tri_fusion_recursif(L, q, r)
        # On fusionne les deux parties
        fusion(L, p, q, r)

def fusion(L, p, q, r):
    # On fusionne les deux sous-listes entre p et q, et q et r
    p_i = p
    q_j = q
    liste_triee = []
    while p_i < q and q_j < r:
        # Si l'élément dans la première liste est plus petit que dans la seconde
        if L[p_i] < L[q_j]:
            # On l'ajoute et on passe à l'élément suivant dans la première liste
            liste_triee.append(L[p_i])
            p_i += 1
        else:
            # Sinon, on rajoute l'autre élément à la liste
            liste_triee.append(L[q_j])
            q_j += 1

    # On quitte la boucle while parce qu'on a parcouru tous les éléments d'une des deux listes alors qu'il peut rester encore des éléments à trier, il faut donc rajouter ceux qui manquent.
    liste_triee.extend(L[p_i:q])
    liste_triee.extend(L[q_j:r])
    L[p:r] = liste_triee[:]
```

La complexité d'un tel algorithme est déjà plus compliqué à évaluer. Commençons par nous intéresser à la fonction de fusion. On "sait" qu'on ne considère qu'une seule fois chaque élément des deux sous-listes. On peut avoir deux situations extrêmes:
- Soit les listes sont inter-mêlées, le premier élément de la première liste ($L_{1}$) est plus petit que le premier de la seconde ($L_{2}$), mais le premier élément de $L_{2}$ est plus petit que le second de $L_{1}$ et ainsi de suite. Il est assez clair qu'on va devoir faire $L_{1} + L_{2}$ comparaisons parce qu'on va constamment alterner entre les deux listes.
- Soit les listes sont parfaitement disjointes, tous les éléments de la seconde liste sont plus grands que ceux de la première. Dans ce cas, on va épuiser la première liste entièrement et puis rajouter la seconde liste à la suite, on n'aura effectuer que $L_{1}$ comparaisons.

La complexité de la fusion est bornée par $O(L_{1} + L_{2})$.

Quand à la fonction tri\_fusion\_recursif, on subdivise à chaque fois les listes en deux parts égales (jusqu'à arriver à des éléments uniques), la longueur de $L_{1}$ est donc la même que $L_{2}$ (à une considération près, parce qu'on a rarement $N$ qui est pile une puissance de 2). Il n'est possible de subdiviser $N$ éléments, en 2, que "$\log_{2} N$ fois".

Maintenant observons que, la première étape consiste à fusionner les éléments esseulés, on doit donc appliquer $\frac{N}{2}$ fois la fusion de liste de longueur $1$, on a donc $\frac{N}{2} * (1 + 1) = N$ pour la première étape, puis on va fusionner des listes de longueurs $2$, mais on n'en aura que $\frac{N}{4}$, on obtient donc $\frac{N}{4} * (2 + 2) = N$. A chaque étape de l'algorithme, la quantité de travail à effectuer est à la même (ici $N$) et il n'y a $\log_{2} N$ étapes possibles au maximum.

La complexité est donc bornée par: $O(N \log N)$. Observer qu'on note généralement $\log$ sans spécifier la base suite à la formule du changement de base des logarithmes qui ne multiplie que par une constante.
Ce $O(N \log N)$ est très largement meilleur que le tri par insertion en $O(N^{2})$, si on prend $N = 1 000 000$, on aurait $1,37 * 10^ {7}$ opérations au lieu de $10^{12}$.

## Master Theorem:

L'argument que nous avons employé pour calculer la complexité du tri fusion est lié à un théorème qu'on appelle "Master Theorem"[^BENTLEY, Jon Louis, HAKEN, Dorothea, et SAXE, James B. A general method for solving divide-and-conquer recurrences. ACM SIGACT News, 1980, vol. 12, no 3, p. 36-44.]. Il s'agit d'un théorème mathématique qui visait à unifier toute une famille de démonstrations sur la complexité des algorithmes où on a la propriété qu'on effectue le même travail (ici la fusion), à chaque étape de l'algorithme. C'est un théorème plus profond parce qu'il permet de "résoudre" des systèmes d'équations fonctionnelles qui sont récurrentes (qui font appel à elles-mêmes) mais qui doit être appliqué dans des conditions très précises.

Cela permet de répondre à trois types de cas:

- Soit on a de plus en plus de sous-cas dont la somme des complexités des nœuds terminaux dépasse tout la complexité introduite par les étapes précédentes (complexité croissante).
- Soit la charge de travail reste constante en fonction des étapes (complexité constante) et il ne reste plus qu'à multiplier la complexité d'une étape par la hauteur de cet arbre de complexité. Le cas que nous avons rencontré avec le tri fusion.
- Soit la charge de travail diminue parce qu'on est capable d'évincer des pans entiers dans les données (complexité décroissante).

![Représentation des cas du Master Theorem et de l'arbre de complexité](/media/galleries/12233/e304f43a-f6b6-4e87-b1b6-d5a283318770.png)

Ce n'est pas le seul type de démonstration pour les études de complexité des algorithmes, mais cela englobe une bonne partie des problèmes usuels.

## Complexité minimale:

Nous l'avons vu, un algorithme naïf de tri est en $O(N^{2})$, en réfléchissant beaucoup, on voit qu'on peut arriver en $O(N \log N)$. Mais est-il possible de faire mieux ?

La réponse est comme souvent: "ça dépend". Au sens commun, il est largement accepté que $\Omega( N\log N)$ est la complexité minimale pour trier une liste si on ne possède que l'opérateur de comparaison deux à deux. On peut pinailler sur le fait que: 1) si l'on change de modèle de calcul, la réponse peut très largement variée et même devenir en $\Omega (N)$ si on ne travaille qu'avec des entiers. 2) on peut obtenir des bornes un peu plus précises mais qui restent néanmoins bornée sémantiquement par $\Omega(N\log N)$.

Une démonstration particulièrement élégante de cette complexité minimale est issue d'un modèle de calcul basé sur des arbres algébriques (*algebraic computation trees*)[^BEN-OR, Michael. Lower bounds for algebraic computation trees. In : Proceedings of the fifteenth annual ACM symposium on Theory of computing. 1983. p. 80-86.], qui correspondent, sans rentrer dans les détails, à la limite qu'on s'impose: "On ne peut considérer que deux éléments à la fois et dire si l'un est plus petit que l'autre". L'argument est le suivant:

À chaque étape de l'algorithme, on n'est capable que de comparer deux éléments. Quelque soit la réponse de cette comparaison, il faudra effectuer un choix. On aura donc deux embranchements possibles, qui vont aboutir eux-mêmes à répondre à une nouvelle question sur la comparaison de deux éléments, éventuellement nouveaux. Or, on sait que toutes les permutations de la liste initiale sont possibles ($N!$). Et on veut que notre algorithme donne la réponse correcte pour tous ces cas, il doit donc être possible, à partir de n'importe quelle réponse d'une comparaison, d'arriver à cette liste triée. Et à chaque fois, on a deux possibilités, soit la comparaison disait que $a$ était inférieur à $b$, soit l'inverse. Le nombre de chemins possibles croît de manière exponentielle $2^{k}$. Il ne reste plus qu'à égaler les deux, on aura notre réponse:

$$2^{k} = N! \Leftrightarrow k = \log_{2}(N!) \approx k = O(N \log N)$$

![Arbres de calcul algébriques](/media/galleries/12233/1c91edaa-374e-4ac6-98e9-e54892e2e363.png)

Pour l'équivalence du $\log_{2}(N!)$, il faut invoquer des notions plus avancées, mais faisons remarquer que $N! = \prod_{i=1}^{N}i$ et que le logarithme d'un produit est la somme des logarithmes et donc qu'on a $\sum_{i=1}^{N}\log i$, ce qui est bien borné par $O(N \log N)$. On peut également invoquer la formule de Stirling ou les travaux de Landau (à qui on attribue l'invention du symbole $O(.)$) pour fournir des bornes plus "précises". Il s'agit ici d'une démonstration dite *universelle*, on montre que tous les cas peuvent s'exprimer au travers de cet argument, mais il existe des *existentielle*, où on démontre qu'il existe au moins un cas où il est nécessaire d'atteindre cette complexité.