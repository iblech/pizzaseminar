#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy, cPickle, gzip
import matplotlib.pyplot as plt

# Use the following code once, to shrink the MNIST data set to a more
# manageable size. Obtain mnist.pkl.gz from
# http://deeplearning.net/data/mnist/mnist.pkl.gz.
#
# f = gzip.open('mnist.pkl.gz', 'rb')
# train_set, valid_set, test_set = cPickle.load(f)
# f.close()
# cPickle.dump(numpy.asarray(train_set)[:,:5000], open("mnist-reduced.pkl","wb"))

train_set = cPickle.load(open("mnist-reduced.pkl", "rb"))

N = 500  # number of samples to use for training
data = numpy.zeros((784,N))
for i in range(N): data[:,i] = train_set[0,i]

# Normalize the data so that their mean is zero.
mean = data.mean(axis=1)
data = data - mean[:, numpy.newaxis]

# The heart of the algorithm: Compute the SVD of the sample matrix.
(w, sigma, vherm) = numpy.linalg.svd(data)

coeffs = numpy.dot(w.T, data)
data_  = numpy.dot(w, coeffs)
# coeffs[:,i] is the vector of POD coefficients for sample i.
# data_[:,i] is the reconstruction of sample i using the POD basis.

# Blow up a coefficient list like [a,b,c,d,e,...] to
# [a,a,a,a,a, b,b,b,b, c,c,c, d,d, e, f, g, h, i, j].
# This is used for plotting, such that visual weight aligns with importance.
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

# Plot the POD coefficients for the first 30 samples of the digits 1 to 9.
f, ax = plt.subplots(3,3)
for row in range(3):
  for col in range(3):
    inds = [i for i in range(N) if train_set[1,i] == 3*row+col+1]
    ax[row,col].matshow(dupl(coeffs[:10, inds[:30]]))
plt.show()

# Plot the first few POD basis vectors, i.e. the eigendigits.
f, ax = plt.subplots(3,4)
for row in range(3):
  for col in range(4):
    ax[row,col].matshow(w[:,4*row+col].reshape(28,28))
plt.show()
