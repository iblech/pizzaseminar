set grid

plot \
    "<./integrate   0 | head -n 400" w l t "Retaining every sample", \
    "<./integrate   9 | head -n 400" w l t "Retaining every 10'th sample", \
    "<./integrate  99 | head -n 400" w l t "Retaining every 100'th sample", \
    "<./integrate 999 | head -n 400" w l t "Retaining every 1000'th sample"
