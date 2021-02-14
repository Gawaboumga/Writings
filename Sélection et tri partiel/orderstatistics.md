
Les fonctions *minimum* ou *maximum* sont des fonctions qui apparaissent très régulièrement en informatique tant leurs applications sont nombreuses. Il est néanmoins plus rare de s'intéresser à la médiane, à des quantiles précis ou d'autres valeurs plus arbitraires. Ces questions sont d'autant plus critiques lorsqu'on fait de l'analyse de performance, les temps relevés suivent le plus souvent des distributions de type poisson ou bimodale et on peut s'intéresser aux temps des quantiles 99%, 99.9%, ... pour des questions de contrat et de qualité de prestation de service (*SLA*). On peut regrouper tous ces types de requêtes sous un nom commun: la statistique d'ordre (*order statistics*).

Et on peut définir le problème de manière plus générale comme suit:

Étant donné un ensembe $A$ de $n$ nombres (distincts) et un entier compris entre 1 et $n$, on cherche à déterminer l'élément $x$ de $A$ tel qu'il est plus grand que $i-1$ éléments de $A$.

Avec les cas particuliers que le *minimum* est tel que $i = 1$, le *maximum* correspond à $i = n$ et la médiane à *$i = n/2$*.

Une solution évidente à ce type de problèmes consiste à trier la collection et à prendre l'élément à la position demandée. Seulement, on comprend bien qu'intuitivement, il y a un problème, trier est une opération en $O(n \log n)$ mais chercher le *minimum* n'est qu'en $O(n)$ (complexités exprimées en nombre de comparaisons). Mais où se cache donc cette complexité intermédiaire ?

Mais d'abord, observons un autre problème, au lieu de chercher le *maximum* et puis le *minimum*, cherchons à la fois le *maximum* et le *minimum* d'un même tenant. Au lieu de comparer deux fois tous les éléments pour obtenir le *maximum* ou le *minimum* et donc avoir une complexité de $2n$ comparaisons, on peut profiter du fait que si l'élément considéré est supérieur à celui actuellement maximum, il ne sert alors à rien de tester s'il est inférieur au minimum.

En pratique, au lieu de comparer chaque élément de l'ensemble avec l'élément minimal ou maximal courant, on compare d'abord chacune des paires de l'ensemble et puis seulement on compare à l'élement minimal ou maximal actuel.

```python
def find_min_or_max(A, inequality):
    target_value = A[0]
    for e in A[1:]: # Pour chaque élément de l'ensemble
       if inequality(e, target_value): # S'il est plus grand ou plus petit
          target_value = e # On modifie l'élément actuel
       return target_value
```

par rapport à:

```python
def min_max(A):
    min = A[0]
    max = A[1]
    if max < min:
        min, max = max, min
 
    for i in range(2, len(A), 2):
        if A[i] < A[i + 1]:
            if A[i] < min:
                min = A[i]
            if max < A[i + 1]
                max = A[i + 1]
        else:
            if A[i + 1] < min:
                min = A[i + 1]
            if max < A[i]
                max = A[i]
    return min, max
```

[[attention]]
| Les conditions de bord ne sont pas gérées proprement dans ces codes d'exemple, il faut faire attention quand les collections sont vides ou que la taille de la collection est paire ou impaire.

On observe que dans la fonction *min_max*, on effectue au maximum $3$ comparaisons par tour de boucle, mais on en effectue que $n/2$. On obtient au final $\frac{3n}{2}$ au lieu de $2n$, ce qui est un gain non négligeable de $n/2$ pour quelque chose qui a l'air pourtant trivial ! Le gain peut sembler un peu dérisoire en pratique, mais l'opération de comparaison peut parfois être plus lourde, comme dans le cas de chaînes de caractères par exemple.

[[information]]
| En pratique, je ne suis pas entièrement convaincu que cela soit vraiment beaucoup plus rapide dans des conditions réelles "simples" comme des nombres (entiers ou flottants) à cause de la dépendance sur la condition et les possibilités de vectorisation, mais c'est un autre débat.

Pour l'exercice, on peut également se demander ce qu'il advient lorsqu'on cherche le second plus petit élément. L'astuce qu'on a employé sur le cas précédent ne fonctionne plus. En effet, la propriété employée ne tient pas, en particulier, si la liste est triée par ordre décroissant et on serait amener à effectuer $4n$ comparaisons au final. Par contre, on peut appliquer une technique similaire à la recherche du minimum et revenir à $2n$ comparaisons. Mais il est possible de faire mieux !

On peut organiser un tournoi, en comparant chacune des paires individuellement, à chaque tour, on garde l'élément le plus petit jusqu'à ce qu'il n'en reste plus qu'un. L'astuce est que, lors de ce tournoi, le plus petit élément a du rencontrer le second plus petit élément. Et il suffit de chercher ce fameux second parmi tous les perdants ayant eu le plus petit élément comme opposant. On a donc pour complexité: $n/2$ la première fois, puis $n/4$, et ainsi de suite: $n/2 + n/4 + .. + 1 = n - 1$ avec $\log(n)$ tournois intermédiaires. Au final, la complexité peut être égale à $O(n + \log(n))$.

Seulement, on commence à percevoir deux problèmes:
- Premièrement, pour obtenir cette complexité, on est obligé de pouvoir déterminer quels étaient les opposants de l'élément vainqueur. Ce qui nécessite de l'espace mémoire supplémentaire par rapport aux cas précédemment mentionnés. 
- Deuxièmement, les algorithmes proposés sont fondammentalement différents, et il semble difficile de pouvoir généraliser ces techniques pour le cas plus général.
