#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Programm von Tim Baumann, aus dem Pizzaseminar zwischen SS2013 und WS2013/2014.
# Bitte in eine interaktive Webseite verwandeln!

import numpy, numpy.linalg, math, sys, Image

def rect_diag(xs, rows, cols):
    mat = numpy.array([0.0] * (rows * cols)).reshape(rows,cols)
    for i in range(0,len(xs)):
        mat[i,i] = xs[i]
    return mat

im    = Image.open(sys.argv[1])
(w,h) = im.size

pixels = [ im.getpixel((i,j)) for i in range(0,w) for j in range(0,h) ]

red    = numpy.array(map(lambda c: c[0], pixels)).reshape(w,h)
green  = numpy.array(map(lambda c: c[1], pixels)).reshape(w,h)
blue   = numpy.array(map(lambda c: c[2], pixels)).reshape(w,h)

redsvd   = numpy.linalg.svd(red)
greensvd = numpy.linalg.svd(green)
bluesvd  = numpy.linalg.svd(blue)

(_, redsigma, _)   = redsvd
(_, greensigma, _) = greensvd
(_, bluesigma, _)    = bluesvd

svs_file = open('./svs.txt', 'w+')

for i in xrange(0, len(redsigma)):
    print("%i %f %f %f" % (i, redsigma[i], greensigma[i], bluesigma[i]), file=svs_file)

def process_mat(svd, svs_to_keep):
    (u, sigma, vherm) = svd

    #print "# Groesster/kleinster Singulaerwert: %.2f, %.2f" % (sigma[0], sigma[-1])
    #print "# Anzahl Sing.werte: %d" % len(sigma)
    #for k in range(0, len(sigma)):
    #    print("%d %.5f" % (k,sigma[k]))

    sigma_ = sigma.tolist()

    # "Unwichtige" Singulärwerte auf null setzen
    for i in range(svs_to_keep, len(sigma_)):
        sigma_[i] = 0

    # Matrix wieder zusammenbauen
    return numpy.dot(u, numpy.dot(rect_diag(sigma_, w, h), vherm))

def image_with_svs(svs_to_keep):
    red_   = process_mat(redsvd, svs_to_keep)
    green_ = process_mat(greensvd, svs_to_keep)
    blue_  = process_mat(bluesvd, svs_to_keep)

    im = Image.new("RGB", (w,h))

    for i in range(0,w):
        for j in range(0,h):
            im.putpixel((i,j), (int(red_[i][j]), int(green_[i][j]), int(blue_[i][j])))

    return im

# Infos ausgeben
#print "# ||A|| = %.2f, ||A_|| = %.2f" % (numpy.linalg.norm(mat), numpy.linalg.norm(A_))

checkpoints = range(1, 20) + range(20,100,10) + range(100,min(w,h),10) + [min(w,h)]

for i in checkpoints:
    im = image_with_svs(i)
    im.save(sys.argv[2] + '-' + format(i, '03') + '.png')

#frobs_file = open('./frobs.txt', 'w+')
#
#for i in xrange(1, min(w,h)):
#    svs_to_keep = i
#    red_   = process_mat(redsvd, svs_to_keep)
#    green_ = process_mat(greensvd, svs_to_keep)
#    blue_  = process_mat(bluesvd, svs_to_keep)
#
#    reddiff   = numpy.linalg.norm(red - red_)
#    greendiff = numpy.linalg.norm(green - green_)
#    bluediff  = numpy.linalg.norm(blue - blue_)
#
#    print("%i %f %f %f" % (svs_to_keep, reddiff, greendiff, bluediff), file=frobs_file)
