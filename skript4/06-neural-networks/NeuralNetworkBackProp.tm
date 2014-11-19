<TeXmacs|1.99.2>

<style|<tuple|generic|american>>

<\body>
  <section|Definition of our Neural Network>

  Consider the following network: The input consists of <math|D<rsub|I>>
  dimensions, there is one hidden layer with dimension <math|D<rsub|H>> and
  the output has dimension <math|D<rsub|O>>. Given two matrices
  <math|\<Theta\><rsup|<around*|(|1|)>>\<in\>\<bbb-R\><rsup|<around*|(|D<rsub|I>+1|)>\<times\>D<rsub|H>>>
  and <math|\<Theta\><rsup|<around*|(|2|)>>\<in\>\<bbb-R\><rsup|<around*|(|D<rsub|H>+1|)>\<times\>D<rsub|O>>>,
  the forward propagation of an input vector
  <math|x\<in\>\<bbb-R\><rsup|D<rsub|I>>> (a column vector) works in the
  following way:

  <\eqnarray*>
    <tformat|<table|<row|<cell|a<rsup|<around*|(|1|)>>>|<cell|=>|<cell|<around*|(|\<Theta\><rsup|<around*|(|1|)>>|)><rsup|\<Tau\>>\<cdot\><matrix|<tformat|<table|<row|<cell|1>>|<row|<cell|x>>>>><hspace|1em>\<in\>\<bbb-R\><rsup|D<rsub|H>>>>|<row|<cell|z>|<cell|=>|<cell|\<sigma\><around*|(|a<rsup|<around*|(|1|)>>|)><hspace|1em>\<in\>\<bbb-R\><rsup|D<rsub|H>>>>|<row|<cell|a<rsup|<around*|(|2|)>>>|<cell|=>|<cell|<around*|(|\<Theta\><rsup|<around*|(|2|)>>|)><rsup|\<Tau\>>\<cdot\><matrix|<tformat|<table|<row|<cell|1>>|<row|<cell|z>>>>><hspace|1em>\<in\>\<bbb-R\><rsup|D<rsub|O>>>>|<row|<cell|y>|<cell|=>|<cell|\<sigma\><around*|(|a<rsup|<around*|(|2|)>>|)><hspace|1em>\<in\>\<bbb-R\><rsup|D<rsub|O>>>>>>
  </eqnarray*>

  For training purposes (and for computational issues) we will want to
  propagate multiple input vectors <math|x<rsub|1>,x<rsub|2>,\<ldots\>,x<rsub|M>>
  with every <math|x<rsub|m>\<in\>\<bbb-R\><rsup|D<rsub|I>>> at the same
  time. We collect them into a big input matrix

  <\equation*>
    X = <around*|(|x<rsub|1>,x<rsub|2>,\<ldots\>,x<rsub|M>|)>\<in\>\<bbb-R\><rsup|D<rsub|I>\<times\>M>
  </equation*>

  Each column represents a different input sample, each row contains an input
  feature (for example a pixel in a scanned image). Forward propagation then
  looks as follows:

  <\eqnarray*>
    <tformat|<table|<row|<cell|A<rsup|<around*|(|1|)>>>|<cell|=>|<cell|<around*|(|\<Theta\><rsup|<around*|(|1|)>>|)><rsup|\<Tau\>>\<cdot\><matrix|<tformat|<table|<row|<cell|1>>|<row|<cell|X>>>>><hspace|1em>\<in\>\<bbb-R\><rsup|D<rsub|H>\<times\>M>>>|<row|<cell|Z>|<cell|=>|<cell|\<sigma\><around*|(|A<rsup|<around*|(|1|)>>|)><hspace|1em>\<in\>\<bbb-R\><rsup|D<rsub|H>\<times\>M>>>|<row|<cell|A<rsup|<around*|(|2|)>>>|<cell|=>|<cell|<around*|(|\<Theta\><rsup|<around*|(|2|)>>|)><rsup|\<Tau\>>\<cdot\><matrix|<tformat|<table|<row|<cell|1>>|<row|<cell|Z>>>>><hspace|1em>\<in\>\<bbb-R\><rsup|D<rsub|O>\<times\>M>>>|<row|<cell|Y>|<cell|=>|<cell|\<sigma\><around*|(|A<rsup|<around*|(|2|)>>|)><hspace|1em>\<in\>\<bbb-R\><rsup|D<rsub|O>\<times\>M>>>>>
  </eqnarray*>

  where <math|\<sigma\>> is the sigmoid function
  <math|\<sigma\><around*|(|a|)>=<frac|1|1+exp<around*|(|-a|)>>>

  So in short

  <\equation*>
    Y = \<sigma\><around*|{|<around*|(|\<Theta\><rsup|<around*|(|2|)>>|)><rsup|\<Tau\>>\<cdot\><matrix|<tformat|<table|<row|<cell|1>>|<row|<cell|\<sigma\><around*|[|<around*|(|\<Theta\><rsup|<around*|(|1|)>>|)><rsup|\<Tau\>>\<cdot\><matrix|<tformat|<table|<row|<cell|1>>|<row|<cell|X>>>>>|]>>>>>>|}>
  </equation*>

  The ones of course represent rows containing <math|M> ones to match
  <math|X> and <math|Z>. For easier calculation we collect the following
  submatrix definitions:

  <\eqnarray*>
    <tformat|<table|<row|<cell|\<Theta\><rsup|<around*|(|1|)>>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|\<Theta\><rsub|0><rsup|<around*|(|1|)>>>>|<row|<cell|\<vdots\>>>|<row|<cell|\<Theta\><rsub|D<rsub|I>><rsup|<around*|(|1|)>>>>>>>\<nocomma\><text|,
    where ><around*|(|\<Theta\><rsub|j><rsup|<around*|(|1|)>>|)><rsup|\<Tau\>>\<in\>\<bbb-R\><rsup|D<rsub|H>>>>|<row|<cell|\<Theta\><rsup|<around*|(|2|)>>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|\<Theta\><rsub|0><rsup|<around*|(|2|)>>>>|<row|<cell|\<vdots\>>>|<row|<cell|\<Theta\><rsub|D<rsub|H>><rsup|<around*|(|2|)>>>>>>>\<nocomma\><text|,
    where ><around*|(|\<Theta\><rsub|j><rsup|<around*|(|2|)>>|)><rsup|\<Tau\>>\<in\>\<bbb-R\><rsup|D<rsub|O>>>>|<row|<cell|X>|<cell|=>|<cell|<around*|(|X<rsub|1>,\<ldots\>,X<rsub|M>|)>>>|<row|<cell|X<rsub|m>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|X<rsub|1,m>>>|<row|<cell|\<vdots\>>>|<row|<cell|X<rsub|D<rsub|I>,m>>>>>>>>|<row|<cell|Z>|<cell|=>|<cell|<around*|(|Z<rsub|1>,\<ldots\>,Z<rsub|M>|)>>>|<row|<cell|Z<rsub|m>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|Z<rsub|1,m>>>|<row|<cell|\<vdots\>>>|<row|<cell|Z<rsub|D<rsub|H>,m>>>>>>>>|<row|<cell|Y>|<cell|=>|<cell|<around*|(|Y<rsub|1>,\<ldots\>,Y<rsub|M>|)>>>|<row|<cell|Y<rsub|m>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|Y<rsub|1,m>>>|<row|<cell|\<vdots\>>>|<row|<cell|Y<rsub|D<rsub|O>,m>>>>>>>>|<row|<cell|A<rsup|<around*|(|1|)>>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|A<rsub|1><rsup|<around*|(|1|)>>,\<ldots\>,A<rsub|M><rsup|<around*|(|1|)>>>>>>>>>|<row|<cell|A<rsub|m><rsup|<around*|(|1|)>>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|A<rsub|1,m><rsup|<around*|(|1|)>>>>|<row|<cell|\<vdots\>>>|<row|<cell|A<rsub|D<rsub|H>,m><rsup|<around*|(|1|)>>>>>>>>>|<row|<cell|A<rsup|<around*|(|2|)>>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|A<rsub|1><rsup|<around*|(|2|)>>,\<ldots\>,A<rsub|M><rsup|<around*|(|2|)>>>>>>>>>|<row|<cell|A<rsub|m><rsup|<around*|(|2|)>>>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|A<rsub|1,m><rsup|<around*|(|2|)>>>>|<row|<cell|\<vdots\>>>|<row|<cell|A<rsub|D<rsub|O>,m><rsup|<around*|(|2|)>>>>>>>>>>>
  </eqnarray*>

  \;

  We will stick to the convention, that the summing indices are as follows:

  <\itemize-dot>
    <item><math|i=<around*|(|0,|)>1,\<ldots\>,D<rsub|I>>

    <item><math|j=<around*|(|0,|)>1,\<ldots\>,D<rsub|H>>

    <item><math|k=1,\<ldots\>,D<rsub|O>>

    <item><math|m=1,\<ldots\>,M>
  </itemize-dot>

  where the <math|0>th index always denotes the bias variable (so
  <math|X<rsub|0,m>=Y<rsub|0,m>=1> for all <math|m=1,\<ldots\>,M>)

  <section|Training the Neural Network>

  Neural Networks are supervised machine learning algorithms: We need a
  training set with the correct results to tune the weights
  <math|\<Theta\><rsup|<around*|(|r|)>>,r=1,2>. The training set is

  <\itemize-dot>
    <item><math|X=<around*|(|X<rsub|1>,\<ldots\>,X<rsub|M>|)>> is the
    training set input (and for convenience of length <math|M>). In our
    example, each <math|X<rsub|m>> describes the set of pixels in the image
    to be resolved,

    <item><math|Y=<around*|(|Y<rsub|1>,\<ldots\>,Y<rsub|M>|)>> is the
    training set output (for the currently -- incorrect -- chosen weights
    <math|\<Theta\><rsup|<around*|(|r|)>>>), i.e. the Neural Network's
    current guess for the digit the image contains,

    <item><math|L=<around*|(|L<rsub|1>,\<ldots\>,L<rsub|M>|)>> is the given
    correct result, i.e. <math|L<rsub|m>> contains information which digit
    the image actually shows. <math|L> follows the same notation as Y, so
    <math|L<rsub|m>> is a column vector containing
    <math|L<rsub|1,m>,\<ldots\>,L<rsub|D<rsub|O>,m>>.
  </itemize-dot>

  The training is supposed to tune the weights
  <math|\<Theta\><rsup|<around*|(|r|)>>> so that <math|L\<approx\>Y> where
  the approximation is interpreted in terms of the following error function
  (called cross-entropy error function):

  <\equation*>
    E<around*|(|\<Theta\>|)>=-<big|sum><rsup|M><rsub|m=1><big|sum><rsub|k=1><rsup|D<rsub|O>>L<rsub|k,m>\<cdot\>ln
    Y<rsub|k,m>+<around*|(|1-L<rsub|k,m>|)>\<cdot\>ln<around*|(|1-Y<rsub|k,m>|)>
  </equation*>

  Our objective is to minimize the error function, i.e. find a set of weights
  <math|\<Theta\><rsup|<around*|(|r|)>>> so that
  <math|E<around*|(|\<Theta\>|)>> is small, which means that
  <math|L\<approx\>Y>. This will be done in terms of a gradient descent
  algorithm, so we need the gradient of <math|E> with respect to
  <math|\<Theta\>>.\ 

  <section|Learning by Backward Propagation>

  The gradients of <math|E> can be obtained in a reversed fashion, i.e. we
  start from <math|Y> and <math|L> and work our way back. This is called
  Backward Propagation and is done as follows. First notice that\ 

  <\equation>
    <frac|\<partial\>E<around*|(|\<Theta\>|)>|\<partial\>\<Theta\><rsub|l<rsub|1>,l<rsub|2>><rsup|<around*|(|r|)>>>=-<big|sum><rsup|M><rsub|m=1><big|sum><rsub|k=1><rsup|D<rsub|O>><frac|L<rsub|k,m>-Y<rsub|k,m>|Y<rsub|k,m>\<cdot\><around*|(|1-Y<rsub|k,m>|)>>\<cdot\><frac|\<partial\>Y<rsub|k,m>|\<partial\>\<Theta\><rsub|l<rsub|1>,l<rsub|2>><rsup|<around*|(|r|)>>>
  </equation>

  The first step of Backward Propagation is the last step of Forward
  Propagation: Consider first\ 

  <\equation>
    Y<rsub|k,m>=\<sigma\><around*|{|<big|sum><rsub|j=0><rsup|D<rsub|H>>\<Theta\><rsup|<around*|(|2|)>><rsub|j,k>\<cdot\>Z<rsub|j,m>|}><text|,
    where >Z<rsub|0,m>=1,
  </equation>

  so

  <\eqnarray*>
    <tformat|<table|<row|<cell|<frac|\<partial\>Y<rsub|k,m>|\<partial\>\<Theta\><rsub|j,k><rsup|<around*|(|2|)>>>>|<cell|=>|<cell|\<sigma\><rprime|'><around*|{|<big|sum><rsub|j=0><rsup|D<rsub|H>>\<Theta\><rsup|<around*|(|2|)>><rsub|j,k>\<cdot\>Z<rsub|j,m>|}>\<cdot\>Z<rsub|j,m>>>|<row|<cell|>|<cell|=>|<cell|\<sigma\><rprime|'><around*|(|A<rsub|k,m><rsup|<around*|(|2|)>>|)>\<cdot\>Z<rsub|j,m>,<eq-number>>>>>
  </eqnarray*>

  now we notice that <math|\<sigma\><rprime|'><around*|(|a|)>=\<sigma\><around*|(|a|)>*<around*|(|1-\<sigma\><around*|(|a|)>|)>>
  and <math|Y<rsub|k,m>=<around*|[|\<sigma\><around*|(|A<rsup|<around*|(|2|)>>|)>|]><rsub|k,m>=\<sigma\><around*|(|A<rsub|k,m><rsup|<around*|(|2|)>>|)>>,
  hence

  <\equation>
    \<sigma\><rprime|'><around*|(|A<rsub|k,m><rsup|<around*|(|2|)>>|)>=Y<rsub|k,m>\<cdot\><around*|(|1-Y<rsub|k,m>|)>.
  </equation>

  Combined, we get

  <\eqnarray*>
    <tformat|<table|<row|<cell|<frac|\<partial\>E<around*|(|\<Theta\>|)>|\<partial\>\<Theta\><rsup|<around*|(|2|)>><rsub|j,k>>>|<cell|=>|<cell|-<big|sum><rsup|M><rsub|m=1><frac|L<rsub|k,m>-Y<rsub|k,m>|Y<rsub|k,m>\<cdot\><around*|(|1-Y<rsub|k,m>|)>>\<cdot\>Y<rsub|k,m>\<cdot\><around*|(|1-Y<rsub|k,m>|)>\<cdot\>Z<rsub|j,m>>>|<row|<cell|>|<cell|=>|<cell|-<big|sum><rsup|M><rsub|m=1><around*|(|L<rsub|k,m>-Y<rsub|k,m>|)>\<cdot\>Z<rsub|j,m><eq-number>>>>>
  </eqnarray*>

  It will be useful to abbreviate

  <\eqnarray*>
    <tformat|<table|<row|<cell|\<delta\><rsup|<around*|(|3|)>><rsub|m>>|<cell|=>|<cell|Y<rsub|m>-L<rsub|m>>>|<row|<cell|\<delta\><rsub|k,m><rsup|<around*|(|3|)>>>|<cell|=>|<cell|Y<rsub|k,m>-L<rsub|k,m>,>>>>
  </eqnarray*>

  hence

  <\equation>
    <block*|<tformat|<table|<row|<cell|<frac|\<partial\>E<around*|(|\<Theta\>|)>|\<partial\>\<Theta\><rsup|<around*|(|2|)>><rsub|j,k>>=<big|sum><rsub|m=1><rsup|M>\<delta\><rsub|k,m><rsup|<around*|(|3|)>>\<cdot\>Z<rsub|j,m>,>>>>>
  </equation>

  or (for compactness fetishists)

  <\equation*>
    <frac|\<partial\>E<around*|(|\<Theta\>|)>|\<partial\>\<Theta\><rsup|<around*|(|2|)>>>=<big|sum><rsub|m=1><rsup|M>\<delta\><rsub|m><rsup|<around*|(|3|)>>\<cdot\>Z<rsub|m><rsup|\<Tau\>>
  </equation*>

  Expanding <math|Y<rsub|k,m>> in terms of
  <math|\<Theta\><rsup|<around*|(|1|)>>> gives us

  <\eqnarray*>
    <tformat|<table|<row|<cell|Y<rsub|k,m>>|<cell|=>|<cell|\<sigma\><around*|{|<big|sum><rsub|j=0><rsup|D<rsub|H>>\<Theta\><rsup|<around*|(|2|)>><rsub|j,k>\<cdot\>Z<rsub|j,m>|}>>>|<row|<cell|Z<rsub|0,m>>|<cell|=>|<cell|1>>|<row|<cell|Z<rsub|j,m>>|<cell|=>|<cell|\<sigma\><around*|{|<big|sum><rsub|i=0><rsup|D<rsub|I>>\<Theta\><rsup|<around*|(|1|)>><rsub|i,j>\<cdot\>X<rsub|i,m>|}>,>>|<row|<cell|X<rsub|0,m>>|<cell|=>|<cell|1>>>>
  </eqnarray*>

  Derivation with respect to <math|\<Theta\><rsup|<around*|(|1|)>>>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<frac|\<partial\>Y<rsub|k,m>|\<partial\>\<Theta\><rsub|i,j><rsup|<around*|(|1|)>>>>|<cell|=>|<cell|\<sigma\><rprime|'><around*|(|A<rsub|k,m><rsup|<around*|(|2|)>>|)>\<cdot\>\<Theta\><rsub|j,k><rsup|<around*|(|2|)>>\<cdot\><frac|\<partial\>Z<rsub|j,m>|\<partial\>\<Theta\><rsub|i,j><rsup|<around*|(|1|)>>>>>|<row|<cell|>|<cell|=>|<cell|Y<rsub|k,m>\<cdot\><around*|(|1-Y<rsub|k,m>|)>\<cdot\>\<sigma\><rprime|'><around*|{|<big|sum><rsub|i=0><rsup|D<rsub|I>>\<Theta\><rsup|<around*|(|1|)>><rsub|i,j>\<cdot\>X<rsub|i,m>|}>\<cdot\>X<rsub|i,m>>>|<row|<cell|>|<cell|=>|<cell|Y<rsub|k,m>\<cdot\><around*|(|1-Y<rsub|k,m>|)>\<cdot\>\<sigma\><rprime|'><around*|(|A<rsub|j,m><rsup|<around*|(|1|)>>|)>\<cdot\>\<Theta\><rsub|j,k><rsup|<around*|(|2|)>>\<cdot\>X<rsub|i,m>>>|<row|<cell|<frac|\<partial\>E<around*|(|\<Theta\>|)>|\<partial\>\<Theta\><rsub|i,j><rsup|<around*|(|1|)>>>>|<cell|=>|<cell|-<big|sum><rsub|m=1><rsup|M>X<rsub|i,m>\<cdot\>\<sigma\><rprime|'><around*|(|A<rsub|j,m><rsup|<around*|(|1|)>>|)>\<cdot\><big|sum><rsub|k=1><rsup|D<rsub|O>><around*|(|L<rsub|k,m>-Y<rsub|k,m>|)>\<cdot\>\<Theta\><rsub|j,k><rsup|<around*|(|2|)>>>>|<row|<cell|>|<cell|=>|<cell|-<big|sum><rsub|m=1><rsup|M>X<rsub|i,m>\<cdot\>\<sigma\><rprime|'><around*|(|A<rsub|j,m><rsup|<around*|(|1|)>>|)>\<cdot\>\<Theta\><rsub|j><rsup|<around*|(|2|)>>\<cdot\><around*|(|L<rsub|m>-Y<rsub|m>|)>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|m=1><rsup|M>\<Theta\><rsub|j><rsup|<around*|(|2|)>>\<cdot\>\<delta\><rsub|m><rsup|<around*|(|3|)>>\<cdot\>\<sigma\><rprime|'><around*|(|A<rsub|j,m><rsup|<around*|(|1|)>>|)>\<cdot\>X<rsub|i,m>>>>>
  </eqnarray*>

  Hence,

  <\equation>
    <block*|<tformat|<table|<row|<cell|<frac|\<partial\>E<around*|(|\<Theta\>|)>|\<partial\>\<Theta\><rsub|i,j><rsup|<around*|(|1|)>>>=<big|sum><rsub|m=1><rsup|M>\<Theta\><rsub|j><rsup|<around*|(|2|)>>\<cdot\>\<delta\><rsub|m><rsup|<around*|(|3|)>>\<cdot\>\<sigma\><rprime|'><around*|(|A<rsub|j,m><rsup|<around*|(|1|)>>|)>\<cdot\>X<rsub|i,m>>>>>>
  </equation>

  Using some gradient descent algorithm, we can find a local minimum for the
  cost function, i.e. problem adapted values for <math|\<Theta\>>.

  \;

  \;

  \;
</body>

<\initial>
  <\collection>
    <associate|eqn-row-sep|<macro|1.45fn>>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-3|<tuple|3|?>>
    <associate|auto-4|<tuple|3.1|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Definition
      of our Neural Network> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Learning
      by Backward Propagation> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>