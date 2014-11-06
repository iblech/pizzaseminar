set grid

plot \
    "<./integrate    0 | head -n 400" w l, \
    "<./integrate   10 | head -n 400" w l, \
    "<./integrate  100 | head -n 400" w l, \
    "<./integrate 1000 | head -n 400" w l
