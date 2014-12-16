#!/bin/bash

cd "$1"
python ../../svd-image.py original.png reduced
gnuplot ../../plot-svs.gnuplot
