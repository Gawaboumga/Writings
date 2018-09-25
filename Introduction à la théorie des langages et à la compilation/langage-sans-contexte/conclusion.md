#Conclusion

Il ne reste plus qu'à conclure ce chapitre en présentant les opérations possibles sur les langages sans contexte et à présenter des langages qui ne sont pas sans contexte.

#Opération sur les langages sans contexte

##Union
Étant donné deux grammaires représentés par leur tuple $G_{1} = \langle V^{1}, T^{1}, P^{1}, S^{1} \rangle$ et $G_{2} = \langle V^{2}, T^{2}, P^{2}, S^{2} \rangle$, calculer leur union, soit $L(A_{1}) \cup L(A_{2})$, est relativement simple. Il suffit de créer une nouvelle grammaire $G = \langle V^{1} \cup V^{2} \cup S, T^{1} \cup T^{2}, P, S \rangle$ avec $P = P^{1} \cup P^{2} \cup \{ S \rightarrow S^{1}, S \rightarrow S^{2} \}$.

##Intersection
L'intersection ne fonctionne malheureusement pas. Prenons l'exemple repris plus bas: $L_{1} = \{ a^{n}b^{n}c^{k} ~ | ~ \forall k, n \in \mathbb{N} \}$ et $L_{2} = \{ a^{k}b^{n}c^{n} ~ | ~ \forall k, n \in \mathbb{N} \}$. L'intersection donne des mots qui appartiennent aux langages contextuels.

##Complément
Le complément ne fonctionne pas non plus. En effet, il suffit de se rendre compte que $L_{1} \cap L_{2} = \overline{(\overline{L_{1}} \cup \overline{L_{2}})}$ or l'intersection n'est pas close.

##Vide
Tester si un automate accepte au moins un mot est compliqué mais décidable[^1].

##Inclusion & Égalité & Universalité
Indécidable[^1].

Notons que les langages sans contexte sont également clos par la concaténation ou l'opérateur de Kleene.

#Langage non "sans contexte"

Les langages sans contexte ont l'air de représenter une bonne partie des instructions que l'on peut trouver dans des programmes. Quels sont donc ces autres langages ?

Les automates à pile possèdent en quelque sorte une mémoire; ils sont capables de retenir combien de fois ils ont vu un symbole et de comparer ce nombre à une autre séquence.

Il existe énormément de langages non "sans contexte". Seulement, il est difficile de trouver de bons exemples. Le plus célèbre est sans doute: $L = \{ a^{n}b^{n}c^{n} ~ | ~ \forall n \in \mathbb{N} \}$.

Pour montrer qu'un langage n'est pas "sans contexte", on emploie, soit le lemme de la pompe (*pumping lemma*) qui était originellement conçu comme un argument de caractérisation pour les langages sans contexte, soit le théorème de Parikh[^2] ou encore le lemme d'Odgen qui est une réelle extension du *pumping lemma*[^3].

L'idée est que l'on commence par compter le nombre de $a$ dans le mot, qu'on utilise ce compteur pour faire correspondre le nombre de $b$ et qu'on se retrouve sans aide afin de dénombrer les occurences de $c$.

[^1]: Hopcroft, John E.; Ullman, Jeffrey D. (1979). Introduction to Automata Theory, Languages, and Computation (1st ed.). Addison-Wesley.
[^2]: Parikh, R. J. (1966). On context-free languages. Journal of the ACM (JACM), 13(4), 570-581.
[^3]: Ogden, W. (1968). A helpful result for proving inherent ambiguity. Theory of Computing Systems, 2(3), 191-194.