#!/usr/bin/env gnuplot

set terminal png size 1200,600 enhanced font "Helvetica,20"
set output "svs.png"
set logscale y
plot "svs.txt" using 1:2 title 'R' with lines lw 3, \
     "svs.txt" using 1:3 title 'G' with lines lw 3, \
     "svs.txt" using 1:4 title 'B' with lines lw 3
