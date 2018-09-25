# Langage naturel:

La notion de langage est très vaste et il serait compliqué d'aborder tous les aspects de cette notion. Nous envisagerons donc les principales caractéristiques de cette notion.

Le TLFi nous donne pour définition[^1]:
> Faculté que les hommes possèdent d'exprimer leur pensée et de communiquer entre eux au moyen d'un système de signes conventionnels vocaux et/ou graphiques constituant une langue

Cette définition soutend que les langages sont construits sur base d'un ensemble de briques élémentaires, appellées *mots*, que l'on nomme *vocabulaire* et qui sont reliés entre eux par un système de règles afin de composer des *phrases*. Enfin, toute cette structure vise à exprimer des idées, des concepts et du sens afin de communiquer. Ainsi, il est important de dissocier la notion de $forme$ et $sens$.

La $forme$ est attachée à l'ensemble de règles qui régissent la construction d'un phrase dans un langage donné. On parle plus généralement de syntaxe. Ce sont toutes ces règles d'agencement des lexèmes qui définissent les phrases valides. Pour exemple, dans un langage naturel comme le français, nous employons des lettres (*signes*) définis sur l'alphabet latin-français, l'académie française définie un ensemble de mots considérés comme autorisés qui sont composés de ces lettres et sur lesquels des règles de grammaire, ponctuation, orthographe ou de conjugaison viennent s'appliquer. Nous pouvons alors combiner tous ces mots afin de former des phrases correctes d'un point de vue syntactique et grammatical.

La syntaxe n'est pas seullement une propriété des langages naturelles mais également de formaux tels que les langages de programmation. C'est la première tâche des compilateurs de s'assurer du bon respect de ces règles.

Le $sens$ présente un tout autre aspect de langue. La sémantique s'intéresse aux structures en observant les mécanismes propres à la construction du sens. Les blocs élémentaires deviennent les *lexèmes* ou *lemmes* et font parti d'un *lexique*, ils sont alors combinés pour former des phrases grâce à la grammaire.

Bien sûr, sur un même lexique, nous sommes capables de définir des rapports entre les mots (toute la famille des -onymie (du grec ὄνυμα, "mot"):

- rapport formel: homonymie, homophonie, homographie, paronymie.
- rapport sémantique: acronymie, antonymie, autonymie, éponymie, holonymie, hyperonymie, hyponymie, méronymie, odonymie, pantonymie, synonymie ou toponymie.

Formaliser la syntaxe et la sémantique est une habitude très ancienne. L'académie française, créée en 1635 (afin de controller la langue et donc l'esprit) a pour mission[^2]:

> La principale fonction de l’Académie sera de travailler, avec tout le soin et toute la diligence possibles, à donner des règles certaines à notre langue et à la rendre pure, éloquente et capable de traiter les arts et les sciences.

# Langage formel:

Les linguistes et les informathématiciens ont créé une théorie dite des langages qui visent à décrire les langages formels. L'idée est de capturer les principaux concepts des langages naturels et de les transcrire de manière plus formelle afin de disposer d'outils plus avancés afin de les manipuler ainsi que de proposer des définitions communes à tous.

Un langage formel est une ensemble de mots qui sont composés d'une séquence finie de symboles, lettres ou lexèmes qui font parti d'un alphabet, le plus souvent, fini. Les mots sont donc des suites d'éléments de cet alphabet qui sont parfois qualifiés de bien formés ou de formules bien formées. Un langage formel est souvent défini par une grammaire formelle, telle que les grammaires algébriques et analysé par des automates.

La théorie des langages ne s'intéresse qu'à l'aspect purement syntaxique de tels langages et vise à capture ce qui est commun à toutes les syntaxes des langues naturelles. En informatique, les langages formels sont souvent utilisés comme base pour la définition des langages de programmation et d'autres systèmes ; les mots d'un langage comportent alors aussi un sens, une sémantique. Cette théorie sert également de base à celle de la complexité où les problèmes de décision sont généralement exprimés par un tel modèle et qui peuvent être analysé ou reconnu par des ressources limitées (classes de complexité). En mathématique, un niveau d'abstraction est encore rajouté, et ils peuvent alors représenter la syntaxe d'un système axiomatique (/!\Gödel théorème).

L'étude des langages formels comporte l'ensemble des moyens de description et d'analyse de ces langages, comme les grammaires formelles pour la génération ou les automates pour la reconnaissance. On peut également définir des notions plus avancées au travers de l'apprentissage, de la traduction (NPL) ou de la compilation.

## Une question de mots:

Un mot est une suite finie *w* d'éléments (symboles) appartenant à un ensemble fini non vide (alphabet) $\Sigma$:

- La longueur d'un mot $w$ est défini comme le nombre de symboles dans $w$ et est un naturel positif $\mathbb{N}^{*}$; et souvent noté par $|s|$. Le mot vide est le seul mot de longueur 0, et est noté traditionnellement par $\epsilon$.
- Un mot de longueur k est une suite $ u=(a_{1},a_{2},...,a_{k}) $ de k lettres. Ou, avec la notation condensée, $ u=a_{1}a_{2} \cdots a_{k} $ avec $ a_{i} \in \Sigma $.
- L'ensemble des mots de longueur n est noté $\Sigma^{n}$.
- L'ensemble de tous les mots sur $\Sigma$ est la clôture de Kleene et est noté $\Sigma^{*}$:
$$ \Sigma^{*} = \bigcup_{n \in \mathbb{N}} \Sigma^{n} $$
- On définit également l'opérateur dyadique de concaténation très naturellement. À toute paire de mots $s$ et $t$ appartenant à $ \Sigma^{*} $, on associe à $s_{1}s_{2} \cdots s_{n}$ et à $t_{1}t_{2} \cdots t_{m}$, le mot $s_{1}s_{2} \cdots s_{n}t_{1}t_{2} \cdots t_{m}$ de longueur $ n + m $ et noté st. Remarquons que l'opérateur n'est pas commutatif, $st \ne ts $.

On se retrouve donc face à, ce qu'on appelle en algèbre, un monoïde libre généré par $ \Sigma $.

Par exemple, prenons $\Sigma = \{0, 1\}$, le mot $s = 010$ est de longueur $3$ et $t = 11$ est de $2$, le résultat de la concaténation est $st = 01011$, de longueur $5$. Et si on concatène $\epsilon$ à $st$, on retombe sur $st = 01011$, de longueur $5$. En outre, $\Sigma^{2}$ correspond à $\{ 00, 01, 10, 11 \}$ et $\Sigma^{*} = \{ \epsilon, 0, 1, 00, 01, 10, 11, 000, ... \}$.

Un langage est alors simplement un sous ensemble de mots: $ L \subseteq \Sigma^{*} $.

Maintenant une question toute naturelle apparaît: "Comment déterminer l'appartenance d'un mot à un langage ?". De manière plus générale, soit un langage L et un mot w, est ce que w $\in$ L ?

Cette question peut s'exprimer au travers de nombreux problèmes. Est-ce que ce nombre est premier ? Est-ce un théorème valide ? Seulement, la réponse est souvent loin d'être évidente et peut même soulever des difficultés insoupçonnées.

Une telle question peut être résolue par des machines abstraites (algorithmes) qu'on appelle accepteur (*acceptor*) ou reconnaisseur (*recognizer*). Attention, si le mot n'appartient pas au langage, les reconnaisseurs peuvent très bien finir leur exécution ou continuer sans jamais s'arrêter. S'ils terminent lorsqu'un mot n'appartient pas au langage, on parle alors de décideur (*decider*).

[^1]: http://atilf.atilf.fr/
[^2]: http://www.academie-francaise.fr/linstitution/les-missions
