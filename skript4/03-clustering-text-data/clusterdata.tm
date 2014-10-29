<TeXmacs|1.99.2>

<style|<tuple|generic|british>>

<\body>
  <doc-data|<doc-title|Clustering and textual data>>

  <section|General overview of clustering>

  Philipp and Miguel already introduced some techniques and algorithms, I
  would like now to give a more general overview. Why? First because I find
  it interesting, secondly because I would like to stress the point that
  there is no such thing as the Unique Correct Algorithm for clustering data
  (well, Philipp already showed some problems that arise with k-means or soft
  k-means, but as soon as you choose a different algorithm you can build
  counterexamples to it).

  <subsection|Notation.>

  We will now set some basic notation.\ 

  <\itemize-minus>
    <item>A <em|pattern> or <em|observation>
    <math|\<b-x\>=<around*|(|x<rsub|1>,\<ldots\>,x<rsub|d>|)>> is a single
    data item; it is usually a vector; its elements are called <em|features>.
    The space where they are is called <em|feature> or <em|pattern space>,
    usually <math|\<bbb-Z\><rsup|d>> or <math|\<bbb-R\><rsup|d>>.

    <item>A <em|pattern set> is a set of patterns, which can be viewed as an
    <math|n\<times\>d> pattern matrix.

    <item>A <em|class>, on the other hand, is something abstract that drives
    the pattern formation. Problem: how do we define concrete rules to mimic
    these classes?

    <item>A <em|distance> or <em|similarity measure> is a metric or
    quasi-metric<\footnote>
      A quasi-metric is a non necessarily commutative metric.
    </footnote> on the feature space that (tries to) capture and quantify the
    similarity of patterns.
  </itemize-minus>

  There are some degrees of freedom in choosing a clustering algorithms. We
  present here some possible classifications. Most of the (bi-)partitions
  showed here are orthogonal one to the other.

  <paragraph|Hard and soft (or fuzzy) clustering.>In the first approach
  patterns are univocally assigned to a cluster, while in the second one
  every pattern is labelled with some measure of its membership in every
  cluster (think probability). Usually fuzzy clustering is transformed to
  hard clustering after the last iteration of the algorithm, returning
  membership to the most likely cluster.

  <paragraph|Deterministic and stochastic.>This is relevant in the square
  error minimisation algorithms that we already saw. We can either proceed
  with standard deterministic techniques or, in particular when the dataset
  is very big, we can do a random search<\footnote>
    In some sense, there is a lot of room to make choices here.
  </footnote> on the space of all possible labelings.

  <paragraph|Agglomerative and divisive.>In the first case we start with each
  pattern belonging to its own cluster (a singleton) and then the algorithms
  joins clusters together, until a suitable stopping condition is met. In the
  second one we begin with a single cluster which is then split over and
  over, until the stopping condition is met.

  <paragraph|Monothetic and polythetic.>In this direction we can either
  consider one feature at a time or more than one or all at the same time
  while computing the similarity measures.

  <paragraph|<new-page*>The tree.>

  <big-figure|<tree|Clustering|<tree|Partitional|<tree|Square
  error|<math|k>-means>|Graph theory|Mode seeking|<tree|Mixtures|Expectation
  Maximisation>>|<tree|Hierarchical|Single link|Complete link>>|Partial
  taxonomy of clustering algorithms>

  <paragraph|Complexity of some algorithms.>Just to get an idea. We have
  <math|n> number of patterns considered, <math|k> number of clusters,
  <math|l> number of iterations for the algorithm to converge.

  <big-table|<tabular|<tformat|<table|<row|<cell|<with|font-base-size|8|<block|<tformat|<cwith|1|-1|2|2|cell-lborder|
  >|<cwith|1|-1|3|3|cell-lborder| >|<cwith|1|-1|2|2|cell-rborder|
  >|<cwith|1|-1|1|1|cell-rborder|0ln>|<cwith|1|1|1|-1|cell-bborder|1ln>|<cwith|1|1|1|-1|cell-bsep|3sep>|<cwith|1|1|1|-1|cell-tsep|3sep>|<cwith|1|-1|1|-1|cell-hyphen|t>|<cwith|6|6|3|3|cell-hyphen|n>|<table|<row|<\cell>
    Clustering algorithm
  </cell>|<\cell>
    Time Complexity
  </cell>|<\cell>
    Space complexity
  </cell>>|<row|<\cell>
    leader
  </cell>|<\cell>
    <math|O<around*|(|k*n|)>>
  </cell>|<\cell>
    <math|O<around*|(|k|)>>
  </cell>>|<row|<\cell>
    <math|k>-means
  </cell>|<\cell>
    <math|O<around*|(|k*n*l|)>>
  </cell>|<\cell>
    <math|O<around*|(|k|)>>
  </cell>>|<row|<\cell>
    Shortest spanning path
  </cell>|<\cell>
    <math|O<around*|(|n<rsup|2>|)>>
  </cell>|<\cell>
    <math|O<around*|(|n|)>>
  </cell>>|<row|<\cell>
    single-link
  </cell>|<\cell>
    <strong|><math|O<around*|(|n<rsup|2>*log n|)>> or
    <math|O<around*|(|n<rsup|2>|)>>
  </cell>|<\cell>
    <math|O<around*|(|n<rsup|2>|)>>
  </cell>>|<row|<\cell>
    complete-link
  </cell>|<\cell>
    <math|O<around*|(|n<rsup|2>*log n|)>>
  </cell>|<cell|<math|O<around*|(|n<rsup|2>|)>>>>>>>>>>>>>|Complexity>

  <subsection|Pattern representation, feature selection and extraction.>

  We start with data that usually is not a point in a numerical space. Think
  apples and bananas. So what do we do? We select and extract some features
  that we believe are most informative about our data. The we have to
  represent them in the feature space. This might sound trivial, but is
  actually extremely important: if we have a crescent shaped set of data and
  we represent it in polar coordinates we are probably going to see it as a
  cluster, while if we represent it in cartesian coordinates that might not
  happen. Moreover depending on the problem we are trying to solve, our
  features could be obvious or very obscure, which is particularly true when
  the pattern we are trying to capture is not so quantitatively well defined
  (the digits in the challenge proposed by Miguel: what are the features that
  capture the essence of ``seven-ness''?). As is is often the case for data,
  we have the following general structure:

  <\itemize-minus>
    <item>Quantitative: continuous or discrete.

    <item>Qualitative: ordinal or nominal.
  </itemize-minus>

  There are several techniques we could use to select those features that are
  really relevant, as mentioned already the most common ones (excluding trial
  and error) are principal component analysis (PCA) and expert elicitation
  (in this case meaning: you find someone who knows about this kind of
  problem or phenomenon and you ask her which are the features that
  discriminate more).

  <subsection|Similarity measures.>

  Usually standard Minkowski metrics (in most cases Euclidean distance), but
  other are possible, in particular some are quite obvious in human
  perception terms, but are more difficult to render mathematically
  (conceptual similarity measures). The choice of the distance is a model
  choice, like it was for the feature selection, the pattern representation
  and the feature extraction. This means that there is no correct recipe, but
  it falls on the shoulders of the data scientist. Also the algorithm choice
  and the cluster representation that we'll see in the following sections are
  model choices. Of course, you could program a machine to choose the proper
  clustering approach given a problem or a dataset: but that is already very
  close (IMO) to AI.

  <subsection|Cluster representation.>

  Sometimes we are just looking for a partition of the data we have, so we
  are interested in the whole composition of each cluster. Other times (for
  example when we have ten of thousands of data) we might look for a more
  compact description of the clusters. This is particularly true when we are
  doing exploratory analysis, looking for some underlying class that we have
  not an a priori abstract description for. This representation is sometimes
  called <em|abstraction>. It plays a very important role: it allows for a
  more compact and understandable description, hence improving the chances
  for an effective data compression and the efficiency of decision making.
  Let's see some possible strategies.

  <\itemize-minus>
    <item>Describe the cluster using the centroid. Most common, but it does
    not work well for non isotropic and sparse clusters.

    <item>Describe the cluster using a set of boundary points. Allows us to
    capture more complex shaped clusters, but we have to decide a number of
    points.

    <item>Describe the cluster through a classification tree or though
    logical expressions. This approach is easily understood, bu tas a severe
    limitation: it works only for rectangular or isotropic clusters. On the
    other hand it is perfectly shaped for binary search, having already a
    binary tree structure.
  </itemize-minus>

  <section|Text clustering>

  <paragraph|Motivation.>The study of clustering started with quantitative
  data, mostly because quantitative data is often available from lots of
  different sources and it makes more sense to begin with broad spectrum
  problems, leaving specialisation to a second phase. At the same time there
  are obvious advantages in applying clustering to text data: classification,
  organisation and browsing of documents or summarisation of corpus. We focus
  for the moment on unsupervised learning, but of course the classification
  part (which turns out to be extremely interesting) has some intrinsic
  difficulties, as the algorithm has to learn when documents are related.
  That provides also some interesting insight in the way we establish our own
  critical thinking: how do you determine whether two documents <em|in a
  specific set> are related or not?

  <subsection|Example: classification of Wikipedia pages.>

  Let's say we have a collection of Wikipedia pages and we want them
  clustered in some way. This will provide us with a case study in which to
  show the steps mentioned above.

  <paragraph|Feature selection.>How do we characterize documents that are
  similar? One first strategy might be to just count the number of words they
  have in common. This is not a completely wrong idea, but on second thought
  we realise that it has some serious drawbacks: there is a lot of noise,
  meaning that there are a lot of words that are very likely to be in any
  document we consider (e.g. ``the'', ``is'', and so on). So a first step to
  clean data might be the removal of the so-called <em|stopwords>.

  We keep focused on the common words strategy, but after we remove the
  stopwords we still have bad situations, for example a very long document is
  more likely to have words in common with lots of different other documents,
  and just checking the presence or not of a specific term does not provide a
  lot of information. The word might even have a different meaning! Moreover
  all the words are equal, but some are more equal than the others. The less
  frequent the words are the more important. This is a natural step following
  the idea of stopwords. So, how do we take advantage of this idea?

  The plan is to introduce the <strong|tf-idf> measure, which stays for
  <em|term frequency, inverse document frequency>. Every word gets for every
  document a number measuring its relevance in the document with respect to
  the whole set of documents (or corpus). The measure is computed in the
  following way: the <em|term frequency> is literally the frequency of the
  word in the document<\footnote>
    To be completely honest there are other possible definitions of term
    frequency.
  </footnote>,

  <\equation*>
    tf=<frac|#<around*|{|occurrences of specific word in
    document|}>|#<around*|{|words in document|}>>.
  </equation*>

  The <em|inverse document frequency> is the logarithm of the inverse
  frequency <em|sensu stricto>:

  <\equation*>
    idf=log<around*|(|<frac|#<around*|{|documents in
    corpus|}>|#<around*|{|documents with the specific word|}>>|)>.
  </equation*>

  The two are then multiplied.

  <paragraph|Similarity measure.>Now we have a vector space where the
  documents are represented as vectors, in which each feature is a word,
  represented through its tf-idf measure. How do we compute the distance or
  (dis)similarity between documents? We compute the angle between them,
  through the cosine. We have, given two documents <math|d<rsub|1>> and
  <math|d<rsub|2>> represented in the vector space just defined, that their
  cosine is:

  <\equation*>
    cos<around*|(|d<rsub|1>,d<rsub|2>|)>=<frac|d<rsub|1>\<bullet\>d<rsub|2>|<around*|\||d<rsub|1>|\|>*<around*|\||d<rsub|2>|\|>>,
  </equation*>

  so their angle is just the arccosine of this quantity. The further that two
  documents can be is <math|<frac*|\<pi\>|2>>, because coordinates are all
  positive.

  <section|Some clustering algorithms>

  <subsection|Hierarchical agglomerative clustering.>

  <\enumerate-roman>
    <item>Compute proximity matrix with the distances between all pairs of
    patterns (recall that we start with every pattern being a cluster).

    <item>Search the proximity matrix for the closest clusters, merge them
    and update the proximity matrix.

    <item>If we are down to one cluster, STOP, otherwise GOTO ii.
  </enumerate-roman>

  The complexity of HAC is <math|O<around*|(|n<rsup|2>*log n|)>>: the
  computation of similarities is <math|O<around*|(|n<rsup|2>|)>>, and with
  suitable techniques (priority queues, for those interested) the search and
  merge can be done in <math|O<around*|(|n<rsup|2>*log n|)>>, hence the
  complexity.

  <subsubsection|Simple-link.>

  In this specific case of HAC we measure the similarity of two cluster in
  the best case, that is considering the two most similar elements. In other
  words we just look at the place where two clusters are closer one to the
  other:

  <\equation*>
    d<rsub|sl><around*|(|C<rsub|1>,C<rsub|2>|)>=min<rsub|d<rsub|i>\<in\>C<rsub|i>>
    d<around*|(|d<rsub|1>,d<rsub|2>|)>.
  </equation*>

  \ Because of its definition this algorithm is great in finding chain
  structures (which might be good or bad). In this case, as hinted by the
  table, we can slightly improve the complexity of the algorithm, if we keep
  track of which is the best merge for each cluster, lowering complexity to
  <math|O<around*|(|n<rsup|2>|)>>. This work only for simple link, as we use
  the minimum distance, so the best merge is preserved after every iteration
  (up to the computation of a <math|max>, which is only
  <math|O<around*|(|n|)>> complex).

  <subsubsection|Complete-link.>

  Another take on HAC is to consider the most dissimilar points in the
  clusters, that is the worst case:

  <\equation*>
    d<rsub|cl><around*|(|C<rsub|1>,C<rsub|2>|)>=max<rsub|d<rsub|i>\<in\>C<rsub|i>>
    d<around*|(|d<rsub|1>,d<rsub|2>|)>.
  </equation*>

  \ Now we choose as the next cluster the one with the smallest diameter,
  taking into account a more global picture of the cluster. This algorithm
  does not focus on chains, but focuses on compact clusters. One big problem
  is that it is extremely sensitive to outliers. Fun fact: there is an
  efficient version of this algorithm, called CLINK, which has a complexity
  of <math|O<around*|(|n<rsup|2>|)>>, but has the huge drawback of giving
  unsatisfactory results in information retrieval due to a not exact
  hierarchy. The <math|O<around*|(|n<rsup|2>|)>> is the optimal complexity
  bound.

  <subsubsection|Average-link.>

  Here we have a shift, compared to the previous two examples: instead of
  comparing two clusters considering only a pair of patterns, we consider the
  whole set of patterns involved, that is we consider <em|all> pair of
  patterns, including patterns already in the same cluster (but not
  self-similarities). Let's write down the distance:

  <\equation*>
    d<rsub|av><around*|(|C<rsub|1>,C<rsub|2>|)>=<frac|1|<around*|(|n<rsub|1>+n<rsub|2>|)><around*|(|n<rsub|1>+n<rsub|2>-1|)>>*<big|sum><rsub|p<rsub|n>\<neq\>p<rsub|m\<in\>C<rsub|1>\<cup\>C<rsub|2>>>p<rsub|n>\<cdot\>p<rsub|m>
  </equation*>

  and this can be computed efficiently (as long as we represent our patterns
  in <math|\<bbb-R\><rsup|d>>), since we can rewrite the double sum thanks to
  the distributivity of sum with respect to product, hence:

  <\equation*>
    d<rsub|av><around*|(|C<rsub|1>,C<rsub|2>|)>=<frac|1|<around*|(|n<rsub|1>+n<rsub|2>|)><around*|(|n<rsub|1>+n<rsub|2>-1|)>>*<around*|(|<around*|(|<big|sum><rsub|p<rsub|n\<in\>C<rsub|1>\<cup\>C<rsub|2>>>p<rsub|n>|)><rsup|2>-<around*|(|n<rsub|1>+n<rsub|2>|)>|)>.
  </equation*>

  Here we must stress that there are a couple of differences with the general
  algorithm:

  <\enumerate-numeric>
    <item>we must have patterns represented as <math|\<bbb-R\><rsup|d>>
    vectors;

    <item>the vectors have to be normalised so that self-similarities are 1;

    <item>we have to use the dot product and not other distances.
  </enumerate-numeric>

  One last remark: the reason we remove self-similarities is that keeping
  them means penalise the larger clusters in comparison to the smaller ones
  (due to the lower proportion of self similar distances).

  <subsubsection|Centroid-link.>

  Here the similarity is defined also in term of two points, the centroids,
  but these are computed from all points of each cluster, so it does not show
  the problems that single- and complete-link had. Alas, it has a much bigger
  problem: it is not monotone! In all previous hierarchical agglomerative
  algorithms the similarity between clusters <em|decreases> in time (that is
  the more merges, the less similarity between things merged); in the
  centroid-link we lose that property. The reason this algorithm has been
  considered is that it has an <math|O<around*|(|n<rsup|2>|)>> complexity in
  time.

  <subsubsection|Cutting the dendrogram.>

  With hierarchical algorithms what we get is not a partition, but a
  dendrogram. We can obtain a partition from the dendrogram, but in order to
  do so we need to cut the dendrogram. How do we do that? There are several
  possible choices (also model choices).

  <\itemize-minus>
    <item>Lazy: cut at some pre-specified level <math|l> of similarity. That
    is to say, we don't want clusters with a combined similarity less than
    <math|l>.

    <item>Lazy 2: as in the <math|k>-means clustering presented by
    Philipp<\footnote>
      I am not implying that Philipp is lazy, as the opposite is definitely
      true as anyone can witness.
    </footnote> we fix the number of clusters we want to end up with.

    <item>Largest gap: we cut the dendrogram right before the largest gap,
    which is the one that ``lowers'' the most the quality of the clustering.
    Actually this ``rule of thumb'' is the most used whenever there are
    dendrograms involved in statistics and follows the same idea as the scree
    plot rule that we have for factor analysis.

    <item>RSS: we (ab)use the following formula

    <\equation*>
      k=argmin<rsub|h><around*|(|RSS<around*|(|h|)>-\<lambda\>*h|)>,
    </equation*>

    where <math|h> is the cut resulting in <math|h> clusters,
    <math|\<lambda\>> is the penalty for each additional cluster and
    <math|RSS> is the residual sum of squares (or any other distortion
    measure).
  </itemize-minus>

  <subsection|Partitional clustering (distance based).>

  We briefly sketch the ideas behind some partitional algorithms for data
  clustering, focusing on their application to text data.

  <subsubsection|<math|k>-anchored.>

  We start by choosing some representative documents (pattern) from our set
  of data, called anchors: around those points we build a first batch of
  clusters, assigning each document to the cluster determined by the closest
  anchor. The underlying idea is to find an optimal set of documents to play
  as anchors. We compute the average similarity of each document to its
  closest anchor and this is the utility function that we want to maximise.
  In each iteration we replace an anchor picked at random with another
  randomly picked document from the whole set of data if it increases the
  utility function. As is the case with other iterative algorithms we proceed
  until convergence is obtained.

  There are disadvantages to this approach.

  <\itemize-minus>
    <item>We have to recompute the utility function at each iteration and we
    need a large number of iteration to achieve convergence, so the algorithm
    might be quite slow. The complexity is <math|O<around*|(|k*n*l|)>>.

    <item>Moreover <math|k>-anchors do not work well with sparse data, and
    text data is very sparse. Indeed, many documents (once we remove common
    words) have little to none words in common. This might become a huge
    problem.
  </itemize-minus>

  <subsubsection|<math|k>-means>

  We know this algorithm well, so we'll just see some comments about its use
  in text data clustering. One advantage of this algorithm is how quickly it
  converges, compared to <math|k>-anchors: for large text data sets al little
  as 5 iterations are enough to converge. We have disadvantages, of course,
  the first being that the algorithm is very sensitive to the initial set of
  clustering seeds. Another drawback is that the centroid of a text data
  cluster will contain a large number of words, so the computation of
  similarity measures is slower.\ 

  <paragraph|Bonus question:>What is the centroid of a set of documents?

  <subsection|Scatter-gather algorithm, an hybrid.>

  With this algorithm we try to take advantage of the strong suits of both
  hierarchical and partitional approaches. We start by using a hierarchical
  clustering on a sample of the whole set of documents to find a good set of
  seeds, which we'll provide to a <math|k>-means algorithm afterwards, to
  cluster the whole set of documents.\ 

  <subsubsection|Creating the set of seeds.>

  There are two main algorithms used to create the starting set of seeds.

  <\itemize-minus>
    <item>Buckshot. Instead of just picking <math|k> random seeds, we choose
    <math|<sqrt|n*k>> points and then we use a hierarchical algorithm to
    cluster them in <math|k> clusters. Complexity is
    <math|O<around*|(|n\<cdot\>k|)>>, as we don't need to get a <em|perfect>
    hierarchical structure, but only a good one (so we can use one of those
    <math|O<around*|(|n<rsup|2>|)>> version of the algorithms).

    <item>Fractionation. We split the whole set into <math|<frac*|n|m>>
    ``buckets'' of size <math|m\<gtr\>k>. We use a hierarchical algorithm to
    each bucket to shrink it by a factor <math|\<lambda\>\<less\>1>. We now
    have <math|\<lambda\>\<cdot\>m> clusters in each bucket, which we can
    agglomerate in a single document just by merging all members. Overall we
    have now <math|\<lambda\>*n=<frac*|n|m>\<cdot\><around*|(|\<lambda\>*m|)>>
    documents. Now we can repeat the process on the resulting documents,
    until we are left with <math|k> seeds. What about the complexity? The
    hierarchical algorithm costs (at the first iteration)
    <math|O<around*|(|m<rsup|2>|)>> for each bucket, so
    <math|O<around*|(|n\<cdot\>m|)>> overall. On the following iterations it
    costs <math|O<around*|(|\<lambda\><rsup|j>\<cdot\>n\<cdot\>m|)>> overall,
    so for <math|\<lambda\>\<less\>1> we still get a
    <math|O<around*|(|n\<cdot\>m|)>> total complexity. So we can pick
    <math|m=O<around*|(|k|)>> and get a total complexity of
    <math|O<around*|(|n\<cdot\>k|)>>.
  </itemize-minus>

  <subsubsection|Clustering through <math|k>-means.>

  Up to this moment the complexity is equivalent in both cases to one
  iteration of the <math|k>-means algorithm. Now we run the algorithm itself
  with the starting seeds so defined, getting an overall complexity in time
  of <math|O<around*|(|n\<cdot\>k\<cdot\>l|)>>, but avoiding the issues of
  <math|k>-means.

  <subsubsection|Possible improvements.>

  There are techniques that refine even more the clustering obtained, at no
  additional complexity cost. We just cite them here: split and join.

  <subsection|Word based clustering.>

  There are other approaches designed specifically for texts, which are not
  just (high dimensional) vectors of words, but have a lot of underlying
  structure. Words go often together, so we can look for <em|word patterns>
  instead of just words or even have a two steps clustering, clustering first
  words within a document and then documents, seen as vectors of word
  clusters. Another approach along this direction is the simultaneous
  clustering of words and documents (co-clustering) using
  information-theoretical approaches or graph theoretical ones. Finally let's
  mention frequent phrases clustering, where we consider not one word at a
  time or an unordered set of words, but we focus on actual, concrete
  phrases.

  <subsection|Topic models.>

  This is just a sneak peek on the shape of things to come: we can see the
  set of documents as a function of hidden random variables, and we estimate
  the parameters of such RVs using a selected collection of documents. In
  particular we'll assume that each document has a vector of probabilities of
  belonging to one of the <math|k> clusters (topics, in this framework) and
  also every topic has an associated probability vector, made of the
  probabilities of each term in the lexicon for the topic.
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
    <associate|page-type|a4>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|1|2>>
    <associate|auto-11|<tuple|1.2|2>>
    <associate|auto-12|<tuple|1.3|2>>
    <associate|auto-13|<tuple|1.4|3>>
    <associate|auto-14|<tuple|2|3>>
    <associate|auto-15|<tuple|7|3>>
    <associate|auto-16|<tuple|2.1|3>>
    <associate|auto-17|<tuple|8|3>>
    <associate|auto-18|<tuple|9|4>>
    <associate|auto-19|<tuple|3|4>>
    <associate|auto-2|<tuple|1.1|1>>
    <associate|auto-20|<tuple|3.1|4>>
    <associate|auto-21|<tuple|3.1.1|4>>
    <associate|auto-22|<tuple|3.1.2|4>>
    <associate|auto-23|<tuple|3.1.3|5>>
    <associate|auto-24|<tuple|3.1.4|5>>
    <associate|auto-25|<tuple|3.1.5|5>>
    <associate|auto-26|<tuple|3.2|6>>
    <associate|auto-27|<tuple|3.2.1|6>>
    <associate|auto-28|<tuple|3.2.2|6>>
    <associate|auto-29|<tuple|3.2.2.1|6>>
    <associate|auto-3|<tuple|1|1>>
    <associate|auto-30|<tuple|3.3|6>>
    <associate|auto-31|<tuple|3.3.1|7>>
    <associate|auto-32|<tuple|3.3.2|7>>
    <associate|auto-33|<tuple|3.3.3|7>>
    <associate|auto-34|<tuple|3.4|7>>
    <associate|auto-35|<tuple|3.5|7>>
    <associate|auto-36|<tuple|3.5|8>>
    <associate|auto-4|<tuple|2|1>>
    <associate|auto-5|<tuple|3|1>>
    <associate|auto-6|<tuple|4|1>>
    <associate|auto-7|<tuple|5|2>>
    <associate|auto-8|<tuple|1|2>>
    <associate|auto-9|<tuple|6|2>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-2|<tuple|2|1>>
    <associate|footnote-3|<tuple|3|4>>
    <associate|footnote-4|<tuple|4|5>>
    <associate|footnote-5|<tuple|5|7>>
    <associate|footnr-1|<tuple|1|1>>
    <associate|footnr-2|<tuple|2|1>>
    <associate|footnr-3|<tuple|3|3>>
    <associate|footnr-4|<tuple|4|5>>
    <associate|footnr-5|<tuple|5|7>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|Partial taxonomy of clustering
      algorithms|<pageref|auto-8>>
    </associate>
    <\associate|table>
      <tuple|normal|Complexity|<pageref|auto-10>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>General
      overview of clustering> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>Notation.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <with|par-left|<quote|4tab>|Hard and soft (or fuzzy) clustering.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Deterministic and stochastic.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Agglomerative and divisive.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Monothetic and polythetic.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|<new-page*>The tree.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Complexity of some algorithms.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.15fn>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>Pattern representation,
      feature selection and extraction. <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|1.3<space|2spc>Similarity measures.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|<quote|1tab>|1.4<space|2spc>Cluster representation.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Text
      clustering> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14><vspace|0.5fn>

      <with|par-left|<quote|4tab>|Motivation.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15><vspace|0.15fn>>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Example: classification of
      Wikipedia pages. <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-16>>

      <with|par-left|<quote|4tab>|Feature selection.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-17><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Similarity measure.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-18><vspace|0.15fn>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Some
      clustering algorithms> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-19><vspace|0.5fn>

      <with|par-left|<quote|1tab>|3.1<space|2spc>Hierarchical agglomerative
      clustering. <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-20>>

      <with|par-left|<quote|2tab>|3.1.1<space|2spc>Simple-link.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-21>>

      <with|par-left|<quote|2tab>|3.1.2<space|2spc>Complete-link.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-22>>

      <with|par-left|<quote|2tab>|3.1.3<space|2spc>Average-link.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-23>>

      <with|par-left|<quote|2tab>|3.1.4<space|2spc>Centroid-link.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-24>>

      <with|par-left|<quote|2tab>|3.1.5<space|2spc>Cutting the dendrogram.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-25>>

      <with|par-left|<quote|1tab>|3.2<space|2spc>Partitional clustering
      (distance based). <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-26>>

      <with|par-left|<quote|2tab>|3.2.1<space|2spc><with|mode|<quote|math>|k>-anchored.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-27>>

      <with|par-left|<quote|2tab>|3.2.2<space|2spc><with|mode|<quote|math>|k>-means
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-28>>

      <with|par-left|<quote|4tab>|Bonus question:
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-29><vspace|0.15fn>>

      <with|par-left|<quote|1tab>|3.3<space|2spc>Scatter-gather algorithm, an
      hybrid. <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-30>>

      <with|par-left|<quote|2tab>|3.3.1<space|2spc>Creating the set of seeds.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-31>>

      <with|par-left|<quote|2tab>|3.3.2<space|2spc>Clustering through
      <with|mode|<quote|math>|k>-means. <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-32>>

      <with|par-left|<quote|2tab>|3.3.3<space|2spc>Possible improvements.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-33>>

      <with|par-left|<quote|1tab>|3.4<space|2spc>Word based clustering.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-34>>

      <with|par-left|<quote|1tab>|3.5<space|2spc>Topic models.
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-35>>
    </associate>
  </collection>
</auxiliary>