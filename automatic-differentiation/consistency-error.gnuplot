set style line 1 linecolor rgb '#000000' linetype 1 linewidth 2
set style line 2 linecolor rgb '#ff4444' linetype 1 linewidth 4
set style line 3 linecolor rgb '#4444ff' linetype 1 linewidth 4

unset xtics
unset ytics
unset border
set xzeroaxis ls 1
set yzeroaxis ls 1
set samples 100000

set terminal pdf size 7cm, 4cm


## Schnittverhalten
set xrange [-1.8:1.5]
set yrange [-2.5:2.5]

set output "consistency-error.pdf"
f(x) = x**4. - 2*x**2 + x
plot f(x) + sin(x*30)/8 t "" w l ls 2, f(x) t "" w l ls 3
