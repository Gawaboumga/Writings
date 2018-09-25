## Langage rationnel

Les langages rationnels (ou régulier, pour nos amis belges - *regular languages*) sont définis de manière récursive.

Soit un alphabet $\Sigma$, un langage L est rationnel si et seulement si:

- L = $\emptyset$
- L = $\{\epsilon\}$
- L = $\{\sigma\} ~ \forall \sigma \in \Sigma $
- L = $L_{1} \cup L_{2}$
- L = $L_{1} . L_{2}$
- L = $L_{1}^{*}$

avec $L_{1}, L_{2}$ eux-mêmes rationnels.

## Expression rationnelle

Une expression rationnelle (*regular expression*) est une chaîne de caractères (que l'on nomme parfois *motif*) qui décrit un ensemble de mots possibles, dits réguliers. Elles permettent de représenter des langages rationnels de manière très concises tout en bénéficiant d'une certaine qualité de lecture. Elles sont également définies de manière récursives:

Soit un alphabet $\Sigma$, une expression r est rationnelle si et seulement si:

- r = $\emptyset$ est le langage $L(\emptyset) = \emptyset$
- r = $\epsilon$ est le langage $L(\epsilon) = \{\epsilon\}$
- r = $\sigma \in \Sigma $ est le langage $L(\sigma) = \{\sigma\}$
- r = $r_{1} + r_{2}$ (parfois |) est le langage $L(r_{1} + r_{2}) = L(r_{1}) \cup L(r_{2})$
- r = $r_{1} . r_{2}$ est le langage $L(r_{1} . r_{2}) = L(r_{1}) . L(r_{2})$
- r = $r_{1}^{*}$ est le langage $L(r_{1}^{*}) = (L(r_{1}))^{*}$

avec $r_{1}, r_{2}$ elles-mêmes rationnelles.

Elles présentent toutes leurs puissances dans le contexte des éditeurs de textes où elles permettent de fournir des motifs de recherche, et éventuellement d'effectuer des remplacements, adjonctions ou suppressions.

La manière d'écrire ces expressions diffèrent entre les diverses conventions. Généralement, on rajoute deux quantificateurs qui sont le "?" qui définit un groupe qui existe zéro ou une fois et le "+" qui existe au moins une fois. Ceux-ci peuvent évidemment être exprimés en combinant certaines règles de bases.

Exemple: bon(jour + soir)? définit les mots: $\{ bon, bonjour, bonsoir \}$

Théorème:

> À tout langage rationnel L, il existe une expression rationnelle r telle que L(r) = L. Et à toute expression rationnelle r, L(r) est un langage rationnel.

Attention, plusieurs expressions rationnelles peuvent définir un même langage. $ r = aa^{*} = a^{*}a $