<TeXmacs|1.99.2>

<style|<tuple|article|american>>

<\body>
  <\hide-preamble>
    \;

    <assign|theorem-text|<macro|<localize|Satz>222>>
  </hide-preamble>

  <\doc-data|<doc-title|K-means clustering>|<doc-author|<\author-data|<author-name|Philipp
  Düren>>
    \;
  <|author-data>
    \;
  </author-data>>>
    \;

    \;
  </doc-data>

  <section|Derivation of the algorithm's essential idea>

  A random variable <math|\<b-X\>> with values in <math|\<bbb-R\>> exhibiting
  two clusters is modelled by assuming that it has a probability distribution
  that is a mixture of two Gaussians. For initial purposes we assume the
  samples from the individual Gaussians to be labelled accordingly, i.e. each
  sample is in state <math|\<lambda\>=1> or <math|\<lambda\>=2>, where
  <math|\<lambda\>> is called the <em|label of the sample>. Then the
  generation process of <math|\<b-X\>> is as follows:

  <\enumerate>
    <item>Choose either the first or the second Gaussian by using the (given)
    distribution of the label, <math|\<bbb-P\><around*|(|\<lambda\>=i|)>>,
    <math|i=1,2>. For brevity, we write <math|\<bbb-P\><around*|(|\<lambda\>=i|)>
    =p<rsub|i>>, where <math|p<rsub|1>+p<rsub|2>=1>.

    <item>Generate a sample according to this Gaussian using the common
    probability distribution function.
  </enumerate>

  Hence the density of the random variable <math|\<b-X\>> is:

  <\eqnarray*>
    <tformat|<table|<row|<cell|f<rsub|\<b-X\>\|\<b-theta\>><around*|(|x|)>
    >|<cell|=>|<cell|<big|sum><rsup|2><rsub|k=1>p<rsub|k>\<cdot\><frac|1|<sqrt|2\<pi\>\<sigma\><rsup|2>>>\<cdot\>exp<around*|(|-<frac|<around*|(|x-\<mu\><rsub|k>|)><rsup|2>|2\<sigma\><rsup|2>>|)>>>|<row|<cell|>|<cell|=
    >|<cell|<big|sum><rsup|2><rsub|k=1>\<bbb-P\><around*|(|\<lambda\>=k|)>\<cdot\>f<rsub|\<b-X\>\|\<b-theta\>\<nocomma\>,\<lambda\>=k><around*|(|x|)>>>>>
  </eqnarray*>

  where <math|\<b-theta\>=<around*|(|\<mu\><rsub|1>\<nocomma\>,
  \<mu\><rsub|2>, \<sigma\>|)>> is the parameter vector and we denote
  <math|\<b-mu\>=<around*|(|\<mu\><rsub|1>\<nocomma\>\<comma\>
  \<nocomma\>\<mu\><rsub|2>|)>>.

  We would like to get a grip on the probability distribution of the
  parameters <math|\<mu\><rsub|1>> and <math|\<mu\><rsub|2>> (we regard
  <math|\<sigma\>> as fixed). For that matter, we assume a <em|prior
  distribution> <math|f<rsub|\<b-mu\>>> and accept the following black box
  Bayesian formulas for densities:

  <\framed>
    <\itemize>
      <item>If <math|Y> and <math|Z> are continuously distributed according
      to their densities <math|f<rsub|Y>> and <math|f<rsub|Z>>, then

      <\equation*>
        f<rsub|Y\|Z>=<frac|f<rsub|Z\|Y>\<cdot\>f<rsub|Y>|f<rsub|Z>>
      </equation*>

      <item>If <math|W> is discretely distributed with discrete probabilities
      <math|\<bbb-P\><around*|(|W=w<rsub|i>|)>=\<pi\><rsub|i>> and Y is
      continuously distributed according to its density <math|f<rsub|Y>> and
      also the conditional density <math|f<rsub|Y\|W>> is known, then

      <\equation*>
        \<bbb-P\><around*|(|W=w<rsub|i>\|Y=y|)>=<frac|f<rsub|Y\|W=w<rsub|i>><around*|(|y<rsub|>|)>\<cdot\>\<pi\><rsub|i>|f<rsub|Y><around*|(|y|)>>
      </equation*>
    </itemize>
  </framed>

  Then we can write

  <\eqnarray*>
    <tformat|<table|<row|<cell|\<bbb-P\><around*|(|\<lambda\>=1\|\<b-theta\>\<nocomma\>\<nocomma\>\<nocomma\>,\<b-X\>=x|)>>|<cell|=>|<cell|<frac|f<rsub|\<b-X\>\|\<b-theta\>,\<lambda\>=1><around*|(|x|)>\<cdot\>p<rsub|1>|f<rsub|\<b-X\>\|\<b-theta\>><around*|(|x|)>>>>|<row|<cell|>|<cell|=>|<cell|<frac|\<bbb-P\><around*|(|\<lambda\>=1|)>\<cdot\>f<rsub|\<b-X\>\|\<b-theta\>,\<lambda\>=1><around*|(|x|)>|<big|sum><rsup|2><rsub|k=1>\<bbb-P\><around*|(|\<lambda\>=k|)>\<cdot\>
    f<rsub|\<b-X\>\|\<b-theta\>\<nocomma\>,\<lambda\>=k>>>>|<row|<cell|>|<cell|=>|<cell|
    <frac|1|1+exp<around*|(|<frac|x<around*|(|\<mu\><rsub|2>-\<mu\><rsub|1>|)>|\<sigma\><rsup|2>>+<frac|\<mu\><rsub|1><rsup|2>-\<mu\><rsub|2><rsup|2>|2\<sigma\><rsup|2><rsup|>>+<with|math-condensed|true|<with|math-condensed|false|>>log<around*|(|<frac|p<rsub|2>|p<rsub|1>>|)>|)>>>>|<row|<cell|\<bbb-P\><around*|(|\<lambda\>=2\|\<b-theta\>\<nocomma\>\<nocomma\>\<nocomma\>,\<b-X\>=x|)>>|<cell|=>|<cell|
    <frac|1|1+exp<around*|(|-<frac|x<around*|(|\<mu\><rsub|2>-\<mu\><rsub|1>|)>|\<sigma\><rsup|2>>-<frac|\<mu\><rsub|1><rsup|2>-\<mu\><rsub|2><rsup|2>|2\<sigma\><rsup|2><rsup|>>-log<around*|(|<frac|p<rsub|2>|p<rsub|1>>|)>|)>>>>>>
  </eqnarray*>

  For brevity we denote

  <\eqnarray*>
    <tformat|<table|<row|<cell|p<rsub|k\|x>>|<cell|\<equiv\>>|<cell|\<bbb-P\><around*|(|\<lambda\>=k\|\<b-theta\>\<nocomma\>\<nocomma\>\<nocomma\>,\<b-X\>=x|)>>>>>
  </eqnarray*>

  Now we assume that the parameters <math|\<mu\><rsub|k>> are unknown and we
  wish to infer them from the sample <math|<around*|{|x<rsub|n>|}><rsub|n=1><rsup|N>>.
  We can derive

  <\eqnarray*>
    <tformat|<table|<row|<cell|f<rsub|\<b-mu\>\|\<b-X\><rsup|n>=<around*|{|x<rsub|n>|}><rsub|n=1><rsup|N>><around*|(|\<mu\><rsub|1>,\<mu\><rsub|2>|)>>|<cell|=>|<cell|<frac|f<rsub|\<b-X\><rsup|n>\|\<b-mu\>=<around*|(|\<mu\><rsub|1>,\<mu\><rsub|2>|)>><around*|(|<around*|{|x<rsub|n>|}><rsub|n=1><rsup|N>|)>\<cdot\>f<rsub|\<b-mu\>><around*|(|\<mu\><rsub|1>,\<mu\><rsub|2>|)>|f<rsub|\<b-X\><rsup|n>><around*|(|<around*|{|x<rsub|n>|}><rsub|n=1><rsup|N>|)>>>>>>
  </eqnarray*>

  and

  <\equation*>
    f<rsub|\<b-X\><rsup|n>\|\<b-mu\>=<around*|(|\<mu\><rsub|1>,\<mu\><rsub|2>|)>><around*|(|<around*|{|x<rsub|n>|}><rsub|n=1><rsup|N>|)>
    = <big|prod><rsub|n=1><rsup|N>f<rsub|\<b-X\>\|\<b-mu\>><around*|(|x<rsub|n>|)>.
  </equation*>

  We can reason that the most probable guess for <math|\<b-mu\>> is the
  maximum of the product in the numerator of the fraction above. If we assume
  a non-committal prior distribution <math|f<rsub|\<b-mu\>><around*|(|\<mu\><rsub|1>,\<mu\><rsub|2>|)>>,
  we need to maximize the conditional density of <math|\<b-X\><rsup|n>> given
  <math|\<b-mu\>>, i.e. the <em|likelihood of <math|\<b-mu\>>>. It will be
  easier to maximize the natural logarithm of this quantity and we denote for
  brevity

  <\eqnarray*>
    <tformat|<table|<row|<cell|L<around*|(|\<b-mu\>|)>>|<cell|\<equiv\>>|<cell|log<around*|(|f<rsub|\<b-X\><rsup|n>\|\<b-mu\>=<around*|(|\<mu\><rsub|1>,\<mu\><rsub|2>|)>><around*|(|<around*|{|x<rsub|n>|}><rsub|n=1><rsup|N>|)>|)>.>>>>
  </eqnarray*>

  To find the maximum of <math|L>, we use the Newton method on the gradient
  of <math|L>. For that we have to find the gradient and the Hessian of
  <math|L> first.

  <\with|eqn-row-sep|2.5fn>
    <\eqnarray*>
      <tformat|<table|<row|<cell|<frac|\<partial\>|\<partial\>\<mu\><rsub|k>>L<around*|(|\<b-mu\>|)>>|<cell|=>|<cell|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>
      \<cdot\> <frac|x<rsub|n>-\<mu\><rsub|k>|\<sigma\><rsup|2>>>>|<row|<cell|<frac|\<partial\><rsup|2>|\<partial\>\<mu\><rsub|k><rsup|2>>L<around*|(|\<b-mu\>|)>>|<cell|=>|<cell|-<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>\<cdot\><frac|1|\<sigma\><rsup|2>>
      +<big|sum><rsub|n=1><rsup|N><frac|\<partial\>|\<partial\>\<mu\><rsub|k>>p<rsub|k\|x<rsub|n>>
      \<cdot\> <frac|x<rsub|n>-\<mu\><rsub|k>|\<sigma\><rsup|2>>>>|<row|<cell|>|<cell|\<approx\>>|<cell|-<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>\<cdot\><frac|1|\<sigma\><rsup|2>>>>>>
    </eqnarray*>
  </with>

  where we will use the approximation in the last line and the Hessian is
  thus (approximately) the <math|2\<times\>2> diagonal matrix

  <\equation*>
    H\<equiv\>-<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>\<cdot\><frac|1|\<sigma\><rsup|2>>
    \<cdot\> Id<rsub|2>
  </equation*>

  The Newton method thus is

  <\eqnarray*>
    <tformat|<table|<row|<cell|\<b-mu\><rprime|'>
    >|<cell|=>|<cell|\<b-mu\>-H<rsup|-1>\<cdot\><around*|(|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>
    \<cdot\> <frac|x<rsub|n>-\<mu\><rsub|k>|\<sigma\><rsup|2>>|)><rsub|k=1>>>|<row|<cell|>|<cell|=>|<cell|\<b-mu\>+<frac|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>
    \<cdot\> x<rsub|n>|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>> -
    <frac|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>> \<cdot\>
    \<b-mu\>|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>>
    >>|<row|<cell|>|=|<cell| <frac|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>
    \<cdot\> x<rsub|n>|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|x<rsub|n>>>>>>>
  </eqnarray*>

  \;

  Intuitively, this means putting the new cluster centers to the
  probabilistically weighted center of mass of all data points. The weighing
  is according to ``responsibility'' of a cluster for a data point, i.e. data
  points that are regarded as unrelated to a cluster will not have much
  influence for its new center.

  The algorithm consists of two parts: First, we need to calculate the
  likelihood that the data set is a result of the current guess of the
  parameters. This means getting the values of all <math|p<rsub|k\|n>>. We
  can interpret the <math|p<rsub|k\|n>> as <em|responsibilities>: Of course,
  <math|p<rsub|1\|n>> and <math|p<rsub|2\|n>y> add to 1, so if one of them is
  near <math|1>, we say that this cluster takes <em|high responsibility> for
  <math|x<rsub|n>>. This step is also called <em|<strong|assignment>> as we
  fuzzily assign clusters (we will in general not have <math|p<rsub|1\|n>=1>
  and <math|p<rsub|2\|n>=0> for most samples, so the responsibility is
  ``fuzzy'').

  Then we need to update our current guess for <math|\<b-mu\>> by the formula
  above. This step is called <strong|<em|update>>.\ 

  In praxis, we iterate those two steps until our system does not change
  anymore.

  <section|Improvements and Generalizations>

  Now, we model our data set <math|<around*|{|\<b-x\><rsub|n>|}><rsub|n=1><rsup|N>>,
  where <math|\<b-x\><rsub|n>\<in\>\<bbb-R\><rsup|d>> as a result of a
  superposition of <math|K> multivariate Gaussians
  <math|Y<rsub|i>\<sim\>\<Nu\><around*|(|\<b-mu\><rsup|<around*|(|i|)>>\<nocomma\>,\<Sigma\><rsup|<around*|(|i|)>>|)>>
  with mean <math|\<b-mu\><rsup|<around*|(|i|)>>\<less\>\<bbb-R\><rsup|d>>
  and covariance matrix <math|\<Sigma\><rsup|<around*|(|i|)>>\<less\>\<bbb-R\><rsup|d\<times\>d>>.

  <\eqnarray*>
    <tformat|<table|<row|<cell|f<rsub|\<b-X\>\|\<b-theta\>><around*|(|\<b-x\>|)>
    >|<cell|=>|<cell|<big|sum><rsup|K><rsub|k=1>p<rsub|k>\<cdot\><frac|1|<sqrt|2\<pi\>\<cdot\>det<around*|(|\<Sigma\><rsup|<around*|(|k|)>>|)>>>\<cdot\>exp<around*|(|-<frac|1|2>\<cdot\><around*|(|\<b-x\>-\<b-mu\><rsup|<around*|(|k|)>>|)><rsup|\<top\>>\<cdot\><around*|[|\<Sigma\><rsup|<around*|(|k|)>>|]><rsup|-1>\<cdot\><around*|(|\<b-x\>-\<b-mu\><rsup|<around*|(|k|)>>|)>|)>>>|<row|<cell|>|<cell|=
    >|<cell|<big|sum><rsup|K><rsub|k=1>\<bbb-P\><around*|(|\<lambda\>=k|)>\<cdot\>
    f<rsub|\<b-X\>\|\<b-theta\>\<nocomma\>,\<lambda\>=k><around*|(|\<b-x\>|)>\<noplus\>>>>>
  </eqnarray*>

  \;

  Hence the assignment step consists of calculating

  <\eqnarray*>
    <tformat|<table|<row|<cell|p<rsub|k\|\<b-x\><rsub|n>>>|<cell|=>|<cell|\<bbb-P\><around*|(|\<lambda\>=k\|\<b-theta\>\<nocomma\>,\<b-X\>=\<b-x\><rsub|n>|)>>>|<row|<cell|>|<cell|=>|<cell|<frac|p<rsub|k>\<cdot\><frac|1|<sqrt|2\<pi\>\<cdot\>det<around*|(|\<Sigma\><rsup|<around*|(|k|)>>|)>>>\<cdot\>exp<around*|(|-<frac|1|2>\<cdot\><around*|(|\<b-x\>-\<b-mu\><rsup|<around*|(|k|)>>|)><rsup|\<top\>>\<cdot\><around*|[|\<Sigma\><rsup|<around*|(|k|)>>|]><rsup|-1>\<cdot\><around*|(|\<b-x\>-\<b-mu\><rsup|<around*|(|k|)>>|)>|)>|f<rsub|\<b-X\>\|\<b-theta\>><around*|(|\<b-x\>|)>>>>>>
  </eqnarray*>

  After assigning points, the cluster sizes will change: Perhaps cluster 1
  lost a lot of samples to cluster 2. This should find its expression in the
  weighing of the distributions, i.e. the coefficients <math|p<rsub|k>>. For
  that we first introduce the notation

  \;

  <\equation*>
    R<rsup|<around*|(|k|)>>= <big|sum><rsub|n=1><rsup|N>p<rsub|k\|\<b-x\><rsub|n>>,
  </equation*>

  i.e. the <em|total responsibility> of cluster <math|k>. Norming those
  numbers, we get a measure of the proportion of data the cluster <math|k>
  claims for itself:

  <\equation*>
    p<rsub|k>=<frac|R<rsup|<around*|(|k|)>>|<big|sum><rsub|k=1><rsup|K>R<rsup|<around*|(|k|)>>>
  </equation*>

  Then, using the same arguments as in the simple example, the update step
  for the cluster centers is

  <\equation*>
    \<b-mu\><rsup|<around*|(|k|)>><rprime|'> =
    \ <frac|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|\<b-x\><rsub|n>> \<cdot\>
    \<b-x\><rsub|n>|R<rsup|<around*|(|k|)>>>
  </equation*>

  It is reasonable to adapt the covariance as well. This can be done using a
  standard covariance estimator for all data points, again weighed by their
  responsibilities:

  <\equation*>
    \<Sigma\><rsup|<around*|(|k|)>><rprime|'> =
    \ <frac|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|\<b-x\><rsub|n>> \<cdot\>
    <around*|[|\<b-x\><rsub|n>-\<b-mu\><rsup|<around*|(|k|)>>|]>\<cdot\><around*|[|\<b-x\><rsub|n>-\<b-mu\><rsup|<around*|(|k|)>>|]><rsup|\<top\>>|<big|sum><rsub|n=1><rsup|N>p<rsub|k\|\<b-x\><rsub|n>>>
  </equation*>

  <section|Conclusion, Caveats and Citations>

  K-means clustering works well for a reasonable set of problems where data
  really comes from Gaussian distributions. Of course, a crescent shaped
  sample will not be modelled appropiately, neither a set of ``strings'' of
  data, which a human can easily make out as being clustered intuitively.

  Also, K-means can blow up: Once a <math|\<b-mu\><rsup|<around*|(|k|)>>> is
  exactly over one data point <math|\<b-x\><rsub|n>>, the likelihood of that
  match becomes perfect, yielding a covariance matrix <math|0>. This is a
  typical flaw of maximum likelihood methods: Overfitting of data is not
  excluded and can lead to pathological results.

  This short overview was shamelessly C&P-ed from <cite|MacKay>.

  <big-figure|<image|strings.eps|0.7par|||>|An example where K-means
  clustering will not work>

  <\session|octave|default>
    \;
  </session>

  <\bibliography|bib|tm-alpha|Bib.bib>
    <\bib-list|1>
      <bibitem*|Mac03><label|bib-MacKay>David J. C.<nbsp>MacKay.<newblock>
      <with|font-shape|italic|Information Theory, Inference, and Learning
      Algorithms>.<newblock> Cambridge University Press, 2003.<newblock>
    </bib-list>
  </bibliography>
</body>

<\initial>
  <\collection>
    <associate|info-flag|detailed>
    <associate|par-first|0em>
    <associate|sfactor|4>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|2|2>>
    <associate|auto-3|<tuple|3|?>>
    <associate|auto-4|<tuple|1|?>>
    <associate|auto-5|<tuple|1|?>>
    <associate|bib-MacKay|<tuple|Mac03|?>>
    <associate|fig1|<tuple|1|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|bib>
      MacKay
    </associate>
    <\associate|figure>
      <tuple|normal||<pageref|auto-4>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Derivation
      of the algorithm's essential idea> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Improvements
      and Generalizations> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Conclusion,
      Caveats and Citations> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Bibliography>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>