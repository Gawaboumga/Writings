# Langage sans contexte

Le problème avec les automates finis est qu'ils ont une mémoire finie stockée dans leurs états. Ceci permet quand même de reconnaître des langages simples. Mais que ce passe-t-il si on ajoute une mémoire non bornée en plus ?

## Exemple

Prenons le langage de tous les palyndromes:

$$ L_{pal@} = \{ w @ w^{R} | w \in \{ 0, 1 \}^{*} \} $$

avec $w^{R}$ qui signifie le mot écrit à l'envers, exemple: "$01$"$^{R}$ = "$10$".

Pour reconnaître un tel langage, en ne lisant qu'une seule fois chaque caractère, on pourrais écrire un code de ce type:

```python
def palyndrome():
	c = read_char()

	if c == "@":
		return True

	if c == '0':
		r = palyndrom()
		if not r:
			return False
		c = read_char()
		return c == '0'

	if c == '1':
		r = palyndrom()
                if not r:
			return False
		c = read_char()
		return c == '1'
```

On fera deux remarques:

- Premièrement, nous voyons que l'espace mémoire n'est pas borné, on peut avoir une récursion aussi profonde qu'on le désire, et dans notre cas, est égale à cette profondeur.
- Deuxièmement, il est récursif et peut être converti en un algorithme non récursif en employant une pile (*stack*) en appui.

Enfin, il est facile de créer une grammaire sans contexte qui définit le même langage:


Avec pour idée qu'une règle de type: $S \rightarrow 0 S 0$ peut s'interpréter comme: "Je dois lire un $0$, puis un mot qui peut être généré par $S$ et enfin, un $0$". Cette vision du problème n'est vraie que pour les langages sans contexte parce qu'on a une seule variable à la gauche de la règle.