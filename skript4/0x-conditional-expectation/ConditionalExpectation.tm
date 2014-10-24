<TeXmacs|1.99.2>

<style|<tuple|generic|british>>

<\body>
  <doc-data|<doc-title|Conditional Expectations without
  tears>|<doc-author|<author-data|<author-name|Philipp
  Düren>|<\author-affiliation>
    Universität Augsburg
  </author-affiliation>>>>

  <abstract-data|<abstract|Following <cite|Klenke>, we give a review over the
  standard theory of expectation values with a decisive focus on an intuitive
  view on this topic.>>

  <section|Revision of basic theory: Conditioning on regular events and
  <math|\<sigma\>>-Algebras of simplest type>

  We assume that the reader is already familiar with basic conditional
  probability theory (e.g. ``Given the information that the sum of two dice
  is <math|9>, what is the probability for the first dice to show a
  <math|5>?'') and that he has an understanding of the following topics:

  <\theorem>
    Law of total probability

    Let <math|<around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>>be a probability
    space and <math|<around*|(|B<rsub|i>|)><rsub|i\<in\>I>> an at-most
    countably collection of disjoint sets with
    <math|\<bbb-P\><around*|(|<big|pluscup><rsub|i\<in\>I>B<rsub|i>|)>=1>.
    Then for every event <math|A\<in\>\<frak-A\>>

    <\equation*>
      \<bbb-P\><around*|(|A|)>=<big|sum><rsub|i\<in\>I>\<bbb-P\><around*|(|A\|B<rsub|i>|)>\<cdot\>\<bbb-P\><around*|(|B<rsub|i>|)>
    </equation*>
  </theorem>

  <\theorem>
    Bayes' theorem

    Let <math|<around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>>be a probability
    space and <math|<around*|(|B<rsub|i>|)><rsub|i\<in\>I>> an at-most
    countably collection of disjoint sets with
    <math|\<bbb-P\><around*|(|<big|pluscup><rsub|i\<in\>I>B<rsub|i>|)>=1>.
    Then for every event <math|A\<in\>\<frak-A\>> having probability
    <math|\<bbb-P\><around*|(|A|)>\<gtr\>0> and every <math|k\<in\>I>

    <\equation*>
      \<bbb-P\><around*|(|B<rsub|k>\|A|)>=<frac|\<bbb-P\><around*|(|A\|B<rsub|k>|)>\<cdot\>\<bbb-P\><around*|(|B<rsub|k>|)>|<big|sum><rsub|i\<in\>I>\<bbb-P\><around*|(|A\|B<rsub|i>|)>\<cdot\>\<bbb-P\><around*|(|B<rsub|i>|)>>
    </equation*>
  </theorem>

  <\definition>
    Conditional expectation of random variables on regular events

    Let <math|X\<in\>L<rsup|1><around*|(|\<bbb-P\>|)>>(i.e. X has a finite
    ``ordinary'' expectation) and <math|A\<in\>\<frak-A\>> be an event with
    probability <math|\<bbb-P\><around*|(|A|)> \<gtr\> 0>. Then we define

    <\equation>
      <label|eq1>\<bbb-E\><around*|[|X\|A|]>\<equiv\><big|int>X<around*|(|\<omega\>|)>\<space\>\<bbb-P\><around*|(|<math-up|d>\<omega\>\|A|)>=<frac|\<bbb-E\><around*|[|<math-up|>1<rsub|A>\<nocomma\>X|]>|\<bbb-P\><around*|(|A|)>>=<frac|\<bbb-E\><around*|[|1<rsub|A>X|]>|\<bbb-E\><around*|[|1<rsub|A>|]>>
    </equation>

    For <math|A\<in\>\<frak-A\>> with probability
    <math|\<bbb-P\><around*|(|A|)>=0> we set
    <math|\<bbb-E\><around*|[|X\|A|]>=0>.
  </definition>

  According to the last term we can interpret the conditional expectation as
  the center of mass of <math|X> on <math|A>, just like the common
  expectation <math|\<bbb-E\><around*|[|X|]>> can be thought of as the center
  of ``probability mass'' on the whole probability space.

  <big-figure|<with|gr-mode|<tuple|edit|math-at>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-arrow-end|\<gtr\>|gr-line-width|2ln|<graphics||<with|fill-color|pastel
  grey|<cspline|<point|-3.04703|2.87894>|<point|-5.33304669929885|-0.0209187723243815>|<point|-0.210676015345945|-3.30177602857521>|<point|1.80017198042069|2.0957633284826>>>|<with|fill-color|light
  grey|<cspline|<point|-2.13686|2.34977>|<point|-4.14770472284694|0.910421352030692>|<point|-3.36453234554835|-0.931092075671385>|<point|-0.655179256515412|-2.13760087313137>|<point|0.46666225691229|1.07975592009525>>>|<with|fill-color|dark
  grey|<cspline|<point|-1.96752|1.33376>|<point|-3.02586320941924|0.508251752877365>|<point|-1.26901706574944|-1.18509392776822>|<point|-0.718679719539622|0.719919962958063>>>|<with|color|brown|dash-style|11100|fill-color|brown|opacity|40%|<cspline|<point|0.974666|2.05343>|<point|-1.88285487498346|2.13809697049874>|<point|2.0753406535256|-3.74627926974468>|<point|3.00668077788067|0.910421352030692>>>|<with|fill-color|black|opacity|40%|<point|-1.75585|0.338917>>|<with|line-width|2ln|arrow-end|\<gtr\>|<spline|<point|-5.24838|3.1541>|<point|-3.63970101865326|0.952754994046832>|<point|-2.11568990607223|0.317750363804736>>>|<math-at|\<bbb-E\><around*|[|X|]>|<point|-5.75638311946025|3.429273051991>>|<math-at|A|<point|1.77901|-2.60327>>|<point|0.170327|0.31775>|<with|line-width|2ln|arrow-end|\<gtr\>|<spline|<point|2.41401|2.9001>|<point|0.614830003968779|1.88409511840191>|<point|0.0856594787670327|0.719919962958063>>>|<math-at|\<bbb-E\><around*|[|X\|A|]>|<point|2.68917846275962|2.9424361688054>>>>|A
  visualization of conditional expectation: The contour plot in grey denotes
  contour lines of the density function. The expectation value will in this
  case be near the maximum of the density function as there is a lot of
  probability mass around it. The shade in red denotes a measurable set
  (event) <math|A>. The center of mass of <math|X>'s probability distribution
  conditioned on <math|A> is depicted as well.>

  Having defined conditional expectations on specific events <math|A> by
  <math|\<bbb-E\><around*|[|X\|A|]>> we could ask ourselves if we can
  generalize that notion to collections of sets <math|A>. In probability
  theory, those are <math|\<sigma\>>-Algebras.

  Consider a common dice with six sides. We choose the probability space
  canonically: <math|\<Omega\>=<around*|{|1,2,\<ldots\>,6|}>> with elementary
  probabilities <math|\<bbb-P\><around*|(|<around*|{|1|}>|)>=\<cdots\>=
  \<bbb-P\><around*|(|<around*|{|6|}>|)>=<frac|1|6>>. As
  <math|\<sigma\>>-Algebras we take <math|\<frak-A\>=<around*|{|\<emptyset\>,<around*|{|1,2|}>,<around*|{|3,\<ldots\>,6|}>,\<Omega\>|}>>,
  a <math|\<sigma\>>-Algebra ``unable to make distinctions'' for example
  between <math|1> and <math|2>. There are two nontrivial conditional
  expectations. Denote <math|A<rsub|1>=<around*|{|1,2|}>> and
  <math|A<rsub|2>=<around*|{|3,\<ldots\>,6|}>> for brevity:

  <\eqnarray*>
    <tformat|<table|<row|<cell|\<bbb-E\><around*|[|X\|A<rsub|1>|]>>|<cell|=>|<cell|<frac|\<bbb-E\><around*|[|<math-up|>1<rsub|A<rsub|1>>\<nocomma\>X|]>|\<bbb-P\><around*|(|A<rsub|1>|)>>=<frac|<frac|1|6>\<cdot\><around*|(|1+2|)>|<frac|2|6>>=<frac|3|2>>>|<row|<cell|\<bbb-E\><around*|[|X\|A<rsub|2>|]>>|<cell|=>|<cell|<frac|\<bbb-E\><around*|[|<math-up|>1<rsub|A<rsub|2>>\<nocomma\>X|]>|\<bbb-P\><around*|(|A<rsub|2>|)>>=<frac|<frac|1|6>\<cdot\><around*|(|3+4+5+6|)>|<frac|4|6>>=<frac|9|2>>>>>
  </eqnarray*>

  The two remaining expectations are <math|\<bbb-E\><around*|[|X\|\<emptyset\>|]>=0>
  and <math|\<bbb-E\><around*|[|X\|\<Omega\>|]>=\<bbb-E\><around*|[|X|]>=<frac|7|2>>.

  This leads us to consider conditional expectations as being dependent from
  chance. Formalized, this gives rise to the following definition:

  <\definition>
    <label|def:condExpCountable>Conditional expectation with respect to a
    countable collection of events

    Let <math|<around*|(|B<rsub|i>|)><rsub|i\<in\>I>> be an <strong|at-most
    countably collection of disjoint sets>
    <math|B<rsub|i>\<subset\>\<Omega\>> with
    <math|<big|pluscup><rsub|i\<in\>I>B<rsub|i>=\<Omega\>>. We construct the
    <math|\<sigma\>>-Algebra generated by all unions and intersections of
    <math|B<rsub|i>> sets <math|\<cal-F\>\<equiv\>\<sigma\><around*|(|<around*|{|B<rsub|i>|}><rsub|i\<in\>I>|)>>.
    Consider some probability measure <math|\<bbb-P\>> to complete the
    probability space <math|<around*|(|\<Omega\>,\<cal-F\>,\<bbb-P\>|)>>.

    Let <math|X\<in\>L<rsup|1><around*|(|\<bbb-P\>|)>> be a random variable.
    We define <em|the conditional expectation of> <math|X> <em|given>
    <math|\<cal-F\>> as the <strong|random variable>

    <\equation*>
      \<bbb-E\><around*|[|X\|\<cal-F\>|]><around*|(|\<omega\>|)>=\<bbb-E\><around*|[|X\|B<rsub|i>|]><space|1em>\<Leftrightarrow\><space|1em>\<omega\>\<in\>B<rsub|i>.
    </equation*>
  </definition>

  <\lemma>
    <label|lem:regCondExp>

    The random variable from Definition <reference|def:condExpCountable> has
    the following properties:

    <\itemize>
      <item><math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>> is measurable with
      respect to <math|\<cal-F\>>.

      <item><math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>\<in\>L<rsup|1><around*|(|\<bbb-P\>|)>>
      and for every <math|A\<in\>\<cal-F\>>

      <\equation*>
        <big|int><rsub|A>\<bbb-E\><around*|[|X\|\<cal-F\>|]><math-up|d>\<bbb-P\>
        = <big|int><rsub|A>X<math-up|d>\<bbb-P\>.
      </equation*>

      In particular, <math|\<bbb-E\><around*|[|\<bbb-E\><around*|[|X\|\<cal-F\>|]>|]>=\<bbb-E\><around*|[|X|]>>
    </itemize>
  </lemma>

  <\remark>
    Measurability and the integral condition will be defining properties for
    a more general notion of conditional expectations in the next section.
    The last property can be taken as ``The mean value of all centers of
    masses of disjoint subsets is equal to the actual center of mass''.
  </remark>

  <\remark>
    <label|rem:prog>Note that we took the following order of steps on
    defining conditional probabilities:

    <\enumerate-numeric>
      <item>Define conditional expectations
      <math|\<bbb-E\><around*|[|X\|A|]>> on individual events
      <math|A\<in\>\<frak-A\>>.

      <item>Generalize to conditional expectations
      <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>> on a (certain type of)
      <math|\<sigma\>>-Algebra.
    </enumerate-numeric>

    This is a natural way of introducing conditional expectations on
    ``simple'' events as the expectations <math|\<bbb-E\><around*|[|X\|A|]>>
    are easily defined but the progression will be reversed for more general
    types of conditional expectations: The value of
    <math|\<bbb-E\><around*|[|X\|Y=y|]>> for singular events
    <math|<around*|{|Y=y|}>> needs to be derived from the notion of
    conditional expectation on <math|\<sigma\>>-Algebras.\ 

    This can lead to a lot of misunderstandings if ignored.
  </remark>

  <big-figure|<with|gr-mode|<tuple|edit|point>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-point-style|round|gr-arrow-end|\<gtr\>|gr-line-width|2ln|gr-fill-color|black|<graphics||<with|fill-color|dark
  green|<line|<point|-5.33305|-1.70962>|<point|5.6525334038894|-1.70961767429554>>>|<with|dash-style|11100|fill-color|dark
  green|opacity|40%|<cspline|<point|-4.31704|-1.03228>|<point|-4.33820611191957|-2.61979097764255>|<point|-1.94635533800767|-2.61979097764255>|<point|-1.81935441195925|-0.968778939013097>>>|<with|dash-style|11100|fill-color|dark
  green|opacity|40%|<cspline|<point|-0.358843762402434|-0.841778012964678>|<point|-0.380010583410504|-2.59862415663448>|<point|3.43001719804207|-2.59862415663448>|<point|3.51468448207435|-0.905278475988887>>>|<with|fill-color|dark
  green|<point|-1.26902|3.20108>>|<with|color|blue|dash-style|11100|<carc|<point|-2.96236|-1.49795>|<point|-2.68719407329012|-1.94245270538431>|<point|-2.59950866143422|-1.70961942129525>>>|<with|magnify|0.81791824169794|color|blue|dash-style|11100|<carc|<point|1.41792434386569|-1.43358847213136>|<point|1.7122415487612|-1.81447067252602>|<point|1.73131059493393|-1.62403135663757>>>|<with|line-width|2ln|arrow-end|\<gtr\>|color|blue|<line|<point|-2.17919|-3.42413>|<point|-2.68719407329012|-1.94245270538431>>>|<with|line-width|2ln|arrow-end|\<gtr\>|color|blue|<line|<point|0.657164|-3.33946>|<point|1.37904821944547|-1.94378331885567>>>|<with|color|blue|<math-at|\<bbb-E\><around*|[|X\|A<rsub|2>|]>=4.5|<point|9.92194734753274e-4|-3.8474665961106>>>|<with|color|blue|<math-at|\<bbb-E\><around*|[|X\|A<rsub|1>|]>=1.5|<point|-3.02586320941924|-3.88980023812674>>>|<math-at|A<rsub|1>|<point|-5.07904484720201|-2.85262600873131>>|<math-at|A<rsub|2>|<point|4.0438550072761|-2.76795872469903>>|<with|line-width|2ln|arrow-end|\<gtr\>|<line|<point|-1.26902|3.20108>|<point|-2.60252678925784|-0.206773382722582>>>|<with|line-width|2ln|arrow-end|\<gtr\>|<line|<point|-1.26902|3.20108>|<point|0.974665961105966|0.00489482735811615>>>|<math-at|\<bbb-P\><around*|(|\<omega\><rsub|2>|)>=<frac|2|3>|<point|-0.104841910305596|2.01574282312475>>|<math-at|\<bbb-P\><around*|(|\<omega\>|)>=<frac|1|3>|<point|-3.73382722582352|1.64715901574282>>|<math-at|\<Omega\>|<point|-1.35368434978172|3.64558804074613>>|<with|fill-color|black|point-style|round|<point|-3.66705|-1.70962>>|<with|fill-color|black|point-style|round|<point|-2.05485|-1.70962>>|<with|fill-color|black|point-style|round|<point|-0.286241|-1.70962>>|<with|fill-color|black|point-style|round|<point|0.947872|-1.70962>>|<with|fill-color|black|point-style|round|<point|2.10437|-1.70962>>|<with|fill-color|black|point-style|round|<point|3.51682|-1.70962>>|<math-at|4|<point|0.733248445561582|-2.17126934779733>>|<math-at|5|<point|1.92983529567403|-2.17126934779733>>|<math-at|6|<point|3.28715769281651|-2.15340984257177>>|<math-at|3|<point|-0.463338404550866|-2.18912885302289>>|<math-at|1|<point|-3.71376835560259|-2.18912885302289>>|<math-at|2|<point|-2.14213189575341|-2.13555033734621>>>>|Conditional
  expectation with respect to a <math|\<sigma\>>-Algebra as a random
  variable.>

  <section|Conditional expectation with respect to a
  <math|\<sigma\>>-Algebra>

  <subsection|Why do we need all that?>

  Consider the following example: The bias <math|B> of a bent coin is unknown
  to us, we model it by a uniform probability distribution on
  <math|<around*|[|0,1|]>>, i.e. every ``bentness parameter'' is equally
  possible. Now denote the result of the coin toss as <math|X>. What is the
  probability of seeing ``Heads'', i.e. <math|\<bbb-P\><around*|[|X=H|]>>?
  And more concretely, what is\ 

  <\equation*>
    \<bbb-P\><around*|[|X=H\|B=0.3|]>
  </equation*>

  Intuitively, the last probability needs to be <math|0.3>. We can't solve
  that problem with our current machinery, though:

  <\equation*>
    \<bbb-P\><around*|(|X=H\|B=0.3|)>=\<bbb-E\><around*|[|1<rsub|<around*|{|X=H|}>><around*|\||B=0.3|\|>|]>
  </equation*>

  Tempted to use <eqref|eq1>, we would obtain an invalid expression:
  <math|<around*|{|B=0.3|}>> is a <em|singular event> in our case, so its
  probability is <math|0>. We will derive a better notion of conditional
  expectation for singular events in the next section, but first we need
  conditional expectations on <math|\<sigma\>>-Algebras, as announced in
  Remark <reference|rem:prog>.

  <subsection|Let's dive in>

  Let <math|<around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>> be a probability
  space, <math|\<cal-F\>\<subset\>\<frak-A\>> be a <math|\<sigma\>>-Algebra
  and <math|X\<in\>L<rsup|1><around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>>.
  Following our intuition from Lemma <reference|lem:regCondExp>, we give the
  following definition:

  <\definition>
    <label|def:condExp>

    The random variable <math|Y> is called <em|conditional expectation of
    <math|X> given <math|\<cal-F\>>>, in symbols
    <math|Y=\<bbb-E\><around*|[|X\|\<cal-F\>|]>> if

    <\enumerate-roman>
      <item><math|Y> is measurable with respect to <math|\<cal-F\>> and

      <item>For every <math|A\<in\>\<cal-F\>> one has
      <math|\<bbb-E\><around*|[|1<rsub|A>X|]>=\<bbb-E\><around*|[|1<rsub|A>Y|]>>.
    </enumerate-roman>

    For <math|B\<in\>\<cal-A\>> we call <math|\<bbb-P\><around*|[|B\|\<cal-F\>|]>\<equiv\>\<bbb-E\><around*|[|1<rsub|B>\|\<cal-F\>|]>>
    the <em|conditional probability of <math|B> given <math|\<cal-F\>>>.

    For a random variable <math|Z> we call
    <math|\<bbb-E\><around*|[|X\|Z|]>\<equiv\>\<bbb-E\><around*|[|X\|\<sigma\><around*|(|Z|)>|]>>
    the conditional expectation of <math|X> given <math|Z>.
  </definition>

  <\theorem>
    <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>> exists and is unique a.s.
  </theorem>

  <\proof>
    For a proof see for example <cite|Klenke>
  </proof>

  <\remark>
    We can argue how our definition of <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>>
    fits in the framework of the last section: We were able to derive the
    quantity <math|\<bbb-E\><around*|[|X\|\<cal-G\>|]>> for
    <math|\<cal-G\>=\<sigma\><around*|(|<around*|{|B<rsub|i>|}><rsub|i\<in\>I>|)>>
    and <math|<big|pluscup><rsub|i\<in\>I>B<rsub|i>=\<Omega\>>. This
    intuitive notion of conditional expectation fulfills Definition
    <reference|def:condExp> and is by uniqueness thus identically to the more
    general version (that justifies our ``method overloading'').
  </remark>

  <\remark>
    Interpretation of conditional expectations w.r.t. a
    <math|\<sigma\>>-Algebra

    The condition <math|\<bbb-E\><around*|[|1<rsub|A>X|]>=\<bbb-E\><around*|[|1<rsub|A>\<bbb-E\><around*|[|X\|\<cal-F\>|]>|]>>
    on measurable sets <math|A\<in\>\<cal-F\>> can be interpreted as follows:
    <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>> and <math|X> carry the same
    probability mass on ``event chunks'' <math|A\<in\>\<cal-F\>>. The
    measurability criterion on the conditional expectation means: When we aks
    ourselves the question, ``What's the cause for
    <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>\<in\>M>,
    <math|M\<in\>\<cal-B\><around*|(|\<bbb-R\>|)>>?'', we get an answer
    that's only in <math|\<cal-F\>>, as

    <\equation*>
      <around*|(|\<bbb-E\><around*|[|X\|\<cal-F\>|]>|)><rsup|-1><around*|(|M|)>\<in\>\<cal-F\>
    </equation*>

    So if we interpret <math|\<cal-F\>> as being the information we have and
    can use, the conditional expectation gives us a ``guess'' on <math|X>
    with the same probability chunk but only in terms of events of
    <math|\<cal-F\>>.
  </remark>

  <\theorem>
    Properties of conditional expectation

    Let <math|<around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>> be as above,
    <math|\<cal-G\>\<subset\>\<cal-F\>\<subset\>\<frak-A\>> be
    <math|\<sigma\>>-Algebras and <math|Y\<in\>L<rsup|1><around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>>.
    Then

    <\enumerate-roman>
      <item><strong|(linearity):> <math|\<bbb-E\><around*|[|\<lambda\>X+Y\|\<cal-F\>|]>=\<lambda\>\<bbb-E\><around*|[|X\|\<cal-F\>|]>+\<bbb-E\><around*|[|Y\|\<cal-F\>|]>>.

      <item><strong|(monotonicity):> For <math|X\<geqslant\>Y> a.s.,
      <math|><math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>\<geqslant\>\<bbb-E\><around*|[|Y\|\<cal-F\>|]>>.

      <item><strong|(on measurable random variables):> For <math|Y>
      measurable w.r.t. <math|\<cal-F\>> and
      <math|\<bbb-E\><around*|[|<around*|\||XY|\|>|]>\<less\>\<infty\>>,

      <\equation*>
        \<bbb-E\><around*|[|XY\|\<cal-F\>|]>=Y\<bbb-E\><around*|[|X\|\<cal-F\>|]><space|1em><text|and><space|1em>\<bbb-E\><around*|[|Y\|\<cal-F\>|]>=\<bbb-E\><around*|[|Y\|Y|]>=Y.
      </equation*>

      <item><strong|(stacking property):>
      <math|\<bbb-E\><around*|[|\<bbb-E\><around*|[|X\|\<cal-F\>|]>\|\<cal-G\>|]>=\<bbb-E\><around*|[|\<bbb-E\><around*|[|X\|\<cal-G\>|]>\|\<cal-F\>|]>
      = \<bbb-E\><around*|[|X\|\<cal-G\>|]>>.

      <item><strong|(<math|\<vartriangle\>>-inequality):>
      <math|\<bbb-E\><around*|[|<around*|\||X|\|>\<divides\>\<cal-F\>|]>\<geqslant\><around*|\||\<bbb-E\><around*|[|X\|\<cal-F\>|]>|\<nobracket\>>>.

      <item><strong|(on independent random variables):> For <math|X>
      independent from <math|\<cal-F\>>, <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>=\<bbb-E\><around*|[|X|]>>.

      <item><strong|(on bounded convergent sequences):> For
      <math|Y\<geqslant\>0> and a sequence <math|X<rsub|n>\<rightarrow\>X>
      a.s. with <math|<around*|\||X<rsub|n>|\|>\<leqslant\>Y>,

      <\equation*>
        lim<rsub|n\<rightarrow\>\<infty\>>\<bbb-E\><around*|[|X<rsub|n>\|\<cal-F\>|]>=\<bbb-E\><around*|[|X\|\<cal-F\>|]><space|1em>a.s.<text|
        and in >L<rsup|1><around*|(|\<bbb-P\>|)>.
      </equation*>
    </enumerate-roman>
  </theorem>

  <\remark>
    Another interpretation

    Intuitively, <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>> is the best
    prediction we can make about the value of <math|X> if we only know
    information on the events in the smaller <math|\<sigma\>>-Algebra
    <math|\<cal-F\>>.\ 

    Property <em|iii.> then means that if all preimages of <math|Y> are in
    the (known) <math|\<sigma\>>-Algebra <math|\<cal-F\>>, then our guess is
    very precise, i.e. <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>=X>.\ 

    Property <em|vi.> states that if the random variable <math|X> is
    independent from our knowledge <math|\<cal-F\>>, our best guess is just
    the ordinary expectation value.
  </remark>

  For <math|L<rsup|2>>-integrable random variables we have another intuitive
  way of thinking about conditional expectations:

  <\theorem>
    <label|th:projection>Conditional expectation as a projection

    Let <math|\<cal-F\>\<subset\>\<frak-A\>> be a <math|\<sigma\>>-Algebra
    and <math|X> be a random variable with finite variance
    <math|\<bbb-E\><around*|[|X<rsup|2>|]>\<less\>\<infty\>>. Then
    <math|\<bbb-E\><around*|[|X\|\<cal-F\>|]>> is the orthogonal projection
    of <math|X> on <math|L<rsup|2><around*|(|\<Omega\>,\<cal-F\>,\<bbb-P\>|)>>.
    This means that for every <math|\<cal-F\>>-measurable <math|Y> with
    finite variance <math|\<bbb-E\><around*|[|Y<rsup|2>|]>\<less\>\<infty\>>,

    <\equation*>
      \<bbb-E\><around*|[|<around*|(|X-Y|)><rsup|2>|]>\<geqslant\>\<bbb-E\><around*|[|<around*|(|X-\<bbb-E\><around*|[|X\|\<cal-F\>|]>|)><rsup|2>|]>
    </equation*>

    with equality if and only if <math|Y=\<bbb-E\><around*|[|X\|\<cal-F\>|]>>.
  </theorem>

  <\remark>
    A last attempt on interpretation

    Theorem <reference|th:projection> thus states that conditional
    expectation is really the best guess among all
    <math|\<cal-F\>>-measurable random variables <math|Y> in the sense that
    it is the one with the smallest distance to <math|X>, if we interpret
    variance as a distance (which is legitimate given <math|L<rsup|2>> is a
    normed vector space)
  </remark>

  <big-figure|<with|gr-mode|<tuple|edit|line>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-line-width|2ln|gr-arrow-end|\<gtr\>|gr-fill-color|black|gr-dash-style|11100|<graphics||<with|line-width|5ln|<line|<point|-5.51758|-2.94533>|<point|5.73390990871808|3.19833972747718>>>|<with|arrow-end|\<gtr\>|line-width|2ln|<spline|<point|4.82308|-2.19523>|<point|5.84106694007144|-0.159247254927901>|<point|4.96595118401905|2.28750496097367>>>|<point|-4.37457|2.48396>|<math-at|L<rsup|2><around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>=<around*|{|X<rprime|'>\<in\>L<rsup|2><around*|(|\<Omega\>|)>:
  Y <text|is> \<frak-A\><text|-measurable>|}>|<point|-4.9282147109406|3.87700092604842>>|<math-at|L<rsup|2><around*|(|\<Omega\>,\<cal-F\>,\<bbb-P\>|)>=<around*|{|Y\<in\>L<rsup|2><around*|(|\<Omega\>|)>:
  Y <text|is> \<cal-F\><text|-measurable>|}>|<point|-0.40975988887419|-2.82031353353618>>|<with|dash-style|11100|line-width|2ln|<arc|<point|-2.91339|-0.110432>|<point|-3.39229726154253|-0.820048948273581>|<point|-3.2048093163937|-1.6824839813177>>>|<math-at|<frac|\<pi\>|2>|<point|-3.01724765180579|-1.01650350575473>>|<math-at|\<bbb-E\><around*|[|X\|\<cal-F\>|]>|<point|-4.16026|-3.2668>>|<with|color|dark
  blue|<point|-4.37457|2.48396>>|<with|color|dark
  blue|<math-at|X|<point|-4.60674361688054|2.73399259161265>>>|<with|color|red|arrow-end|\<gtr\>|line-width|2ln|<spline|<point|-2.84189|-3.1786>|<point|-2.19571041143008|-2.12379282973938>|<point|-2.24928892710676|-1.39155311549147>>>|<with|fill-color|black|<point|-3.92927|-2.07806>>|<with|fill-color|black|<point|-1.41269|-0.703931>>|<with|fill-color|black|<point|0.287324|0.224331>>|<with|fill-color|black|<point|2.34514|1.34796>>|<with|fill-color|black|<point|4.70066|2.63415>>|<with|color|red|fill-color|red|<point|-2.28489|-1.18018>>|<with|arrow-end|\<gtr\>|fill-color|black|dash-style|11100|line-width|2ln|<line|<point|-4.37457|2.48396>|<point|-2.28489|-1.18018>>>>>|Conditional
  expectation as a projection>

  <section|Conditional expectation with respect to singular events>

  <\lemma>
    Factorization lemma

    Let <math|<around*|(|\<Omega\>,\<frak-A\>|)>> and
    <math|<around*|(|\<Omega\><rprime|'>,\<frak-A\><rprime|'>|)>> be two
    measure spaces and <math|f:\<Omega\>\<rightarrow\>\<Omega\><rprime|'>> be
    a map.

    For any <math|g:\<Omega\>\<rightarrow\><wide|\<bbb-R\>|\<bar\>>\<equiv\>\<bbb-R\>\<cup\><around*|{|\<infty\>|}>>
    we have the following equivalence:

    <\equation*>
      g <text|is <math|\<sigma\><around*|(|f|)>>-measurable><space|1em>\<Leftrightarrow\><space|1em><text|There
      is a measurable map <math|\<varphi\>:<around*|(|\<Omega\><rprime|'>,\<frak-A\><rprime|'>|)>\<rightarrow\>>><around*|(|<wide|\<bbb-R\>|\<bar\>>,\<cal-B\><around*|(|<wide|\<bbb-R\>|\<bar\>>|)>|)>
      <text|with <math|g=\<varphi\>\<circ\>f>>
    </equation*>
  </lemma>

  <big-figure|<with|gr-mode|<tuple|edit|point>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-arrow-end|\<gtr\>|gr-line-width|2ln|gr-arrow-begin|\||<graphics||<carc|<point|-4.15165576500319|3.46790693181915>|<point|-3.13365956312463|2.80710056722066>|<point|-2.81218846906457|2.02128233729606>>|<carc|<point|4.94226320435907|3.23797949790207>|<point|5.9602594062376|2.57717313330358>|<point|6.2817305002977|1.79135490337898>>|<math-at|\<Omega\>|<point|-5.19611|3.0059>>|<math-at|\<Omega\><rprime|'>|<point|4.21585|2.80945>>|<math-at|\<bbb-R\>|<point|-2.98152864135468|-2.15549345151475>>|<with|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<line|<point|-3.35658|-3.15563>|<point|3.4657527450721|-3.11990673369493>>>|<with|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<spline|<point|-4.57102|1.595>|<point|-2.15999140097897|-0.476699960312211>|<point|-0.552635930678661|-2.69127860828152>>>|<with|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<spline|<point|-4.26741|2.3451>|<point|-0.784809498610927|0.237680248710147>|<point|0.858264982140495|-2.76271662918375>>>|<with|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<spline|<point|-4.23169|2.59513>|<point|-0.159726815716365|2.68443246461172>|<point|4.32300899589893|2.07720928694272>>>|<with|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<spline|<point|4.60876|1.57714>|<point|3.1621411562376|-0.798171054372271>|<point|1.21545508665167|-2.88773316576267>>>|<math-at|\<omega\><rsub|1>|<point|-5.12467|2.55942>>|<math-at|\<omega\><rsub|2>|<point|-5.30326|1.98791>>|<math-at|\<omega\><rprime|'>|<point|4.93023217356793|2.14864730784495>>|<math-at|r<rsub|1>|<point|-0.320462|-3.61997>>|<math-at|r<rsub|2>|<point|0.786827|-3.54853>>|<math-at|f|<point|-0.302603|3.23808>>|<math-at|g|<point|-2.78507|-0.691014>>|<math-at|\<varphi\>|<point|3.53719|-1.36968>>|<with|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<spline|<point|-4.55316510120386|1.77359769810822>|<point|0.00100873131366583|1.32711006746924>|<point|4.35872800635005|1.82717621378489>>>|<point|-4.46387|2.53501>|<point|-4.82552|1.81973>|<point|4.64448|1.9635>|<point|-0.482277|-3.14058>|<point|1.03301262058316|-3.13264510729316>>>|A
  counterexample for the Factorization Lemma: Assume
  <math|\<Omega\>=<around*|{|\<omega\><rsub|1>\<nocomma\>,\<omega\><rsub|2>|}>>
  and <math|\<Omega\><rprime|'>=<around*|{|\<omega\>|}>>. Choose standard
  <math|\<sigma\>>-Algebras <math|\<frak-A\>=\<cal-P\><around*|(|\<Omega\>|)>>,
  <math|\<frak-A\><rprime|'>=\<cal-P\><around*|(|\<Omega\><rprime|'>|)>> and
  <math|\<cal-B\><around*|(|\<bbb-R\>|)>>. This set of mappings does not
  fulfill the requirements of the Factorization Lemma: The concatenation
  <math|\<varphi\>\<circ\>f> is not equal to <math|g>, as
  <math|\<varphi\>\<circ\>f<around*|(|\<omega\><rsub|2>|)>=\<varphi\><around*|(|\<omega\><rprime|'>|)>=r<rsub|2>>,
  whereas <math|g<around*|(|\<omega\><rsub|2>|)>=r<rsub|1>>. This is due to
  the fact that <math|g> is not <math|\<sigma\><around*|(|f|)>>-measurable:
  <math|\<sigma\><around*|(|f|)>=<around*|{|f<rsup|-1><around*|(|A<rprime|'>|)>\|A<rprime|'>\<in\>\<frak-A\><rprime|'>|}>=<around*|{|\<emptyset\>,<around*|{|\<omega\><rsub|1>,\<omega\><rsub|2>|}>|}>>.
  Now for small <math|\<varepsilon\>>, the set
  <math|R=<around*|(|r<rsub|1>-\<varepsilon\>,r<rsub|1>+\<varepsilon\>|)>> is
  open but <math|g<rsup|-1><around*|(|R|)>=<around*|{|\<omega\><rsub|1>|}>\<nin\>\<sigma\><around*|(|f|)>>.
  Intuitively, the problem is that <math|g> and <math|f> ``cluster'' events
  in <math|\<Omega\>> differently: For <math|g>, both single events have
  different results whereas <math|f> groups them together.>

  Existence of conditional expectations w.r.t. a singular event can be proven
  (non-constructivistically) by this lemma:

  Assume <math|X:<around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>\<rightarrow\><around*|(|E,\<cal-E\>|)>>
  is a random variable into an measurable space <math|E> and
  <math|Z=\<bbb-E\><around*|[|Y\|\<sigma\><around*|(|X|)>|]>:<around*|(|\<Omega\>,\<frak-A\>,\<bbb-P\>|)>\<rightarrow\>\<bbb-R\>>
  be the conditional expectation of a random variable <math|Y>. According to
  the factorization lemma, there exists a map
  <math|\<varphi\>:E\<rightarrow\>\<bbb-R\>> such that <math|\<varphi\>> is
  <math|<around*|(|\<cal-E\>,\<cal-B\><around*|(|\<bbb-R\>|)>|)>>-measurable
  and <math|\<varphi\><around*|(|X|)>=\<bbb-E\><around*|[|Y\|\<sigma\><around*|(|X|)>|]>>.
  If <math|X> is surjective, <math|\<varphi\>> is uniquely defined. In this
  case we write <math|\<varphi\>\<equiv\>Z\<circ\>X<rsup|-1>>, for
  <math|Z\<equiv\>\<bbb-E\><around*|[|Y\|\<sigma\><around*|(|X|)>|]>> even
  though the inverse of <math|X> doesn't exist.

  <\definition>
    <label|def:condExp2>Conditional expectation with respect to a continous
    random variable's results

    Let <math|Y\<in\>L<rsup|1><around*|(|\<bbb-P\>|)>> and
    <math|X:<around*|(|\<Omega\>,\<frak-A\>|)>\<rightarrow\><around*|(|E,\<cal-E\>|)>>.
    Then we call the function <math|\<varphi\>> from above for
    <math|Z=\<bbb-E\><around*|[|Y\|X|]>> as the <em|conditional expectation
    of <math|Y> given <math|X=x>>, in terms
    <math|\<bbb-E\><around*|[|Y\|X=x|]>>. By analogy, we write
    <math|\<bbb-P\><around*|(|A\|X=x|)>=\<bbb-E\><around*|[|1<rsub|A>\|X=x|]>>
    for <math|A\<in\>\<frak-A\>>.\ 

    This means that <math|\<bbb-E\><around*|[|Y\|X=x|]>\<equiv\>\<bbb-E\><around*|[|Y\|X|]><around*|(|<around*|{|X=x|}>|)>>.

    Beware that <math|\<varphi\>=Z\<circ\>X<rsup|-1>> only a.e. The exception
    set for this equality depends on the function <math|Y> or, in the
    conditional probability case, on the set <math|A>.
  </definition>

  <\remark>
    Why can we reasonably call <math|\<varphi\>> by
    <math|\<bbb-E\><around*|[|Y\|X=\<cdummy\>|]>>? In the regular case
    (discrete <math|X>), the construction is parallel to the regular
    <math|\<bbb-E\><around*|[|Y\|X=\<cdummy\>|]>> (see Definition
    <reference|def:condExpCountable>) and for the irregular case (continous
    <math|X>), this mapping extracts the right portion out of
    <math|\<bbb-E\><around*|[|Y\|X|]>>.
  </remark>

  <\remark>
    <label|rem:as>We note that the conditional expectation
    <math|\<bbb-E\><around*|[|Y\|X=\<cdummy\>|]>> is not defined on a set of
    measure <math|0>, i.e. <math|\<bbb-E\><around*|[|Y\|X=x|]>> makes only
    sense for a.s. all <math|x\<in\>E> where the exception set is dependent
    of <math|Y>.
  </remark>

  <big-figure|<with|gr-mode|<tuple|edit|point>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-arrow-end|\<gtr\>|gr-point-style|round|gr-line-width|2ln|gr-arrow-begin|\||gr-fill-color|black|<graphics||<with|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<line|<point|-2.82079|-2.13798>|<point|4.37658751157561|-2.10226220399524>>>|<carc|<point|4.53732|3.63064>|<point|6.1625380341315|2.45191162852229>|<point|4.69805860563567|0.665961105966398>>|<math-at|X|<point|0.233182299245932|3.80923402566477>>|<with|opacity|30%|fill-color|dark
  green|<cspline|<point|-4.69604|2.39833>|<point|-4.78533866913613|1.09458923137981>|<point|-4.01737994443709|1.55893636724434>>>|<carc|<point|-5.10681|3.07699>|<point|-3.01724765180579|1.04101071570314>|<point|-4.30313202804604|0.594523085064162>>|<with|opacity|30%|fill-color|dark
  green|<cspline|<point|-4.73176|2.73766>|<point|-4.21383450191824|2.3626141023945>|<point|-4.03523944966265|2.70194470168012>|<point|-4.58888411165498|3.0591348061913>>>|<with|opacity|30%|fill-color|dark
  green|<cspline|<point|-4.26741|0.898135>|<point|-3.94594192353486|1.07672972615425>|<point|-3.39229726154253|1.21960576795872>|<point|-3.78520637650483|0.808837147770869>>>|<with|arrow-end|\|\<gtr\>|<spline|<point|-5.92835|0.665961>|<point|-5.71403294086519|1.34462230453764>|<point|-4.80319817436169|1.71967191427437>>>|<with|arrow-end|\|\<gtr\>|<spline|<point|-6.26768|0.71954>|<point|-6.19623958195529|1.64823389337214>|<point|-4.73176|2.73765999999999>>>|<with|arrow-end|\|\<gtr\>|<spline|<point|-5.30326|0.683821>|<point|-4.78533866913612|1.09458923137981>|<point|-3.94594192353486|1.07672972615425>>>|<math-at|<around*|(|\<Omega\>,\<sigma\><around*|(|X|)>|)>\<subset\><around*|(|\<Omega\>,\<frak-A\>|)>|<point|-4.51744609075275|3.77351501521365>>|<math-at|\<sigma\><around*|(|X|)>=<around*|{|X<rsup|-1><around*|(|B|)>,B\<in\>\<cal-E\>|}>|<point|-6.67844622304538|0.201613970101865>>|<math-at|<around*|(|E,\<cal-E\>|)>|<point|3.87652136525996|3.98782907792036>>|black|<with|color|black|opacity|40%|fill-color|blue|<cspline|<point|-3.53517|2.91626>|<point|-3.91022291308374|2.11258102923667>|<point|-3.41015676676809|1.45177933589099>|<point|-2.91009062045244|2.25545707104114>>>|<with|color|black|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<spline|<point|-3.42802|2.54121>|<point|-0.2311648366186|3.29130837412356>|<point|4.18759095118402|1.86704590554306>>>|<with|color|black|<math-at|<around*|{|X=x|}>\<in\>\<sigma\><around*|(|X|)>|<point|-2.10641288530229|1.68395290382326>>>|<with|color|black|<math-at|\<bbb-R\>|<point|0.42963685672708|-2.79878290779204>>>|<with|color|black|<math-at|\<bbb-E\><around*|[|Y\|X|]>|<point|-2.30286744278344|-0.744939806852758>>>|<with|color|black|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<spline|<point|-3.41016|1.91613>|<point|0.197463288794814|-0.227014155311549>|<point|1.62622370683953|-1.90580764651409>>>|<with|color|black|<math-at|\<bbb-E\><around*|[|Y\|X|]><around*|(|<around*|{|X=x|}>|)>=\<bbb-E\>
  <around*|[|Y\|X=x|]>|<point|0.447496361952639|-3.85249371610001>>>|<with|color|black|arrow-end|\|\<gtr\>|fill-color|black|<spline|<point|1.66262|-3.47035>|<point|1.62622370683953|-2.38801428760418>>>|<with|arrow-end|\<gtr\>|line-width|2ln|<spline|<point|-2.83865259955021|3.30916787934912>|<point|0.215322794020373|3.61277946818362>|<point|3.12642214578648|2.9698372800635>>>|<with|color|black|arrow-end|\<gtr\>|line-width|2ln|<spline|<point|3.85771927503638|0.565865193808705>|<point|3.3764552189443|-0.54848524937161>|<point|2.82281055695198|-1.56647704722847>>>|<with|color|black|<math-at|\<bbb-E\><around*|[|Y\|X=\<cdummy\>|]>|<point|4.01939740706443|-0.512766238920492>>>|<with|color|black|arrow-end|\<gtr\>|line-width|2ln|<spline|<point|-2.85524|0.604809>|<point|-0.945545045640958|-0.119857123958196>|<point|-0.0168507739118931|-1.54861754200291>>>|<with|color|black|arrow-end|\<gtr\>|line-width|2ln|arrow-begin|\||<spline|<point|4.28729|1.4875>|<point|2.78709154650086|0.433787538034132>|<point|1.87625677999735|-1.7272125942585>>>|<with|fill-color|black|point-style|round|<point|4.48374|1.7074>>|<with|fill-color|black|point-style|round|<point|1.67833|-2.11565>>>>|Conditional
  expectation w.r.t. singular events as concatenation of cond. exp. w.r.t. a
  random variable's <math|\<sigma\>>-Algebra <math|\<sigma\><around*|(|X|)>>
  and the inverse image of <math|X>.>

  Why aren't we done? The factorization lemma yields a function (later called
  <math|\<bbb-E\><around*|[|Y\|X=\<cdummy\>|]>>) for every random variable
  <math|Y>. If we're only interested in single expectations, we're done. The
  definition of <math|\<bbb-P\><around*|(|A\|X=x|)>> carries a hidden
  pitfall, though: The conditional probability of <math|A> given <math|X=x>
  is defined via the conditional expectation of <math|1<rsub|A>> given
  <math|X=x>. In remark <reference|rem:as> we saw that the exception set of
  the definition of conditional expectations is dependent of the function
  <math|Y>. Hence, the definition of <math|\<bbb-P\><around*|(|A\|X=x|)>>
  makes only sense for a <math|A>-dependent subset of <math|x>'s. For
  different <math|A> we might fear that the exception sets amount to more
  than a set of measure <math|0>, so we can't define a ``joint measure''
  <math|\<bbb-P\><around*|(|\<cdummy\>\|X=x|)>> but for a set of <math|x>'s
  of measure <math|0>. Thus, if we want to work with conditional
  probabilities, we first have to show that this cannot happen.

  <section|Regular Version of Conditional Probability>

  Intuitively, the problem is the ``disconnectedness'' of
  <math|<around*|(|\<Omega\>,\<frak-A\>|)>> and
  <math|<around*|(|E,\<cal-E\>|)>>. Our definition of conditional
  expectations <math|\<bbb-E\><around*|[|1<rsub|A>\|X=x|]>> is non-uniform
  over the range of possible sets <math|A\<in\>\<frak-A\>>. The next
  definition incorporates the correct notion for making that connection
  uniformly:

  <\definition>
    Markov Kernel

    For <math|<around*|(|\<Omega\><rsub|1>,\<frak-A\><rsub|1>|)>> and
    <math|<around*|(|\<Omega\><rsub|2>,\<frak-A\><rsub|2>|)>> measurable
    spaces we call a mapping <math|\<kappa\>:\<Omega\><rsub|1>\<times\>\<frak-A\><rsub|2>\<rightarrow\><around*|[|0,\<infty\>|]>>
    a <em|Markov Kernel from <math|\<Omega\><rsub|1>> to
    <math|\<Omega\><rsub|2>>>, if

    <\enumerate-roman>
      <item><math|\<omega\><rsub|1>\<mapsto\>\<kappa\><around*|(|\<omega\><rsub|1>,A<rsub|2>|)>>
      is <math|\<frak-A\><rsub|1>>-measurable for every
      <math|A<rsub|2>\<in\>\<frak-A\><rsub|2>>,

      <item><math|A<rsub|2>\<mapsto\>\<kappa\><around*|(|\<omega\><rsub|1>,A<rsub|2>|)>>
      is a probability measure on <math|<around*|(|\<Omega\><rsub|2>,\<frak-A\><rsub|2>|)>>
      for every <math|\<omega\><rsub|1>\<in\>\<Omega\><rsub|1>>.
    </enumerate-roman>
  </definition>

  <\definition>
    <label|def:condProb2>Regular Version of Conditional Probability

    Let <math|Y:<around*|(|\<Omega\>,\<frak-A\>|)>\<rightarrow\><around*|(|E,\<cal-E\>|)>>
    be a random variable and <math|\<cal-F\>\<subset\>\<frak-A\>> be a
    sub-<math|\<sigma\>>-Algebra. Assume we have a stochastic kernel
    <math|\<kappa\><rsub|Y,\<cal-F\>>> from
    <math|<around*|(|\<Omega\>,\<cal-F\>|)>> to
    <math|<around*|(|E,\<cal-E\>|)>> fulfilling

    <\equation*>
      <big|int>1<rsub|B><around*|(|Y|)>\<cdot\>1<rsub|A><math-up|d>\<bbb-P\>
      = <big|int>\<kappa\><rsub|Y,\<cal-F\>><around*|(|\<cdummy\>,B|)>\<cdot\>1<rsub|A><math-up|d>\<bbb-P\>
      <text| for every <math|A\<in\>\<cal-F\>> and <math|B\<in\>\<cal-E\>>>,
    </equation*>

    i.e. <math|\<kappa\><rsub|Y,\<cal-F\>><around*|(|\<omega\>,B|)>=\<bbb-P\><around*|(|<around*|{|Y\<in\>B|}>\|\<cal-F\>|)><around*|(|\<omega\>|)>>
    for <math|\<bbb-P\>>-a.s. <math|\<omega\>\<in\>\<Omega\>> and every
    <math|B\<in\>\<cal-E\>>.

    Then we call <math|\<kappa\><rsub|Y,\<cal-F\>>> a <em|regular version of
    the conditional probability of <math|Y> given <math|\<cal-F\>>>.

    For <math|\<cal-F\>=\<sigma\><around*|(|X|)>> for some random variable
    <math|X>, we call <math|\<kappa\><rsub|Y,\<cal-F\>>=\<kappa\><rsub|Y,\<sigma\><around*|(|X|)>>>
    a regular version of the conditional probability of <math|Y> given
    <math|X>.
  </definition>

  <\remark>
    This means that <math|\<kappa\><rsub|Y,\<cal-F\>>> is a conditional
    probability in the sense of definition <reference|def:condExp2> but also
    regular in the sense that there is a ``good'' correspondence between
    target sets of <math|Y> and events <math|\<omega\>>, also
    <math|\<bbb-P\><around*|(|<around*|{|Y\<in\>B|}>\|\<cal-F\>|)>> is now a
    probability measure for sets of the type <math|<around*|{|Y\<in\>B|}>>
    for almost all <math|\<omega\>\<in\>\<Omega\>> (see the definition of
    Markov Kernels).
  </remark>

  <\theorem>
    Existence of regular versions of conditional probabilities

    For <math|Y:<around*|(|\<Omega\>,\<frak-A\>|)>\<rightarrow\><around*|(|\<bbb-R\>,\<cal-B\><around*|(|\<bbb-R\>|)>|)>>
    a real-valued random variable, there is a regular version of the
    conditional probability distribution <math|\<bbb-P\><around*|(|<around*|{|Y\<in\>\<cdummy\>|}>\|\<cal-F\>|)>>.
  </theorem>

  <\proof>
    See <cite|Klenke>.
  </proof>

  <\example>
    Most important example: Conditional densities

    Let <math|X,Y> be real random variables with joint probability density
    <math|f>, i.e. <math|\<bbb-P\><around*|(|X\<in\>A,Y\<in\>B|)>=<big|int><rsub|A\<times\>B>f<around*|(|x,y|)>
    <math-up|d><around*|(|x,y|)>>. The marginalization
    <math|<big|int><rsub|\<bbb-R\>>f<around*|(|x,y|)><math-up|d>y=f<rsub|X><around*|(|x|)>>
    is the density of <math|X>. Then the regular version of the conditional
    probability of <math|Y> given <math|X> has a density given by

    <\equation*>
      f<rsub|Y\|X><around*|(|x,y|)>\<equiv\><frac|f<around*|(|x,y|)>|f<rsub|X><around*|(|x|)>>.
    </equation*>

    As a symbol we also write <math|f<rsub|Y\|X><around*|(|x,y|)> =
    <frac|\<bbb-P\><around*|(|Y\<in\><math-up|d>y\|X=x|)>|<math-up|d>y>>.
  </example>

  <\proof>
    We need to show that <math|\<bbb-P\><around*|(|<around*|{|Y\<in\>B|}>\|X=x|)>=<big|int><rsub|B>f<rsub|Y\|X><around*|(|y,x|)><math-up|d>y>
    in the sense of definition <reference|def:condProb2>: Measurability
    of<math|<big|int><rsub|B>f<rsub|Y\|X><around*|(|y,x|)><math-up|d>y> is
    obtained by Fubini and

    <\eqnarray*>
      <tformat|<table|<row|<cell|<big|int><rsub|A>\<bbb-P\><around*|(|<around*|{|Y\<in\>B|}>\|X=x|)>
      \<bbb-P\><around*|(|X\<in\><math-up|d>x|)>>|<cell|=>|<cell|<big|int><rsub|A><big|int><rsub|B>f<rsub|Y\|X><around*|(|x,y|)><math-up|d>y
      \<bbb-P\><around*|(|X\<in\><math-up|d>x|)>>>|<row|<cell|>|<cell|=>|<cell|<big|int><rsub|A><big|int><rsub|B>f<around*|(|x,y|)><math-up|d>y
      <frac|\<bbb-P\><around*|(|X\<in\><math-up|d>x|)>|f<rsub|X><around*|(|x|)>>>>|<row|<cell|>|<cell|=>|<cell|<big|int><rsub|A><big|int><rsub|B>f<around*|(|x,y|)><math-up|d>y<math-up|d>x>>|<row|<cell|>|<cell|=>|<cell|<big|int><rsub|A>1<rsub|B><around*|(|Y|)><math-up|d>x>>|<row|<cell|>|<cell|=>|<cell|\<bbb-P\><around*|(|X\<in\>A,Y\<in\>B|)>>>>>
    </eqnarray*>

    where the penultimate equality already constitutes the definition of the
    regular version of conditional probability.
  </proof>

  <\bibliography|bib|tm-plain|Bib.bib>
    <\bib-list|1>
      <bibitem*|1><label|bib-Klenke>Achim<nbsp>Klenke.<newblock>
      <with|font-shape|italic|Probability Theory - A Comprehensive
      Course>.<newblock> Springer, 2014.<newblock>
    </bib-list>
  </bibliography>
</body>

<\initial>
  <\collection>
    <associate|preamble|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate||<tuple|1|?|..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_3.tm>>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|5|7>>
    <associate|auto-11|<tuple|4|7>>
    <associate|auto-12|<tuple|24|8>>
    <associate|auto-2|<tuple|1|2>>
    <associate|auto-3|<tuple|2|3>>
    <associate|auto-4|<tuple|2|3>>
    <associate|auto-5|<tuple|2.1|3>>
    <associate|auto-6|<tuple|2.2|4>>
    <associate|auto-7|<tuple|3|5>>
    <associate|auto-8|<tuple|3|6>>
    <associate|auto-9|<tuple|4|6>>
    <associate|bib-Klenke|<tuple|1|8>>
    <associate|def:condExp|<tuple|8|4>>
    <associate|def:condExp2|<tuple|17|6>>
    <associate|def:condExpCountable|<tuple|4|2>>
    <associate|def:condProb2|<tuple|21|8>>
    <associate|eq1|<tuple|1|1>>
    <associate|eq:condExp1|<tuple|1|?|..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_3.tm>>
    <associate|lem:regCondExp|<tuple|5|2>>
    <associate|rem:as|<tuple|19|7>>
    <associate|rem:prog|<tuple|7|3>>
    <associate|th:projection|<tuple|14|5>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|bib>
      Klenke

      Klenke

      Klenke
    </associate>
    <\associate|figure>
      <tuple|normal|A visualization of conditional expectation: The contour
      plot in grey denotes contour lines of the density function. The
      expectation value will in this case be near the maximum of the density
      function as there is a lot of probability mass around it. The shade in
      red denotes a measurable set (event) <with|mode|<quote|math>|A>. The
      center of mass of <with|mode|<quote|math>|X>'s probability distribution
      conditioned on <with|mode|<quote|math>|A> is depicted as
      well.|<pageref|auto-2>>

      <tuple|normal|Conditional expectation with respect to a
      <with|mode|<quote|math>|\<sigma\>>-Algebra as a random
      variable.|<pageref|auto-3>>

      <tuple|normal|Conditional expectation as a projection|<pageref|auto-7>>

      <tuple|normal|A counterexample for the Factorization Lemma: Assume
      <with|mode|<quote|math>|\<Omega\>=<around*|{|\<omega\><rsub|1>\<nocomma\>,\<omega\><rsub|2>|}>>
      and <with|mode|<quote|math>|\<Omega\><rprime|'>=<around*|{|\<omega\>|}>>.
      Choose standard <with|mode|<quote|math>|\<sigma\>>-Algebras
      <with|mode|<quote|math>|\<frak-A\>=\<cal-P\><around*|(|\<Omega\>|)>>,
      <with|mode|<quote|math>|\<frak-A\><rprime|'>=\<cal-P\><around*|(|\<Omega\><rprime|'>|)>>
      and <with|mode|<quote|math>|\<cal-B\><around*|(|\<bbb-R\>|)>>. This set
      of mappings does not fulfill the requirements of the Factorization
      Lemma: The concatenation <with|mode|<quote|math>|\<varphi\>\<circ\>f>
      is not equal to <with|mode|<quote|math>|g>, as
      <with|mode|<quote|math>|\<varphi\>\<circ\>f<around*|(|\<omega\><rsub|2>|)>=\<varphi\><around*|(|\<omega\><rprime|'>|)>=r<rsub|2>>,
      whereas <with|mode|<quote|math>|g<around*|(|\<omega\><rsub|2>|)>=r<rsub|1>>.
      This is due to the fact that <with|mode|<quote|math>|g> is not
      <with|mode|<quote|math>|\<sigma\><around*|(|f|)>>-measurable:
      <with|mode|<quote|math>|\<sigma\><around*|(|f|)>=<around*|{|f<rsup|-1><around*|(|A<rprime|'>|)>\|A<rprime|'>\<in\>\<frak-A\><rprime|'>|}>=<around*|{|\<emptyset\>,<around*|{|\<omega\><rsub|1>,\<omega\><rsub|2>|}>|}>>.
      Now for small <with|mode|<quote|math>|\<varepsilon\>>, the set
      <with|mode|<quote|math>|R=<around*|(|r<rsub|1>-\<varepsilon\>,r<rsub|1>+\<varepsilon\>|)>>
      is open but <with|mode|<quote|math>|g<rsup|-1><around*|(|R|)>=<around*|{|\<omega\><rsub|1>|}>\<nin\>\<sigma\><around*|(|f|)>>.
      Intuitively, the problem is that <with|mode|<quote|math>|g> and
      <with|mode|<quote|math>|f> ``cluster'' events in
      <with|mode|<quote|math>|\<Omega\>> differently: For
      <with|mode|<quote|math>|g>, both single events have different results
      whereas <with|mode|<quote|math>|f> groups them
      together.|<pageref|auto-9>>

      <tuple|normal|Conditional expectation w.r.t. singular events as
      concatenation of cond. exp. w.r.t. a random variable's
      <with|mode|<quote|math>|\<sigma\>>-Algebra
      <with|mode|<quote|math>|\<sigma\><around*|(|X|)>> and the inverse image
      of <with|mode|<quote|math>|X>.|<pageref|auto-10>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Revision
      of basic theory: Conditioning on regular events and
      <with|mode|<quote|math>|\<sigma\>>-Algebras of simplest type>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Conditional
      expectation with respect to a <with|mode|<quote|math>|\<sigma\>>-Algebra>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Why do we need all that?
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Let's dive in
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Conditional
      expectation with respect to singular events>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Regular
      Version of Conditional Probability>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Bibliography>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>