# Conclusion

Nous l'avons vu, ce modèle de calcul, initialement introduit comme curiosité, présente une vraie profondeur et de nombreuses difficultés sujettes à d'importantes recherches. Les algorithmes I/O sont généralement fort différents de ceux s'intéressant aux aspects temporaux et présentent souvent des solutions élégantes. L'un des points forts de ce modèle est que les algorithmes peuvent souvent être modifiés afin d'incorporer du parallélisme de manière plus simple, une meilleure séparation des données introduisant moins de problème de concurrence.

Ils visent donc à répondre à différentes problématiques:

- Les données sont trop grandes pour être traitées directement en mémoire, il faut donc les charger petit à petit et éviter d'effectuer trop de transferts avec des bases de données qui peuvent, peut-être, être situées à l'autre bout du monde.
- Les opérations mémoires ont un coût, accéder aux éléments de manière aléatoire prend plus de temps que de manière séquentielle. Charger les données par bloc permet d'économiser le nombre d'accès et il est fort probable que l'on souhaite accéder aux donnés adjacentes, comme dans le cas d'une boucle *for*.
- Ce modèle considère que les opérations du côté CPU n'ont pas de coût. Cette hypothèse est forte mais supportée par le fait que certaines opérations peuvent être effectuées en une demie nanoseconde côté CPU alors que chercher des données sur le disque dur peut prendre plusieurs millisecondes, cela représente un facteur un million !
- Étudier un algorithme sous un autre aspect permet de mieux le connaître. Ceci permet également de définir des nouvelles notions de complexité, est-ce qu'un algorithme optimal de manière temporelle et de manière I/O est-il encore plus optimal ? Est-ce qu'il existe une équivalence simple entre ces modèles de calcul et ceux temporaux ? Une réponse à cette dernière question a été présentée récemment et la réponse, assez positive, est exceptionnelle[^WILLIAMS18].

L'idéal est donc de trouver des algorithmes optimaux dans plusieurs modèles comme le *merge-sort* ou les *B-trees*. Seulement, les algorithmes I/O ont tendance à introduire une complexité d'implémentation qui peut se traduire par une lenteur dans les modèles temporels, c'est surtout le cas pour les algorithmes ayant attrait aux graphes. Et ce qui intéresse les gens est essentiellement le temps d’exécution. La situation est d’ailleurs très claire avec le « *list ranking problem* », en complexité temporelle, on a un bête algorithme (il suffit de parcourir la liste) en $O(N)$ (thèse de James C. Wyllie[^WYLLIE79], inventeur du modèle PRAM). Alors que si on tente de le rendre optimal en EM, la complexité temporelle passe à un $O(N \log N)$[^JACOB14].

J'espère que vous aurez vu la beauté qui peut se cacher sous un tel sujet, bien qu'il soit abordé de manière si brève. Si vous désirez aller plus loin, je vous invite à suivre les travaux de Jeffrey S. Vitter, auteur de moult travaux dans ce domaine. Les cours de Erik Demaine disponibles sur le site du MIT, notamment relatifs à la notion de *cache-oblivious*, sont également des petites merveilles (le MIT produit et diffuse des cours dans des domaines très variés et faisant preuve d'une extrême qualité). Il est également intéressant de lire les travaux originaux et ceux plus modernes. Finalement, et plus récemment avec l'avènement des GPU, le modèle PEM (*parallel external memory*) a gagné en intérêt vu une similitude relativement adéquate. Brièvement, ce modèle combine naturellement le modèle EM avec les notions de parallélisme, les résultats qui en découlent sont vraiment naturels.

# Remerciements

- Merci à @Quentin pour sa lecture et ses propositions de points à améliorer et à clarifier.
- Je tiens également à remercier @Taurre pour sa relecture attentive et ses corrections apportées sur la forme.
- Finalement, au « *Algorithms Research Group* » de l'Université Libre de Bruxelles (U.L.B.) et ses membres exceptionnels pour m'avoir appris l'esthétisme en informatique.

[^WILLIAMS18]: WILLIAMS, Virginia Vassilevska. On some fine-grained questions in algorithms and complexity. In : Proceedings of the ICM. 2018.
[^WYLLIE79]: WYLLIE, James C. The complexity of parallel computations. Cornell University, 1979.
[^JACOB14]: JACOB, Riko, LIEBER, Tobias, et SITCHINAVA, Nodari. On the complexity of list ranking in the parallel external memory model. In : International Symposium on Mathematical Foundations of Computer Science. Springer, Berlin, Heidelberg, 2014. p. 384-395.