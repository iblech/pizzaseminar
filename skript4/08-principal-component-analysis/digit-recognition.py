#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy, cPickle, gzip
import matplotlib.pyplot as plt

# f = gzip.open('mnist.pkl.gz', 'rb')
# train_set, valid_set, test_set = cPickle.load(f)
# f.close()
# cPickle.dump(numpy.asarray(train_set)[:,:5000], open("mnist-reduced.pkl","wb"))

train_set = cPickle.load(open("mnist-reduced.pkl", "rb"))

N = 500
data = numpy.zeros((784,N))
for i in range(N): data[:,i] = train_set[0,i]

mean = data.mean(axis=1)
data = data - mean[:, numpy.newaxis]

(w, sigma, vherm) = numpy.linalg.svd(data)

coeffs = numpy.dot(w.T, data)
data_  = numpy.dot(w, coeffs)

def dupl(m):
    n = numpy.zeros((20,m.shape[1]))
    r = 0
    n[r,:] = m[0,:]; r = r + 1
    n[r,:] = m[0,:]; r = r + 1
    n[r,:] = m[0,:]; r = r + 1
    n[r,:] = m[0,:]; r = r + 1
    n[r,:] = m[0,:]; r = r + 1
    n[r,:] = m[1,:]; r = r + 1
    n[r,:] = m[1,:]; r = r + 1
    n[r,:] = m[1,:]; r = r + 1
    n[r,:] = m[1,:]; r = r + 1
    n[r,:] = m[2,:]; r = r + 1
    n[r,:] = m[2,:]; r = r + 1
    n[r,:] = m[2,:]; r = r + 1
    n[r,:] = m[3,:]; r = r + 1
    n[r,:] = m[3,:]; r = r + 1
    n[r,:] = m[4,:]; r = r + 1
    n[r,:] = m[5,:]; r = r + 1
    n[r,:] = m[6,:]; r = r + 1
    n[r,:] = m[7,:]; r = r + 1
    n[r,:] = m[8,:]; r = r + 1
    n[r,:] = m[9,:]; r = r + 1
    return n

f, ax = plt.subplots(3,3)
for row in range(3):
  for col in range(3):
    inds = [i for i in range(N) if train_set[1,i] == 3*row+col+1]
    ax[row,col].matshow(dupl(coeffs[:10, inds[:30]]))

plt.show()

f, ax = plt.subplots(3,4)
for row in range(3):
  for col in range(4):
    ax[row,col].matshow(w[:,4*row+col].reshape(28,28))

plt.show()
