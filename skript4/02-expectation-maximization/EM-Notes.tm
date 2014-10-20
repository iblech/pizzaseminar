<TeXmacs|1.99.2>

<style|<tuple|amsart|structured-section>>

<\body>
  <\hide-preamble>
    \;

    <assign|remark-sep|<macro|>>

    <assign|bibliography|<\macro|aux|style|file-name|body>
      <render-bibliography||<arg|body>>
    </macro>>

    <assign|render-bibliography|<\macro|name|body>
      <\with|par-left|<plus|<value|par-left>|3fn>|par-right|<plus|<value|par-right>|3fn>|par-first|0fn|par-par-sep|0fn|font-size|0.84>
        <hrule>

        <arg|body>
      </with>
    </macro>>

    <assign|dfn|<macro|body|<strong|<arg|body>>>>

    <assign|render-proof|<\macro|which|body>
      <\surround|<no-indent><em|<arg|which>>|<htab|0.5fn><qed>>
        <arg|body>
      </surround>
    </macro>>

    <assign|big-figure|<\macro|body|caption>
      <surround|<compound|next-figure>||<render-big-figure|figure|<compound|figure-text>
      <compound|the-figure>|<arg|body>|<assign|the-label|<localize|Figure>
      <the-figure>><arg|caption>>>
    </macro>>
  </hide-preamble>

  <\doc-data|<doc-title|Expectation Maximization>|<doc-subtitle|Notes for the
  bAG seminar>|<\doc-note>
    <with-TeXmacs-text>
  </doc-note>>
    \;
  </doc-data|<doc-author|<author-data|<author-name|Miguel de
  Benito>|<\author-affiliation>
    Universität Augsburg
  </author-affiliation>>>|<doc-date|Oct. 14th, 2014>>

  <abstract-data|<abstract|We revisit some of the ideas from Philipp's talk
  from the point of view of latent variables, then explain how an iterative
  algorithm, Expectation-Maximization, appears naturally for the estimation
  of the parameters. We apply it to mixtures of Gaussian and Bernoulli
  variables. We also say a few words about the Kullback-Leibler divergence to
  be able to show why EM works.>>

  <with|padding-below|0.5fn|ornament-color|pastel
  red|ornament-shape|rounded|<\ornamented>
    <\small>
      <\render-remark|WARNING! >
        These notes are sloppy, incomplete, inconsistent and sloppy. Also,
        they contain errors a.s. Did I mention they are sloppy? They are also
        a rip-off of <cite-detail|bishop_pattern_2006|Chapters 9 and 1.6>.
      </render-remark>
    </small>
  </ornamented>>

  <\with|ornament-shape|rounded|ornament-color|pastel red>
    <\table-of-contents|toc>
      <vspace*|1fn><with|font-series|bold|math-font-series|bold|1.<space|2spc>Why
      we do this> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|bold|math-font-series|bold|2.<space|2spc>Notation
      and conventions> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|bold|math-font-series|bold|3.<space|2spc>Gaussian
      Mixtures with latent variables> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|bold|math-font-series|bold|4.<space|2spc>The
      EM algorithm> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>

      <vspace*|1fn><with|font-series|bold|math-font-series|bold|5.<space|2spc>Back
      to Gaussian Mixtures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.5fn>

      <vspace*|1fn><with|font-series|bold|math-font-series|bold|6.<space|2spc>An
      example with mixtures of Bernoullis>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8><vspace|0.5fn>

      <vspace*|1fn><with|font-series|bold|math-font-series|bold|7.<space|2spc>Where
      to go from here> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.5fn>

      <vspace*|1fn><with|font-series|bold|math-font-series|bold|8.<space|2spc>Appendix>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10><vspace|0.5fn>

      <with|par-left|1tab|8.1.<space|2spc>A word about conditional densities
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|1tab|8.2.<space|2spc>Problems related to the log
      likelihood approach <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|1tab|8.3.<space|2spc>A few sketchy ideas from
      information theory <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <with|par-left|1tab|8.4.<space|2spc>Maximization of the log likelihood
      for the complete dataset <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14>>

      <vspace*|1fn><with|font-series|bold|math-font-series|bold|9.<space|2spc>References>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15><vspace|0.5fn>
    </table-of-contents>
  </with>

  <\section>
    Why we do this
  <|section>
    As before, when we studied <math|K>-means, we will model a random
    variable representing each data point as a mixture of known densities,
    though not necessarily Gaussians.

    <\enumerate>
      <item>We would very much like to generalize/improve the algorithm we
      saw last week, as well as understand and prove its convergence.
      Furthermore, not using gradient descent frees us from the issue with
      the parameter for step length.

      <item>The technique we will develop can be used for <em|maximum a
      posteriori> estimation in order to fix the problem of overfitting
      without recourse to ad-hoc fixes or heuristics.

      <item>In a fully Bayesian framework we can use EM for automatic
      <em|model selection> (e.g. in our examples with mixtures, determining
      the right number <math|K> of different distributions).

      <item>An online version of EM runs in <math|O<around*|(|1|)>> time. See
      <cite-detail|bishop_pattern_2006|Ÿ9.4>.

      <item>Understanding EM sets the grounds for a larger class of
      techniques for deterministic parameter estimation, known as variational
      inference.

      <item>Because we can.
    </enumerate>
  </section>

  <\section|Notation and conventions>
    <strong|Random variables> take values in <math|\<bbb-R\>> or
    <math|\<bbb-R\><rsup|d>> and are denoted with capital letters <math|X,Z>.
    Their <strong|realizations> are denoted with <math|x,z>. We will always
    use <math|X> for the RV originating the data. <math|Z> will be reserved
    for the <strong|latent variables>, e.g. those ``artificially'' added to
    model our assumptions about the internals (e.g. hidden state) of the
    system studied. In our particular examples <math|Z> will take values in
    <math|<around*|{|e<rsub|1>,\<ldots\>,e<rsub|k>|}>> (see
    Ÿ<reference|sec:gmm-latent>). The <strong|probability measure> is denoted
    by a capital <math|P>, <strong|densities of random variables> by a small
    <math|p>. If <math|X> is a discrete RV,
    <math|P<around*|(|X=x|)>=p<rsub|X><around*|(|x|)>>. If no confusion can
    arise we will use the arguments of densities to distinguish among them:
    <math|p<around*|(|x|)>=p<rsub|X><around*|(|x|)>> will be the density of
    <math|X> evaluated at <math|x>, <math|p<around*|(|z\|x|)>=p<rsub|Z\|X><around*|(|z\|x|)>=p<rsub|Z\|X=x><around*|(|z|)>>
    the density of <math|Z> ``given <math|X=x>'' at <math|z>, etc. (see
    Ÿ<reference|sec:cond-densities> for a few words on conditioning on an
    event with probability zero). <math|\<cal-N\><around*|(|\<mu\>,\<Sigma\>|)>>
    denotes a <strong|Gaussian distribution> of mean <math|\<mu\>> and
    covariance matrix <math|\<Sigma\>>, but if we add an argument <math|x>,
    then <math|\<cal-N\><around*|(|x\|\<mu\>,\<Sigma\>|)>> denotes its
    density, i.e.

    <\equation*>
      \<cal-N\><around*|(|x\|\<mu\>,\<Sigma\>|)>\<assign\><frac|1|<around*|(|2*\<mathpi\>|)><rsup|D/2>>*<frac|1|<sqrt|det
      \<Sigma\>>>*exp <around*|{|-<frac|1|2>*<around*|(|x-\<mu\>|)><rsup|\<top\>>*\<Sigma\><rsup|-1>*<around*|(|x-\<mu\>|)>|}>.
    </equation*>

    We subsume all <strong|distribution parameters> into the letter
    <math|\<theta\>>, which may refer to different parameters even in the
    same line, but is always understood as ``the parameters for the
    distribution where <math|\<theta\>> is used''. Conditioning wrt.
    <math|\<theta\>> is to be understood (for now) as a notational reminder
    that there are some parameters. We observe <math|N> <strong|data points>
    in <math|\<bbb-R\><rsup|d>>. They are i.i.d. observations of <math|X>,
    i.e. we have the <strong|joint random variable>
    <math|\<b-X\>=<around*|(|X<rsub|1>,\<ldots\>,X<rsub|N>|)>> with
    <strong|realization> <math|\<b-x\>=<around*|(|x<rsub|1>,\<ldots\>,x<rsub|N>|)>>.
    <math|\<b-x\>> is the actual data we observe. Finally, <math|C> is a
    constant (hopefully) independent of the relevant quantities. It may
    change from line to line.
  </section>

  <\section|Gaussian Mixtures with latent variables<label|sec:gmm-latent>>
    In a first example to connect with the previous talk about
    <math|K>-means, we postulate a convex combination of normal distributions
    (a <dfn|Gaussian mixture>) as the model for each of our data points:

    <\equation>
      <label|eq:gmm><big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>*\<cal-N\><around*|(|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>,
    </equation>

    for some given <math|K\<in\>\<bbb-N\>> and
    <math|<big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>=1,\<pi\><rsub|k>\<in\><around*|[|0,1|]>>.
    Our final objective is of course to fit the parameters
    <math|\<theta\>=<around*|(|\<pi\><rsub|1>,\<ldots\>,\<pi\><rsub|k>,\<mu\><rsub|1>,\<ldots\>,\<mu\><rsub|k>,\<Sigma\><rsub|1>,\<ldots\>,\<Sigma\><rsub|k>|)>>
    to the data <math|\<b-x\>=<around*|(|x<rsub|1>,\<ldots\>,x<rsub|N>|)>>,
    which is a realization of the joint <math|\<b-X\>=<around*|(|X<rsub|1>,\<ldots\>,X<rsub|N>|)>>,
    but we will now arrive at this model from a new point of view.

    We introduce the <dfn|latent variable> <math|Z> with values in
    <math|<around*|{|e<rsub|1>,\<ldots\>,e<rsub|K>|}>> with
    <math|e<rsub|k>\<in\>\<bbb-R\><rsup|K>> basis vectors. For each data
    point, i.e. for each realization <math|x<rsub|n>> of <math|X>, we will
    have an unobserved <math|z<rsub|n>>. The event <math|Z=e<rsub|k>> should
    be interpreted as: the corresponding realization of <math|X> ``comes
    from'' the distribution <math|\<cal-N\><around*|(|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>>,
    i.e. we want to set

    <\equation*>
      p<around*|(|x\|Z=e<rsub|k>|)>=\<cal-N\><around*|(|x\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>.
    </equation*>

    and we choose <math|p<around*|(|Z=e<rsub|k>|)>=\<pi\><rsub|k>>, for some
    <math|\<pi\><rsub|k>\<in\><around*|[|0,1|]>> such that
    <math|<big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>=1>, to be determined.

    <\with|par-columns|2>
      <\render-remark|Remark: >
        What we are doing here is determining the joint distribution
        <math|p<rsub|X,Z>> from the conditional <math|p<rsub|X\|Z>> and the
        marginal <math|p<rsub|Z>>. Although in this case this is no more than
        the product rule, in more complicated situations it is essential to
        study how joint densities factorize as products of conditional
        probabilities to reduce the complexity of the problem. We can depict
        the relationship between <math|X,Z> as in <reference|fig:pgm>.
      </render-remark>

      <big-figure|<with|gr-mode|<tuple|group-edit|move>|gr-frame|<tuple|scale|1cm|<tuple|0.110037gw|0.519998gh>>|gr-geometry|<tuple|geometry|0.714862par|0.460232par|center>|gr-grid|<tuple|empty>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|empty>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<carc|<point|-0.5|1>|<point|0.5|1.0>|<point|0.0|0.5>>|<with|fill-color|light
      grey|<carc|<point|-0.5|-1>|<point|0.5|-1.0>|<point|0.0|-0.6>>>|<with|arrow-end|\<gtr\>|<line|<point|0|0.5>|<point|0.0|-0.6>>>|<with|text-at-valign|center|text-at-halign|center|<math-at|Z|<point|0|1>>>|<with|text-at-valign|center|text-at-halign|center|<math-at|X|<point|0|-1.1>>>|<math-at|p<around*|(|x,z|)>=p<around*|(|x\|z|)>*p<around*|(|z|)>|<point|0.77894024990078|-0.133499455218944>>>>|<label|fig:pgm>Graphical
      representation for our latent variable model.>
    </with>

    Notice that using the fact that each realization
    <math|z=<around*|(|z<rsub|1>,\<ldots\>,z<rsub|K>|)>> of <math|Z> is one
    of the <math|e<rsub|k>>, we may write the distribution of <math|Z> as

    <\equation*>
      p<around*|(|z|)>=<big|prod><rsub|k=1><rsup|K>\<pi\><rsub|k><rsup|z<rsub|k>>,
    </equation*>

    where of course the <math|\<pi\><rsub|k>> are unknown, and the
    conditional <math|X\|Z=z> as

    <\equation*>
      p<around*|(|x\|z|)>=<big|prod><rsub|k=1><rsup|K>\<cal-N\><around*|(|x\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)><rsup|z<rsub|k>>.
    </equation*>

    The density of <math|X> may now be written as the marginalization of the
    joint <math|p<rsub|X,Z>>:

    <\eqnarray*>
      <tformat|<table|<row|<cell|p<around*|(|x|)>>|<cell|=>|<cell|<big|sum><rsub|z\<in\><around*|{|e<rsup|1>,\<ldots\>,e<rsup|K>|}>>p<around*|(|z|)>*p<around*|(|x\|z|)>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|k=1><rsup|K><big|prod><rsub|j=1><rsup|K>\<pi\><rsub|j><rsup|\<delta\><rsub|j\<nocomma\>k>>*<big|prod><rsub|l=1><rsup|K>\<cal-N\><around*|(|x\|\<mu\><rsub|l>,\<Sigma\><rsub|l>|)><rsup|\<delta\><rsub|l\<nocomma\>k>>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>**\<cal-N\><around*|(|x\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>.>>>>
    </eqnarray*>

    So we see that we recover the density <eqref|eq:gmm> as we wished. From
    here we could proceed by attempting to maximize the likelihood of the
    data given the parameters, that is using the marginal:

    <\equation>
      <label|eq:max-likelihood-marginal>log
      p<around*|(|\<b-x\>\|\<theta\>|)>=<big|sum><rsub|n=1><rsup|N>log
      <big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>*\<cal-N\><around*|(|x\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>,
    </equation>

    (recall that the <math|X<rsub|n>> are i.i.d.), differentiating wrt. the
    parameters <math|\<pi\><rsub|k>,\<mu\><rsub|k>,\<Sigma\><rsub|k>>,
    equating to zero and solving for the parameters, but we will meet with
    the following two problems, already discussed in Philipp's talk, and
    explained in more detail below.

    <\enumerate>
      <item>We don't obtain closed-form estimators when we differentiate
      <eqref|eq:max-likelihood-marginal>, so we need to devise and justfiy an
      iterative scheme (e.g. Newton).

      <item>We suffer overfitting with collapsing variances (actually
      ``ultrafitting''!).
    </enumerate>

    <\render-remark|So, why the did we introduce <math|Z>? >
      We now have a joint probability distribution <math|p<rsub|X,Z>> to work
      with which may (as is the case with Gaussian distributions) be more
      easily tractable and lead to closed form estimators when maximizing its
      log likelihood (see Ÿ<reference|sec:em-with-gm>). However, the values
      <math|\<b-z\>> are part of the problem, so we will end up computing an
      expectation wrt. the posterior <math|p<rsub|Z\|X>>. We will show that
      this provides an iterative scheme (which coincides with the Newton
      scheme for <math|K>-means) guaranteed to increase the log likelihood.
    </render-remark>

    For comparison purposes here is how Expectation-Maximization looks for a
    mixture of Gaussians. You'll notice the exact analogy with
    <math|K>-means, where the <em|assignment step> is now the <em|E-step> and
    the <em|update step> is now the <em|M-step>. We will derive this
    algorithm in Ÿ<reference|sec:em-with-gm>.

    <\named-algorithm|No-questions-asked-EM for Gaussian mixtures>
      <\enumerate>
        <item>Initialize the parameters <math|\<theta\>=<around*|(|\<mu\><rsub|k>,\<Sigma\><rsub|k>,\<pi\><rsub|k>|)><rsub|k=1><rsup|K>>.

        <item><strong|E-Step:> compute the posterior
        <math|p<rsub|\<b-Z\>\|\<b-X\>=\<b-x\>,\<theta\><rsup|old>><around*|(|\<b-z\>|)>>
        or <em|responsibilities>.

        <item><strong|M-Step:> maximize <math|E<rsub|\<b-Z\>\|\<b-x\>,\<theta\>><around*|[|log
        p<around*|(|\<b-x\>,\<b-Z\>\|\<theta\>|)>|]>> wrt. the parameters
        <math|\<mu\><rsub|k>,\<Sigma\><rsub|k>,\<pi\><rsub|k>> to obtain new
        values <math|\<mu\><rsub|k><rsup|new>,\<Sigma\><rsub|k><rsup|new>,\<pi\><rsub|k><rsup|new>>.

        <item>Evaluate log likelihood, check for convergence, go to 2 if
        necessary.
      </enumerate>
    </named-algorithm>
  </section>

  <\section|The EM algorithm<label|sec:em-algor>>
    The <strong|key idea> is to use the following decomposition, true for any
    strictly positive probability density <math|q>:

    <\equation>
      <label|eq:ll-decomposed>log p<around*|(|\<b-x\>\|\<theta\>|)>=\<cal-L\><around*|(|q,\<theta\>|)>+KL<around*|(|q\<\|\|\>p<rsub|\<b-Z\>\|\<b-x\>,\<theta\>>|)>,
    </equation>

    where <math|KL> is the Kullback-Leibler divergence (see
    Ÿ<reference|sec:baby-info-theory>), <math|p<rsub|\<b-Z\>\|\<b-x\>,\<theta\>>=p<rsub|\<b-Z\>\|\<b-X\>=\<b-x\>,\<theta\>>>
    is the distribution of the posterior of
    <math|\<b-Z\>=<around*|(|Z<rsub|1>,\<ldots\>,Z<rsub|N>|)>> given the
    dataset <math|\<b-x\>\<in\>\<bbb-R\><rsup|N\<times\>d>> and the choice of
    parameters <math|\<theta\>> and

    <\eqnarray*>
      <tformat|<table|<row|<cell|\<cal-L\><around*|(|q,\<theta\>|)>>|<cell|\<assign\>>|<cell|<big|sum><rsub|\<b-z\><rprime|'>\<in\><around*|{|e<rsub|1>,\<ldots\>,e<rsub|K>|}><rsup|N>>q<around*|(|\<b-z\><rprime|'>|)>*log
      <frac|p<around*|(|\<b-x\>,\<b-z\><rprime|'>\|\<theta\>|)>|q<around*|(|\<b-z\><rprime|'>|)>>>>|<row|<cell|KL<around*|(|q\<\|\|\>p<rsub|\<b-Z\>\|\<b-x\>>|)>>|<cell|\<assign\>>|<cell|-<big|sum><rsub|\<b-z\><rprime|'>\<in\><around*|{|e<rsub|1>,\<ldots\>,e<rsub|K>|}><rsup|N>>q<around*|(|\<b-z\><rprime|'>|)>*log
      <frac|p<around*|(|\<b-z\><rprime|'>\|\<b-x\>,\<theta\>|)>|q<around*|(|\<b-z\><rprime|'>|)>>.>>>>
    </eqnarray*>

    Indeed, adding both quantities and cancelling terms we have

    <\equation*>
      \<cal-L\><around*|(|q,\<theta\>|)>+KL<around*|(|q\<\|\|\>p<rsub|\<b-Z\>\|\<b-X\>>|)>=<big|sum><rsub|\<b-z\><rprime|'>>q<around*|(|\<b-z\><rprime|'>|)>*log
      <frac|p<around*|(|\<b-x\>,\<b-z\><rprime|'>\|\<theta\>|)>|p<around*|(|\<b-z\><rprime|'>\|\<b-x\>,\<theta\>|)>>=<below|<wide*|<big|sum><rsub|\<b-z\><rprime|'>>q<around*|(|\<b-z\><rprime|'>|)>|\<wide-squnderbrace\>>|=1>*log
      p<around*|(|\<b-x\>\|\<theta\>|)>=log
      p<around*|(|\<b-x\>\|\<theta\>|)>.
    </equation*>

    Notice that because <math|KL\<geqslant\>0>, the functional
    <math|\<cal-L\><around*|(|q,\<theta\>|)>> is <em|always a lower bound> to
    <math|log p<around*|(|\<b-x\>\|\<theta\>|)>>.

    <with|ornament-shape|rounded|<\ornamented>
      In each step of the algorithm we will optimize this bound: first wrt.
      <math|q> then wrt. <math|\<theta\>>.
    </ornamented>>

    The lower bound can be written as

    <\eqnarray*>
      <tformat|<table|<row|<cell|\<cal-L\><around*|(|q,\<theta\>|)>>|<cell|=>|<cell|<big|sum><rsub|\<b-z\><rprime|'>>q<around*|(|\<b-z\><rprime|'>|)>*log
      p<around*|(|\<b-x\>,\<b-z\><rprime|'>\|\<theta\>|)>-<big|sum><rsub|\<b-z\><rprime|'>>q<around*|(|\<b-z\><rprime|'>|)>*log
      q<around*|(|\<b-z\><rprime|'>|)>>>|<row|<cell|>|<cell|=>|<cell|E<rsub|q><around*|[|log
      p<around*|(|\<b-x\>,\<b-z\><rprime|'>\|\<theta\>|)>|]>-<below|<wide*|E<rsub|q><around*|[|log
      q<around*|(|\<b-z\><rprime|'>\|\<theta\>|)>|]>|\<wide-squnderbrace\>>|=C>,<eq-number><label|eq:L-in-mstep>>>>>
    </eqnarray*>

    where the constant <math|C> is the entropy of <math|q> (see
    Ÿ<reference|sec:baby-info-theory>) and <math|log
    p<around*|(|\<b-x\>,\<b-z\><rprime|'>\|\<theta\>|)>=g<around*|(|\<b-z\><rprime|'>|)>>
    a function of <math|\<b-z\><rprime|'>> alone. This last line provides the
    intuition behind the decomposition: <em|if> we had the values
    <math|\<b-z\>> of the latent variable
    <math|\<b-Z\>=<around*|(|Z<rsub|1>,\<ldots\>,Z<rsub|N>|)>>, we could
    evaluate the joint density on the complete data set
    <math|p<around*|(|\<b-x\>,\<b-z\>\|\<theta\>|)>>. Under certain
    assumptions it would be an easy matter to maximize its log likelihood
    instead of the marginal <math|log p<around*|(|\<b-x\>\|\<theta\>|)>> and
    we wouldn't need the previous decomposition (e.g. assuming independence
    and a Gaussian mixture, the joint is a double product which the logarithm
    transforms into a double sum, see <eqref|eq:joint-complete-dataset>). But
    we don't have the values <math|\<b-z\>> and all we actually know about
    them is contained in the posterior <math|p<rsub|\<b-Z\>\|\<b-x\>,\<theta\>>>.
    It is therefore sensible to compute the expected value of <math|log
    p<around*|(|\<b-x\>,\<b-z\>\|\<theta\>|)>> under the marginal
    <math|p<rsub|\<b-Z\>\|\<b-x\>,\<theta\>>>, which is exactly the first
    term in the last equation.

    <\named-algorithm>
      EM (Expectation-Maximization)
    <|named-algorithm>
      <\enumerate>
        <item>Initialize.

        <item><strong|E-step:> Fix <math|\<theta\>=\<theta\><rsup|t>> in
        <eqref|eq:ll-decomposed>. Maximize the lower bound <math|\<cal-L\>>
        wrt. the distribution <math|q>. This is achieved by minimizing
        <math|KL> because

        <\equation*>
          \<cal-L\><around*|(|q,\<theta\>|)>=log
          p<around*|(|\<b-x\>\|\<theta\>|)>-KL<around*|(|q\<\|\|\>p<rsub|\<b-Z\>\|\<b-x\>>|)>,
        </equation*>

        and <math|log p<around*|(|\<b-x\>\|\<theta\>|)>> is independent of
        <math|q>. This maximum is realized for the choice
        <math|q<rsup|t>=p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>>> because
        <math|KL<around*|(|q\<\|\|\>p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>>|)>\<geqslant\>0>
        with equality iff <math|q=p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>>>,
        see <eqref|prop:kl-nonneg>. For this <math|q<rsup|t>>,
        <math|\<cal-L\><around*|(|q<rsup|t>,\<theta\><rsup|t>|)>=log
        p<around*|(|\<b-x\>\|\<theta\><rsup|t>|)>> by construction, it is a
        lower bound and the gradients of both functions are parallel, so we
        have a situation like in <reference|fig:2msteps>

        \ Finally, to prepare for the next step compute explicitly
        <math|\<cal-L\>> as given by <eqref|eq:L-in-mstep> and
        <math|g<around*|(|\<b-z\>|)>\<assign\>log
        p<around*|(|\<b-x\>,\<b-z\>\|\<theta\>|)>>:

        <\equation>
          <label|eq:l-as-expectation>\<cal-L\><around*|(|p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>>,\<theta\>|)>=E<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>><around*|[|g<around*|(|\<b-Z\>|)>|]>+C.
        </equation>

        <item><strong|M-step:> Fix now <math|q<rsup|t>=p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>>>
        coming from the E-step and maximize
        <math|\<cal-L\><around*|(|q<rsup|t>,\<theta\>|)>> in
        <eqref|eq:l-as-expectation> wrt. <math|\<theta\>> to obtain
        <math|\<theta\><rsup|t+1>>. This new choice of parameters yields a
        new lower bound <math|\<cal-L\><around*|(|q<rsup|t>,\<theta\><rsup|t+1>|)>\<geqslant\>\<cal-L\><around*|(|q<rsup|t>,\<theta\><rsup|t>|)>>
        and a yet greater increase in the target function:

        <\eqnarray*>
          <tformat|<table|<row|<cell|log p<around*|(|\<b-x\>\|\<theta\><rsup|t+1>|)>>|<cell|=>|<cell|\<cal-L\><around*|(|q<rsup|t>,\<theta\><rsup|t+1>|)>+<below|<wide*|KL<around*|(|q<rsup|t>\<\|\|\>p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t+1>>|)>|\<wide-squnderbrace\>>|\<gtr\>0>>>|<row|<cell|>|<cell|\<gtr\>>|<cell|\<cal-L\><around*|(|q<rsup|t>,\<theta\><rsup|t>|)>+<below|<wide*|KL<around*|(|q<rsup|t>\<\|\|\>p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>>|)>|\<wide-squnderbrace\>>|=0>>>|<row|<cell|>|<cell|=>|<cell|log
          p<around*|(|\<b-x\>\|\<theta\><rsup|t>|)>,>>>>
        </eqnarray*>

        where the first <math|KL> divergence is strictly positive because
        <math|q<rsup|t>\<neq\>p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t+1>>>.
        This means that this step always increases the log likelihood unless
        we were already at a maximum and <math|\<theta\><rsup|t>=\<theta\><rsup|t+1>>.

        <item>Check whether we have finished.
      </enumerate>
    </named-algorithm>

    <big-figure|<with|gr-mode|<tuple|edit|spline>|gr-frame|<tuple|scale|1cm|<tuple|0.0900289gw|0.140033gh>>|gr-geometry|<tuple|geometry|0.812452par|0.4698par|center>|gr-grid|<tuple|empty>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|empty>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-text-at-valign|center|gr-dash-style|10|gr-line-width|0.5ln|gr-arrow-end|\<gtr\>|<graphics||<with|arrow-end|\<gtr\>|<line|<point|0|-1>|<point|0.0|6.0>>>|<with|dash-style|10|<line|<point|4.8|5>|<point|4.8|0.0>>>|<with|dash-style|10|<spline|<point|3|2.41382>|<point|3.0|0.0>>>|<with|dash-style|10|<line|<point|4.16501|3.60001>|<point|4.2|0.0>>>|<with|arrow-end|\<gtr\>|<line|<point|-1|0>|<point|11.0|0.0>>>|<with|text-at-valign|top|text-at-halign|center|<math-at|\<theta\><rsup|t>|<point|3|-0.2>>>|<with|text-at-valign|top|text-at-halign|center|<math-at|\<theta\><rsup|t+1>|<point|4.2|-0.2>>>|<point|4.17049|3.03581>|<point|4.8|4.2>|<with|color|orange|<point|4.17049|3.03581>>|<with|color|dark
    green|<point|4.8|4.2>>|<with|fill-color|dark
    green|<point|4.8|4.2>>|<with|color|dark
    green|<point|4.8|4.2>>|<with|color|orange|<spline|<point|2.004|0>|<point|4.17049367094003|3.0358125086931>|<point|7.6474981146202|0.0>>>|<with|color|dark
    green|<spline|<point|3.50000207170261|1.77404419021698e-6>|<point|4.80000207170261|4.20662034652375>|<point|7.30000207170261|1.77404419021698e-6>>>|<with|text-at-valign|center|<math-at|log
    p<around*|(|\<b-x\>\|\<theta\>|)>|<point|1.31227553512369|5.36728758962826>>>|<with|arrow-end|\<gtr\>|dash-style|10|line-width|0.5ln|<spline|<point|2.43256|5.01748>|<point|3.66018983992592|4.5536115888345>|<point|4.50679278444056|4.42546398221144>>>|<spline|<point|0|1>|<point|2.0|1.6>|<point|3.4|3.0>|<point|4.16501008438624|3.60000131776754>|<point|4.80000000000001|5.00000000000001>|<point|5.6|4.99999999999999>|<point|6.39999999999994|4.69999999999997>|<point|7.69999999968783|2.99999999987921>|<point|9.02301891784628|1.9386162190766>|<point|9.98659359773838|0.0>>|<with|color|white|fill-color|white|<line|<point|8|1.2>|<point|8.0|0.6>|<point|10.6|0.6>|<point|10.6|1.2>|<point|8.0|1.2>>>|<with|text-at-valign|center|<math-at|\<cal-L\><around*|(|q<rsup|t+1>,\<theta\>|)>|<point|8.5|0.860622>>>|<with|color|white|fill-color|white|<line|<point|7.4|1.7>|<point|7.4|2.3>|<point|9.8|2.3>|<point|9.8|1.7>|<point|7.4|1.7>>>|<with|arrow-end|\<gtr\>|dash-style|10|line-width|0.5ln|<spline|<point|7.56186|2>|<point|6.77536711205186|1.93858314591877>|<point|6.3390793635854|1.69072777880635>>>|<with|text-at-valign|center|<math-at|\<cal-L\><around*|(|q<rsup|t>,\<theta\>|)>|<point|7.7|2>>>|<with|arrow-end|\<gtr\>|dash-style|10|line-width|0.5ln|<spline|<point|8.36187|0.86063>|<point|7.61368898002381|0.875942584998016>|<point|7.15705277447912|0.690266968158869>>>>>|<label|fig:2msteps>Example
    for a mixture in the exponential family, where the lower bound is always
    a concave function. Computing <math|\<theta\><rsup|t+1>> in the M-step
    increases the log likelihood. The E-step then computes the posterior
    <math|q<rsup|t+1>> over the latent variables for the new parameters
    <math|\<theta\><rsup|t+1>>, yielding a new lower bound functional
    <math|\<cal-L\><around*|(|q<rsup|t+1>,\<theta\>|)>>, tangent to the log
    likelihood at <math|\<theta\><rsup|t+1>>.>
  </section>

  <\section|Back to Gaussian Mixtures<label|sec:em-with-gm>>
    Recall from Ÿ<reference|sec:gmm-latent> the expressions for
    <math|p<rsub|Z>> and <math|p<rsub|X\|z>>. The joint density of
    <math|<around*|(|X,Z|)>> is

    <\equation*>
      p<rsub|X,Z><around*|(|x,z|)>=<big|prod><rsub|k=1><rsup|K><around*|[|\<pi\><rsub|k>*\<cal-N\><around*|(|x\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>|]><rsup|z<rsub|k>>.
    </equation*>

    Suppose we had all the values <math|\<b-z\>=<around*|(|z<rsub|1>,\<ldots\>,z<rsub|N>|)>>
    in addition to the data <math|\<b-x\>=<around*|(|x<rsub|1>,\<ldots\>,x<rsub|N>|)>>
    (one talks of the <dfn|complete dataset>) and we wanted to maximize the
    log likelihood:

    <\eqnarray*>
      <tformat|<table|<row|<cell|log p<around*|(|\<b-x\>,\<b-z\>\|\<theta\>|)>>|<cell|=>|<cell|log
      <big|prod><rsub|n=1><rsup|N><big|prod><rsub|k=1><rsup|K><around*|[|\<pi\><rsub|k>*\<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>|]><rsup|z<rsub|n\<nocomma\>k>>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|n=1><rsup|N><big|sum><rsub|k=1><rsup|K>z<rsub|n\<nocomma\>k>*<around*|[|log
      \<pi\><rsub|k>+log \<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>|]><eq-number><label|eq:joint-complete-dataset>>>>>
    </eqnarray*>

    where we now had to assume <math|\<pi\><rsub|k>\<in\><around*|(|0,1|)>>
    to be able to take the logarithm. The problem is we don't have the
    <math|z<rsub|n>>! But <math|EM> saves the day:

    <strong|E-step: >Fix <math|\<theta\>=\<theta\><rsup|t>>. We know that the
    optimal <math|q<rsup|t>> is the posterior over the latent variables, and
    we immediately see that it factorizes:

    <\equation*>
      p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>><around*|(|\<b-z\>|)>=<frac|p<around*|(|\<b-x\>\|\<b-z\>,\<theta\><rsup|t>|)>*p<around*|(|\<b-z\>\|\<theta\><rsup|t>|)>|p<around*|(|\<b-x\>\|\<theta\><rsup|t>|)>>=<big|prod><rsub|n=1><rsup|N>
      <below|<wide*|<frac|1|p<around*|(|x\|\<theta\><rsup|t>|)>>*<big|prod><rsub|k=1><rsup|K><around*|[|\<pi\><rsup|t><rsub|k>*\<cal-N\><around*|(|x\|\<mu\><rsup|t><rsub|k>,\<Sigma\><rsup|t><rsub|k>|)>|]><rsup|z<rsub|k>>|\<wide-squnderbrace\>>|=:p<rsub|Z\|x><around*|(|z|)>>.
    </equation*>

    With this choice for <math|q<rsup|t>> the new lower bound is the function
    of <math|\<theta\>>:

    <\equation*>
      \<cal-L\><around*|(|p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>>,\<theta\>|)>=E<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>><around*|[|g<around*|(|\<b-Z\>|)>|]>+C,
    </equation*>

    where <math|g<around*|(|\<b-zeta\>|)>\<assign\>log
    p<rsub|\<b-X\>,\<b-Z\>\|\<theta\>><around*|(|\<b-x\>,\<b-zeta\>\|\<theta\>|)>>.
    Setting <math|z<rsub|n\<nocomma\>k>=<with|math-font|Bbb*|1><rsub|<around*|{|e<rsub|k>|}>><around*|(|Z<rsub|n>|)>>,
    the expectation is

    <\eqnarray*>
      <tformat|<table|<row|<cell|E<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>><around*|[|g<around*|(|\<b-Z\>|)>|]>>|<cell|=>|<cell|E<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>><around*|[|<big|sum><rsub|n=1><rsup|N><big|sum><rsub|k=1><rsup|K>z<rsub|n\<nocomma\>k>*<around*|[|log
      \<pi\><rsub|k>+log \<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>|]>|]>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|n=1><rsup|N><big|sum><rsub|k=1><rsup|K><below|<wide*|E<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>><around*|[|<with|math-font|Bbb*|1><rsub|<around*|{|e<rsub|k>|}>><around*|(|Z<rsub|n>|)>|]>|\<wide-squnderbrace\>>|<around*|(|\<ast\>|)>>*<around*|[|log
      \<pi\><rsub|k>+log \<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>|]>.>>>>
    </eqnarray*>

    In order to compute <math|<around*|(|\<ast\>|)>> we use that the
    posterior factorizes over <math|n>:<\footnote>
      This is just an application of ``Fubini's'' theorem, and might be
      easier to see if we write integrals to make notation easier.
    </footnote>

    <\eqnarray*>
      <tformat|<table|<row|<cell|E<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>><around*|[|<with|math-font|Bbb*|1><rsub|<around*|{|e<rsub|k>|}>><around*|(|Z<rsub|n>|)>|]>>|<cell|=>|<cell|<big|sum><rsub|\<b-z\>\<in\><around*|{|e<rsub|1>,\<ldots\>,e<rsub|K>|}><rsup|N>><with|math-font|Bbb*|1><rsub|<around*|{|e<rsub|k>|}>><around*|(|z<rsub|n>|)>*p<rsub|\<b-Z\>\|\<b-x\>,\<theta\><rsup|t>><around*|(|\<b-z\>|)>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|\<b-z\>\<in\><around*|{|e<rsub|1>,\<ldots\>,e<rsub|K>|}><rsup|N>><with|math-font|Bbb*|1><rsub|<around*|{|e<rsub|k>|}>><around*|(|z<rsub|n>|)>*<around*|(|<big|prod><rsub|j=1><rsup|N>p<rsub|Z\|x,\<theta\><rsup|t>><around*|(|z<rsub|j>|)>|)>>>|<row|<cell|>|<cell|=>|<cell|<below|<wide*|<big|sum><rsub|z\<in\><around*|{|e<rsub|1>,\<ldots\>,e<rsub|K>|}>><with|math-font|Bbb*|1><rsub|<around*|{|e<rsub|k>|}>><around*|(|z|)>*p<rsub|Z\|x,\<theta\><rsup|t>><around*|(|z|)>|\<wide-squnderbrace\>>|=E<rsub|Z\|x,\<theta\><rsup|t>><around*|[|<with|math-font|Bbb*|1><rsub|<around*|{|e<rsub|k>|}>><around*|(|Z<rsub|n>|)>|]>>*<below|<wide*|<around*|(|<big|prod><rsub|j=1,j\<neq\>n><rsup|N><big|sum><rsub|z\<in\><around*|{|e<rsub|1>,\<ldots\>,e<rsub|K>|}>>p<rsub|Z\|x,\<theta\><rsup|t>><around*|(|z|)>|)>|\<wide-squnderbrace\>>|=1>>>|<row|<cell|>|<cell|=>|<cell|p<rsub|Z\|x,\<theta\><rsup|t>><around*|(|e<rsub|k>|)>>>|<row|<cell|>|<cell|=>|<cell|<frac|1|p<around*|(|x\|\<theta\><rsup|t>|)>>*\<pi\><rsup|t><rsub|k>*\<cal-N\><around*|(|x\|\<mu\><rsup|t><rsub|k>,\<Sigma\><rsup|t><rsub|k>|)>>>|<row|<cell|>|<cell|=>|<cell|<frac|\<pi\><rsup|t><rsub|k>*\<cal-N\><around*|(|x\|\<mu\><rsup|t><rsub|k>,\<Sigma\><rsup|t><rsub|k>|)>|<big|sum><rsub|j=1><rsup|K>\<pi\><rsup|t><rsub|j>*\<cal-N\><around*|(|x\|\<mu\><rsup|t><rsub|j>,\<Sigma\><rsup|t><rsub|j>|)>>=:\<gamma\><rsup|t><rsub|n\<nocomma\>k>.>>>>
    </eqnarray*>

    Notice that this quantity is precisely the <dfn|responsibility> of
    cluster <math|k> for the point <math|x<rsub|n>> as defined in
    <eqref|eq:responsibility> when maximizing the log likelihood of the
    marginal <math|p<around*|(|\<b-x\>\|\<theta\>|)>>. Substituting above, we
    have:

    <\equation>
      <label|eq:expectation-posterior-gaussian>E<rsub|\<b-Z\>\|\<b-x\>><around*|[|log
      p<around*|(|\<b-x\>,\<b-z\>\|\<theta\><rsup|t>|)>|]>=<big|sum><rsub|n=1><rsup|N><big|sum><rsub|k=1><rsup|K>\<gamma\><rsup|t><rsub|n\<nocomma\>k>*<around*|[|log
      \<pi\><rsub|k><rsup|t>+log \<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsup|t><rsub|k>,\<Sigma\><rsup|t><rsub|k>|)>|]>,
    </equation>

    and this is the quantity we maximize next.

    <strong|M-step: >We maximize <eqref|eq:expectation-posterior-gaussian>
    wrt. each of <math|\<mu\><rsub|k>,\<Sigma\><rsub|k>,\<pi\><rsub|k>>
    obtaining <em|closed formulas> for <math|\<mu\><rsub|k><rsup|t+1>> and we
    are in business for the next step.

    <\enumerate>
      <item>Differentiate <eqref|eq:expectation-posterior-gaussian> wrt.
      <math|\<mu\><rsub|k>> and equate to zero to obtain:
      <math|0=<big|sum><rsub|n=1><rsup|N>\<gamma\><rsup|t><rsub|n\<nocomma\>k>*<around*|(|\<Sigma\><rsup|t><rsub|k>|)><rsup|-1>*<around*|(|x<rsub|n>-\<mu\><rsub|k>|)>>.
      Now solve for <math|\<mu\><rsub|k>> and multiply on the left by
      <math|\<Sigma\><rsup|t><rsub|k>>:

      <\equation>
        <label|eq:em-mean>\<mu\><rsup|t+1><rsub|k>=<frac|1|N<rsup|t><rsub|k>>*<big|sum><rsub|n=1><rsup|N>\<gamma\><rsup|t><rsub|n\<nocomma\>k>*x<rsub|n>,<text|
        where >N<rsup|t><rsub|k>=<big|sum><rsub|n=1><rsup|N>\<gamma\><rsup|t><rsub|n\<nocomma\>k>.
      </equation>

      <item>Differentiate <eqref|eq:expectation-posterior-gaussian> wrt.
      <math|\<Sigma\><rsub|k>> and equate to zero. After some computations
      and solving for <math|\<Sigma\><rsub|k>> (here the constraint that
      <math|\<Sigma\><rsub|k>> be symmetric positive definite complicates
      matters considerably, see e.g. <cite|anderson_maximum-likelihood_1985>)
      we find:

      <\equation*>
        \<Sigma\><rsup|t+1><rsub|k>=<frac|1|N<rsup|t><rsub|k>>*<big|sum><rsub|n=1><rsup|N>\<gamma\><rsub|n\<nocomma\>k><rsup|t><around*|(|x<rsub|n>-\<mu\><rsup|t><rsub|k>|)>\<otimes\><rsub|><around*|(|x<rsub|n>-\<mu\><rsup|t><rsub|k>|)>.
      </equation*>

      <item>Differentiate <eqref|eq:expectation-posterior-gaussian> wrt.
      <math|\<pi\><rsub|k>>, with the constraint
      <math|<big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>=1> using a Lagrange
      multiplier (recall that now <math|\<pi\><rsub|k>\<in\><around*|(|0,1|)>>):

      <\equation*>
        0=\<partial\><rsub|\<pi\><rsub|k>>
        E<rsub|\<b-Z\>\|\<b-x\>><around*|[|log
        p<around*|(|\<b-x\>,\<b-z\>\|\<theta\><rsup|t>|)>|]>+\<partial\><rsub|\<pi\><rsub|k>>
        \<lambda\><around*|(|<big|sum><rsub|k>\<pi\><rsub|k>-1|)>=<big|sum><rsub|n=1><rsup|N><frac|\<gamma\><rsub|n\<nocomma\>k><rsup|t>|\<pi\><rsub|k>>+\<lambda\>=<frac|N<rsup|t><rsub|k>|\<pi\><rsub|k>>+\<lambda\>.
      </equation*>

      Multiply by <math|\<pi\><rsub|k>> and sum over <math|K> using the
      constraint on the <math|\<pi\><rsub|k>> and the fact that
      <math|<big|sum><rsub|k=1><rsup|K>\<gamma\><rsub|n\<nocomma\>k><rsup|t>=1>:

      <\equation*>
        0=<big|sum><rsub|k=1><rsup|K>N<rsup|t><rsub|k>+\<lambda\>*<big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>\<Rightarrow\>\<lambda\>=-N
      </equation*>

      Substituting above this yields

      <\equation*>
        \<pi\><rsup|t+1><rsub|k>=<frac|N<rsup|t><rsub|k>|N>.
      </equation*>
    </enumerate>

    <strong|Evaluate: >We use the estimators obtained in the M-step to
    evaluate the log likelihood and check if we should stop.
  </section>

  <\section|An example with mixtures of Bernoullis>
    This model is called <em|latent class analysis> and is an exercise for
    the reader! We will use it for Hidden Markov Models over discrete
    variables, if we ever do those.

    We now have <math|D> i.i.d. binary variables
    <math|B=<around*|(|B<rsub|1>,\<ldots\>,B<rsub|D>|)>>, with
    <math|B<rsub|i>\<sim\>\<cal-B\><around*|(|\<mu\><rsub|i>|)>>, i.e.

    <\equation*>
      p<around*|(|b\|\<mu\>|)>=<big|prod><rsub|i=1><rsup|D>\<mu\><rsub|i><rsup|b<rsub|i>>*<around*|(|1-\<mu\><rsub|i>|)><rsup|1-b<rsub|i>>.
    </equation*>

    Consider a mixture

    <\equation*>
      X\<sim\><big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>*B<around*|(|\<mu\><rsup|k>|)>.
    </equation*>

    Compute mean, covariance and log likelihood for some data
    <math|\<b-x\>=<around*|(|x<rsub|1>,\<ldots\>,x<rsub|N>|)>>.

    Apply this to the MNIST data set of handwritten digits, see the Kaggle at
    <cite|kaggle.com_classify_2012> or the original source at
    <cite|lecun_mnist_2012>.
  </section>

  <\section|Where to go from here<label|sec:what-next>>
    Some ideas:

    <\itemize-dot>
      <item>Implement <dfn|maximum a posteriori> estimation using EM. The
      idea is to maximize the log likelihood of the posterior over the
      parameters <math|log p<around*|(|\<theta\>\|\<b-x\>|)>> to solve the
      problem of ``collapsing variances''. Using Bayes' rule and the
      decomposition <eqref|eq:ll-decomposed> we have

      <\eqnarray*>
        <tformat|<table|<row|<cell|log p<around*|(|\<theta\>\|\<b-x\>|)>>|<cell|=>|<cell|log
        p<around*|(|\<theta\>,\<b-x\>|)>-log
        p<around*|(|\<b-x\>|)>>>|<row|<cell|>|<cell|=>|<cell|log
        p<around*|(|\<b-x\>\|\<theta\>|)>+log
        p<around*|(|\<theta\>|)>-<below|<wide*|log
        p<around*|(|\<b-x\>|)>|\<wide-squnderbrace\>>|=C>>>|<row|<cell|>|<cell|=>|<cell|\<cal-L\><around*|(|q,\<theta\>|)>+KL<around*|(|q\<\|\|\>p<rsub|\<b-Z\>\|\<b-x\>,\<theta\>>|)>+log
        p<around*|(|\<theta\>|)>-C>>|<row|<cell|>|<cell|=>|<cell|<wide|\<cal-L\>|~><around*|(|q,\<theta\>|)>+KL<around*|(|q\<\|\|\>p<rsub|\<b-Z\>\|\<b-x\>,\<theta\>>|)>,>>>>
      </eqnarray*>

      and we now apply EM to this expression. The only necessary modification
      is to the estimators in the M step, due to the appearance of the prior
      in <math|log p<around*|(|\<theta\>|)>>.

      <item>Fully Bayesian use of EM including model selection.

      <item>Expectation Propagation.
    </itemize-dot>
  </section>

  <\section|Appendix>
    <\subsection|A word about conditional densities>
      <label|sec:cond-densities>

      If <math|<around*|(|X,Z|)>> is a RV with real values, then

      <\equation*>
        p<around*|(|z\|x|)>=p<rsub|Z\|X=x><around*|(|z|)>\<assign\><frac|p<rsub|X,Z><around*|(|x,z|)>|p<rsub|X><around*|(|x|)>>
      </equation*>

      defines a probability density at every <math|x> such that
      <math|p<around*|(|x|)>\<neq\>0>, since it is non-negative, measurable
      and

      <\equation*>
        <big|int>p<around*|(|z\|x|)>*\<mathd\>z=<frac|1|p<around*|(|x|)>><big|int>p<around*|(|x,z|)>*\<mathd\>z=1.
      </equation*>

      For discrete variables this agrees with the usual product rule, but for
      continuous variables needs interpreting, since <math|<around*|{|X=x|}>>
      is a null set, see e.g. <cite-detail|jacod_probability_2004|Ÿ12>.
    </subsection>

    <\subsection|Problems related to the log likelihood approach>
      \;

      <\render-remark|Collapsing variance: >
        Suppose that at some point in our algorithm for maximizing
        <eqref|eq:max-likelihood-marginal>, whatever it is, we set
        <math|\<mu\><rsub|k>=x<rsub|n>> for some <math|n,k>, then the
        <math|k>-th summand in <eqref|eq:max-likelihood-marginal> will be

        <\equation*>
          \<pi\><rsub|k>*\<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>=C*<frac|1|<sqrt|det
          \<Sigma\><rsub|k>>>,
        </equation*>

        and we can obviously send this quantity to <math|+\<infty\>> by
        adjusting the covariance matrix. If the algorithm goes on trying to
        maximize the whole expression, it will do exactly that and will
        almost surely fail with a division by zero.

        We talk about collapsing variance because <math|\<Sigma\>> being
        symmetric positive definite, it may be diagonalized and the new
        diagonal entries are the variances of the <math|X<rsub|i>> in the new
        coordinates.

        We have at least two solutions to this problem, the hacky and the
        not-so-hacky:

        <\enumerate>
          <item>Hack hack: use some heuristics in the code to avoid the
          situation <math|\<mu\><rsub|k>=x<rsub|n>> for any <math|k,n>. For
          instance, randomly reset <math|\<mu\><rsub|k>> if there is any
          <math|n\<in\><around*|{|1,\<ldots\>,N|}>> such that
          <math|<around*|\||x<rsub|n>-\<mu\><rsub|k>|\|>\<less\>\<varepsilon\>>
          for some fixed <math|\<varepsilon\>\<gtr\>0>. Ugly!

          <item>Penalize: postulate a prior on the parameters
          <math|p<rsub|\<Theta\>>> and add a term <math|log
          p<rsub|\<Theta\>><around*|(|\<theta\>|)>> (called <dfn|capacity>)
          to penalize lower probabilities of <math|\<theta\>>. Some good
          choice of <math|p<rsub|\<Theta\>>> should fix the issue. We can
          justify this idea within the framework presented in
          Ÿ<reference|sec:em-algor>, as sketched in
          Ÿ<reference|sec:what-next>.
        </enumerate>
      </render-remark>

      <\render-remark|Non-closed estimators: >
        Maximizing <eqref|eq:max-likelihood-marginal> is a matter of
        differentiating wrt. each parameter in <math|\<theta\>>, setting
        equal to <math|0> and solving for the parameter, then checking the
        second derivatives. Consider for example the mean
        <math|\<mu\><rsub|k>>:

        <\equation*>
          \<partial\><rsub|\<mu\><rsub|k>> log
          p<around*|(|\<b-x\>\|\<theta\>|)>=\<ldots\><text|compute
          compute>\<ldots\>=<big|sum><rsub|n=1><rsup|N>\<gamma\><rsub|n\<nocomma\>k>*\<Sigma\><rsub|k><rsup|-1>*<around*|(|x<rsub|n>-\<mu\><rsub|k>|)>.
        </equation*>

        Solving for <math|\<mu\><rsub|k>> yields:

        <\equation>
          <label|eq:mle-mean>\<mu\><rsub|k>=<frac|1|N<rsub|k>>*<big|sum><rsub|n=1><rsup|N>\<gamma\><rsub|n\<nocomma\>k>*x<rsub|n>,<text|
          where >N<rsub|k>=<big|sum><rsub|n=1><rsup|N>\<gamma\><rsub|n\<nocomma\>k>,
        </equation>

        and we defined the <dfn|responsibility>

        <\equation>
          <label|eq:responsibility>\<gamma\><rsub|n\<nocomma\>k>=P<around*|(|Z<rsub|n>=e<rsub|k>\|X<rsub|n>=x<rsub|n>|)>
        </equation>

        to be the <em|posterior probability> of having <math|z<rsub|n>> given
        the data <math|x<rsub|n>>. You can see that <eqref|eq:mle-mean> is
        not a closed formula for <math|\<mu\><rsub|k>> since on the rhs.
        <math|\<gamma\><rsub|n\<nocomma\>k>> depends itself on
        <math|\<mu\><rsub|k>>. Indeed, recalling our previous computations
        for the joint and marginal and using the product rule twice we have
        explicitly

        <\equation*>
          p<around*|(|z\|x|)>=<frac|p<around*|(|x,z|)>|p<around*|(|x|)>>=<frac|p<around*|(|x\|z|)>*p<around*|(|z|)>|p<around*|(|x|)>>=<frac|<big|prod><rsub|k=1><rsup|K>\<cal-N\><around*|(|x\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)><rsup|z<rsub|k>>*<big|prod><rsub|k=1><rsup|K>\<pi\><rsub|k><rsup|z<rsub|k>>|<big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>**\<cal-N\><around*|(|x\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>>,
        </equation*>

        and consequently:

        <\equation*>
          \<gamma\><rsub|n\<nocomma\>k>=p<around*|(|z<rsub|n>=e<rsub|k>\|x<rsub|n>|)>=<frac|\<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>*\<pi\><rsub|k>|<big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>**\<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>>.
        </equation*>

        Analogously, the other two estimators are also in non-closed form
        (they are obtained in the same way as in
        Ÿ<reference|sec:em-with-gm>):

        <\equation>
          <label|eq:mle-cov-resp>\<Sigma\><rsub|k>=<frac|1|N<rsub|k>>*<big|sum><rsub|n=1><rsup|N>\<gamma\><rsub|n\<nocomma\>k><around*|(|x<rsub|n>-\<mu\><rsub|k>|)>\<otimes\><rsub|><around*|(|x<rsub|n>-\<mu\><rsub|k>|)><text|
          and >\<pi\><rsub|k>=<frac|N<rsub|k>|N>.
        </equation>

        We already saw a solution with Philipp to this problem: the
        expressions <eqref|eq:mle-mean>, <eqref|eq:mle-cov> for the
        estimators for <math|\<mu\><rsub|k>,\<Sigma\><rsub|k>,\<pi\><rsub|k>>
        feature the variables themselves at the rhs., which suggests that we
        use a Newton-like iterative scheme. Our different modelling guides us
        to Expectation-Maximization.

        <\render-remark|Model order:>
          \ This is actually not a problem of the log likelihood estimation
          <em|per se>, but of the mixture model. We have always assumed that
          we know some value for the number of components <math|K>, but for
          many applications this will not be the case.
        </render-remark>
      </render-remark>
    </subsection>

    <\subsection|A few sketchy ideas from information theory>
      <label|sec:baby-info-theory>

      We want to know how much information about a random variable <math|X>
      is transmitted when we send a specific value <math|x>. This should be a
      monotonically decreasing function of the probability of the event
      because of the following simple ideas:

      <\itemize-dot>
        <item>News of event with probability one are no information.

        <item>News of event with low probability are ``high'' information.
      </itemize-dot>

      <dfn|Information content: > <math|h<around*|(|x|)>\<assign\>-log
      p<around*|(|x|)>>.\ 

      <dfn|Entropy of a RV: >

      <\equation*>
        E<rsub|X><around*|[|h<around*|(|X|)>|]>=-<big|int><rsub|\<bbb-R\>>log
        <around*|(|p<around*|(|x|)>|)>*p<around*|(|x|)>*\<mathd\>x,
      </equation*>

      where we set <math|p*log p=0> if <math|p=0> by continuity <math|p*ln
      p\<rightarrow\>0> for <math|p\<rightarrow\>0>. This integral converges
      (!).

      <\render-theorem|Noiseless decoding theorem>
        <dueto|Shanon 1948>Entropy is a lower bound on the number of bits
        (resp. nats) needed to transmit the state of a random variable.
      </render-theorem>

      <dfn|Kullback-Leibler divergence>: We have approximated an unknown
      distribution <math|p> of some random variable <math|X> (assumed to be
      <math|p\<gtr\>0>) with a distribution <math|q>. How well did we do?
      Define the <em|<math|KL>-divergence> as

      <\eqnarray*>
        <tformat|<table|<row|<cell|KL<around*|(|p\<\|\|\>q|)>>|<cell|\<assign\>>|<cell|-<big|int>log
        q<around*|(|x|)>*p<around*|(|x|)>*\<mathd\>x-<below|<wide*|<around*|(|-<big|int>log
        p<around*|(|x|)>*p<around*|(|x|)>*\<mathd\>x|)>|\<wide-squnderbrace\>>|=H<around*|[|X|]>>>>|<row|<cell|>|<cell|=>|<cell|-<big|int>log
        <frac|q<around*|(|x|)>|p<around*|(|x|)>>*p<around*|(|x|)>*\<mathd\>x.>>>>
      </eqnarray*>

      Intuition: <math|KL> is the <em|additional> amount of information
      needing to be transmitted to specify <math|X> by using <math|q> instead
      of <math|p>. <math|KL<around*|(|\<cdot\>\<\|\|\>\<cdot\>|)>> is not a
      distance since it is obviously not symmetric. We have however:

      <\render-theorem|Non-negativity of <math|KL>>
        <assign|the-label|Non-negativity of KL><label|th:KL-non-negative>

        <\equation>
          <label|prop:kl-nonneg>KL<around*|(|p\<\|\|\>q|)>\<geqslant\>0<text|
          with equality iff >p=q.
        </equation>
      </render-theorem>

      <\render-proof|Proof. >
        This is a direct application of Jensen's inequality (recall that for
        <math|\<varphi\>> convex and <math|\<mu\>> finite this is:
        <math|\<varphi\><around*|(|<big|int>f*\<mathd\>\<mu\>|)>\<leqslant\><big|int>\<varphi\><around*|(|f|)>*\<mathd\>\<mu\>>,
        when things make sense, blah blah...). By the convexity of the
        <math|-log> (recall that we assume <math|p\<gtr\>0>):

        <\equation*>
          KL<around*|(|p\<\|\|\>q|)>=<big|int>-log
          <frac|q<around*|(|x|)>|p<around*|(|x|)>>*p<around*|(|x|)>*\<mathd\>x\<geqslant\>-log
          <big|int><frac|q<around*|(|x|)>|p<around*|(|x|)>>*p<around*|(|x|)>*\<mathd\>x=-log
          <big|int>q<around*|(|x|)>*\<mathd\>x=0,
        </equation*>

        where we used that <math|q> is a probability distribution.
      </render-proof>

      <\render-remark|An example using <math|KL>: >
        Suppose we stick to one family of distributions
        <math|q=q<around*|(|x\|\<theta\>|)>>. We would like to estimate the
        best <math|\<theta\>> by minimizing <math|KL>:

        <\equation*>
          KL<around*|(|p\<\|\|\>q|)>=-<big|int>log
          <frac|q<around*|(|x|)>|p<around*|(|x|)>>*p<around*|(|x|)>*\<mathd\>x=-E<rsub|p><around*|[|log
          q|]>+C,
        </equation*>

        but this is not possible since <math|p> is unknown. However, the
        expectation wrt. <math|p> may be approximated (!) by a finite sum
        over the observed data <math|x<rsub|1>,\<ldots\>,x<rsub|N>>:

        <\eqnarray*>
          <tformat|<table|<row|<cell|KL<around*|(|p\<\|\|\>q|)>>|<cell|\<backsimeq\>>|<cell|<frac|1|N>*<big|sum><rsub|n=1><rsup|N><around*|[|-log
          q<around*|(|x<rsub|n>\|\<theta\>|)>+log
          p<around*|(|x<rsub|n>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|<frac|1|N>*<big|sum><rsub|n=1><rsup|N>-log
          q<around*|(|x<rsub|n>\|\<theta\>|)>+C,>>>>
        </eqnarray*>

        and this quantity may be now minimized. Notice that the first term is
        the negative log likelihood of <math|q<around*|(|\<cdot\>\|\<theta\>|)>>
        under the observed data <math|\<b-x\>=<around*|(|x<rsub|1>,\<ldots\>,x<rsub|n>|)>>.
      </render-remark>
    </subsection>

    <\subsection|Maximization of the log likelihood for the complete dataset>
      \;

      Assuming we have the complete dataset, i.e. all of <math|\<b-x\>> and
      <math|\<b-z\>> (which we don't) finding maxima wrt. to the parameters
      is easy. For the means we compute

      <\equation*>
        \<partial\><rsub|\<mu\><rsub|k>> log
        p<around*|(|\<b-x\>,\<b-z\>\|\<theta\>|)>=<big|sum><rsub|n\<in\>C<rsub|k>>\<partial\><rsub|\<mu\><rsub|k>>
        log \<cal-N\><around*|(|x<rsub|n>\|\<mu\><rsub|k>,\<Sigma\><rsub|k>|)>=<big|sum><rsub|n\<in\>C<rsub|k>>\<Sigma\><rsub|k><rsup|-1>*<around*|(|x<rsub|n>-\<mu\><rsub|k>|)>.
      </equation*>

      Equating to zero and solving for <math|\<mu\><rsub|k>> we find that

      <\equation*>
        <wide|\<mu\>|\<wide-bar\>><rsub|k>=<frac|1|#C<rsub|k>>*<big|sum><rsub|n\<in\>C<rsub|k>>x<rsub|n>
      </equation*>

      is a critical point, and it is a maximum by the properties of
      <math|\<Sigma\><rsub|k>>. Analogously, differentiation wrt.
      <math|\<Sigma\><rsub|k>> yields (with quite some effort since we have
      the constraint that <math|\<Sigma\><rsub|k>> be symmetric positive
      definite, see e.g. <cite|anderson_maximum-likelihood_1985>)

      <\equation*>
        <wide|\<Sigma\>|\<wide-bar\>><rsub|k>=<frac|1|#C<rsub|k>>*<big|sum><rsub|n\<in\>C<rsub|k>><around*|(|x<rsub|n>-<wide|\<mu\>|\<wide-bar\>><rsub|k>|)>\<otimes\><rsub|><around*|(|x<rsub|n>-<wide|\<mu\>|\<wide-bar\>><rsub|k>|)>.
      </equation*>

      Finally, for the weights <math|\<pi\><rsub|k>> we have to include the
      constraint <math|<big|sum><rsub|k>\<pi\><rsub|k>=1>, which we do with a
      Lagrange multiplier (recall that now
      <math|\<pi\><rsub|k>\<in\><around*|(|0,1|)>>, so this is no issue):

      <\equation*>
        0=\<partial\><rsub|\<pi\><rsub|k>> log
        p<around*|(|\<b-x\>,\<b-z\>\|\<theta\>|)>+\<partial\><rsub|\<pi\><rsub|k>>
        \<lambda\><around*|(|<big|sum><rsub|k>\<pi\><rsub|k>-1|)>=<big|sum><rsub|n\<in\>C<rsub|k>><frac|1|\<pi\><rsub|k>>+\<lambda\>=<frac|#C<rsub|k>|\<pi\><rsub|k>>+\<lambda\>.
      </equation*>

      We multiply by <math|\<pi\><rsub|k>> and sum over <math|K> using the
      constraint on <math|\<pi\><rsub|k>>:
      <math|\<lambda\>*\<pi\><rsub|k>=-#C<rsub|k>\<Rightarrow\>\<lambda\>*<big|sum><rsub|k=1><rsup|K>\<pi\><rsub|k>=-<big|sum><rsub|k=1><rsup|K>#C<rsub|k>=-N>,
      so we have <math|\<lambda\>=-N>. Substituting above this yields

      <\equation*>
        \<pi\><rsub|k>=<frac|#C<rsub|k>|N>.
      </equation*>
    </subsection>
  </section>

  <\section|References>
    You can read a much better version of all this stuff in
    <cite-detail|bishop_pattern_2006|Chapter 9>. Another reference,
    explaining less but with more applications is
    <cite-detail|murphy_machine_2012|Chapter 11>. For more on probabilistic
    graphical models, read <cite-detail|murphy_machine_2012|Chapter 10> or
    \ <cite-detail|koller_probabilistic_2009|Chapter 3>. A <TeXmacs> file
    with an implementation of EM for Gaussians is also available.

    <\bibliography|bib|tm-alpha|EM-bAG.bib>
      <\bib-list|7>
        <bibitem*|AO85><label|bib-anderson_maximum-likelihood_1985>T.
        W.<nbsp>Anderson<localize| and >I.<nbsp>Olkin.<newblock>
        Maximum-likelihood estimation of the parameters of a multivariate
        normal distribution.<newblock> <with|font-shape|italic|Linear Algebra
        and its Applications>, 70:147--171, oct 1985.<newblock>

        <bibitem*|Bis06><label|bib-bishop_pattern_2006>Christopher
        M.<nbsp>Bishop.<newblock> <with|font-shape|italic|Pattern recognition
        and machine learning>.<newblock> Information science and statistics.
        Springer, 1<localize| edition>, aug 2006.<newblock>

        <bibitem*|JP04><label|bib-jacod_probability_2004>Jean<nbsp>Jacod<localize|
        and >Philip<nbsp>Protter.<newblock>
        <with|font-shape|italic|Probability essentials>.<newblock>
        Universitext. Springer Berlin Heidelberg, 2<localize| edition>, jan
        2004.<newblock>

        <bibitem*|Kag12><label|bib-kaggle.com_classify_2012>Kaggle.com.<newblock>
        Classify handwritten digits using the famous MNIST data.<newblock>
        jul 2012.<newblock>

        <bibitem*|KF09><label|bib-koller_probabilistic_2009>Daphne<nbsp>Koller<localize|
        and >Nir<nbsp>Friedman.<newblock>
        <with|font-shape|italic|Probabilistic graphical models: principles
        and techniques>.<newblock> Adaptive Computation and Machine Learning.
        MIT Press, 2009.<newblock>

        <bibitem*|LCB12><label|bib-lecun_mnist_2012>Yan<nbsp>LeCun,
        Corinna<nbsp>Cortes<localize| and >Christopher
        J.C.<nbsp>Burges.<newblock> The MNIST database of handwritten
        digits.<newblock> 2012.<newblock>

        <bibitem*|Mur12><label|bib-murphy_machine_2012>Kevin
        P.<nbsp>Murphy.<newblock> <with|font-shape|italic|Machine learning: a
        probabilistic perspective>.<newblock> MIT Press, aug 2012.<newblock>
      </bib-list>
    </bibliography>
  </section>
</body>

<\initial>
  <\collection>
    <associate|font-base-size|12>
    <associate|info-flag|detailed>
    <associate|page-medium|paper>
    <associate|par-first|0tab>
    <associate|par-par-sep|0.6666fn>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|2>>
    <associate|auto-10|<tuple|8|10>>
    <associate|auto-11|<tuple|8.1|10>>
    <associate|auto-12|<tuple|8.2|10>>
    <associate|auto-13|<tuple|8.3|12>>
    <associate|auto-14|<tuple|8.4|13>>
    <associate|auto-15|<tuple|9|14>>
    <associate|auto-16|<tuple|9|14>>
    <associate|auto-17|<tuple|9|12>>
    <associate|auto-18|<tuple|9|14>>
    <associate|auto-19|<tuple|9|14>>
    <associate|auto-2|<tuple|2|2>>
    <associate|auto-20|<tuple|9|11>>
    <associate|auto-21|<tuple|9|12>>
    <associate|auto-22|<tuple|9|12>>
    <associate|auto-23|<tuple|9|14>>
    <associate|auto-24|<tuple|9|15>>
    <associate|auto-3|<tuple|3|3>>
    <associate|auto-4|<tuple|1|3>>
    <associate|auto-5|<tuple|4|5>>
    <associate|auto-6|<tuple|2|7>>
    <associate|auto-7|<tuple|5|7>>
    <associate|auto-8|<tuple|6|9>>
    <associate|auto-9|<tuple|7|10>>
    <associate|bib-anderson_maximum-likelihood_1985|<tuple|AO85|14>>
    <associate|bib-bishop_pattern_2006|<tuple|Bis06|14>>
    <associate|bib-jacod_probability_2004|<tuple|JP04|14>>
    <associate|bib-kaggle.com_classify_2012|<tuple|Kag12|14>>
    <associate|bib-kaggle_inc._classify_2012|<tuple|inc12|15>>
    <associate|bib-koller_probabilistic_2009|<tuple|KF09|14>>
    <associate|bib-lecun_mnist_2012|<tuple|LCB12|14>>
    <associate|bib-murphy_machine_2012|<tuple|Mur12|15>>
    <associate|eq:L-in-mstep|<tuple|4|6>>
    <associate|eq:computed-posterior-expectation|<tuple|7|?>>
    <associate|eq:diff-mean|<tuple|2|?|../../../../.TeXmacs/texts/scratch/no_name_46.tm>>
    <associate|eq:em-mean|<tuple|8|8>>
    <associate|eq:expectation-posterior-gaussian|<tuple|7|8>>
    <associate|eq:gmm|<tuple|1|3>>
    <associate|eq:joint-complete-dataset|<tuple|6|7>>
    <associate|eq:l-as-expectation|<tuple|5|6>>
    <associate|eq:ll-decomposed|<tuple|3|5>>
    <associate|eq:max-likelihood-marginal|<tuple|2|4>>
    <associate|eq:mle-cov|<tuple|11|11>>
    <associate|eq:mle-cov-resp|<tuple|11|12>>
    <associate|eq:mle-covariance|<tuple|3|?>>
    <associate|eq:mle-mean|<tuple|9|11>>
    <associate|eq:mle-resp|<tuple|12|11>>
    <associate|eq:responsibilities|<tuple|6|?>>
    <associate|eq:responsibility|<tuple|10|11>>
    <associate|fig:2msteps|<tuple|Figure 2|7>>
    <associate|fig:pgm|<tuple|Figure 1|3>>
    <associate|fig:pgn|<tuple|1|?>>
    <associate|footnote-1|<tuple|1|8>>
    <associate|footnr-1|<tuple|1|8>>
    <associate|prop:kl-nonneg|<tuple|12|13>>
    <associate|prop:kl-positive|<tuple|1|?|../../../../.TeXmacs/texts/scratch/no_name_46.tm>>
    <associate|sec:baby-info-theory|<tuple|8.3|12>>
    <associate|sec:cond-densities|<tuple|8.1|10>>
    <associate|sec:em-algor|<tuple|4|5>>
    <associate|sec:em-with-gm|<tuple|5|7>>
    <associate|sec:gmm-latent|<tuple|3|3>>
    <associate|sec:what-next|<tuple|7|10>>
    <associate|th:KL-non-negative|<tuple|Non-negativity of KL|13>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|bib>
      bishop_pattern_2006

      bishop_pattern_2006

      anderson_maximum-likelihood_1985

      kaggle.com_classify_2012

      lecun_mnist_2012

      jacod_probability_2004

      anderson_maximum-likelihood_1985

      bishop_pattern_2006

      murphy_machine_2012

      murphy_machine_2012

      koller_probabilistic_2009
    </associate>
    <\associate|figure>
      <tuple|normal|<assign|the-label|<quote|Figure 1>>Graphical
      representation for our latent variable model.|<pageref|auto-4>>

      <tuple|normal|<assign|the-label|<quote|Figure 2>>Example for a mixture
      in the exponential family, where the lower bound is always a concave
      function. Computing <with|mode|<quote|math>|\<theta\><rsup|t+1>> in the
      M-step increases the log likelihood. The E-step then computes the
      posterior <with|mode|<quote|math>|q<rsup|t+1>> over the latent
      variables for the new parameters <with|mode|<quote|math>|\<theta\><rsup|t+1>>,
      yielding a new lower bound functional
      <with|mode|<quote|math>|\<cal-L\><around*|(|q<rsup|t+1>,\<theta\>|)>>,
      tangent to the log likelihood at <with|mode|<quote|math>|\<theta\><rsup|t+1>>.|<pageref|auto-6>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1.<space|2spc>Why
      we do this> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2.<space|2spc>Notation
      and conventions> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3.<space|2spc>Gaussian
      Mixtures with latent variables> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4.<space|2spc>The
      EM algorithm> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|5.<space|2spc>Back
      to Gaussian Mixtures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|6.<space|2spc>An
      example with mixtures of Bernoullis>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|7.<space|2spc>Where
      to go from here> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|8.<space|2spc>Appendix>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10><vspace|0.5fn>

      <with|par-left|<quote|1tab>|8.1.<space|2spc>A word about conditional
      densities <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|8.2.<space|2spc>Problems related to the log
      likelihood approach <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|<quote|1tab>|8.3.<space|2spc>A few sketchy ideas from
      information theory <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <with|par-left|<quote|1tab>|8.4.<space|2spc>Maximization of the log
      likelihood for the complete dataset
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|9.<space|2spc>References>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>