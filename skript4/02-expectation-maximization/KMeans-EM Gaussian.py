##############################################################################
# Dirty implementation of KMeans and Expectation Maximization for Gaussian   #
# mixtures.                                                                  #
#                                                                            #
# This file was (almost) automatically extracted from the TeXmacs document   #
# where it actually makes more sense for it to be read (explanations, etc.)  #
# In particular, plotting has been written to work inside TeXmacs, although  #
# it should be trivial to display matplotlib's results in another way.       #
#                                                                            #
# You will need a copy of the old-faithful dataset (provided in the package) #
#                                                                            #
# Copyleft: (C) Miguel de Benito, October 2014                               #
# You may do whatever you like with this file and its contents.              #
# This message will self-destruct in 5 seconds.                              #
##############################################################################

from __future__ import division # Sensible division from Python3
import numpy as np
import numpy.random as ra
import matplotlib as mp
import matplotlib.pyplot as pl
from numpy.linalg import norm as norm

# Ideally:
#import texmacs as tm
#path = tm.buffer_path()
# Sadly:
path = 'PATH_TO_YOUR_DATASETS'

# Plumbing:
#import logging as log
#log.basicConfig (filename='/tmp/tm_python.log',level=log.DEBUG)


def normalize(x, mu=None, sigma=None):
    """Standardize x values using local or provided average and stddev.
    
    Cases along the first dimension (axis 0),
    dimensions along the 2nd (axis 1).
    """
    x = np.atleast_2d(x)
    
    avg = mu if mu is not None else np.mean(x, axis=0)
    std = sigma if sigma is not None and sigma is not 0\
          else np.std(x, axis=0)
    
    return  (x - avg) / std



def get_plot (points, prototypes=None, groups=None, cmap='jet'):
    """Plots an $N \times 2$ array of $N$ points in $\mathbbm{R}^2$.

    prototypes= $K \times 2$ array of $K$ points in $\mathbbm{R}^2$, each will be 
                drawn with a red cross 
    groups= $N \times 1$ array of assignments point -> group for coloring
    """
    k = len (prototypes) if groups is not None else 1
    n = len (points)
    cNorm     = mp.colors.Normalize (vmin = 0, vmax = k-1)
    scalarMap = mp.cm.ScalarMappable (norm = cNorm,
                                      cmap = pl.get_cmap (cmap))
    colors    = np.zeros ((n, 4))
    for i in xrange(n):
        colors[i] = scalarMap.to_rgba (groups[i] if groups is not None
                                                 else 0)
    pl.clf()
    pl.scatter (list (points[:,0]), list (points[:,1]), 
                marker='o', c=colors, edgecolors='none')
    if prototypes != None and prototypes.any():
        pl.scatter (list (prototypes[:,0]), list (prototypes[:,1]),
                    marker = 'x', c = 'r', s = 100)
    return pl.gcf()


class KMeans:
    """ KMeans algorithm.

    We minimize
\[ J_{\ensuremath{\boldsymbol{x}}} (\mu, r) = \sum_{n = 1}^N \sum_{k = 1}^K
   r_{n  k}  \| x_n - \mu_k \|^2 . \]
    
    """
    def __init__(self, k, X):
        self.k = k               # Number of prototypes / clusters
        self.X = X               # Data (normalized: $E (\ensuremath{\boldsymbol{x}}) = 0, V (\ensuremath{\boldsymbol{x}}) = 1$)
        self.n, self.d = X.shape # Number and dimension of data points
        self.restart()

    def restart(self):
        # j is the "distortion measure"
        self.j = 0.0
        # MU holds the d coordinates of the k prototypes
        # Remove hardcoded variables or normalize here
        self.MU = ra.random ((self.k, self.d)) * 4 - 2
        # R holds the assignments: R_n = k iff X_n is assigned to MU_k
        self.R = [int (self.k * ra.random()) for x in xrange (self.n)]

    def update_distortion(self):
        self.j = 0.0
        for n, x in enumerate(self.X):
            self.j += norm(x - self.MU[self.R[n]], ord=2)**2
        
    def minimize_assignments(self):
        """Minimize R_nk for fixed MU_k"""
        changes = False
        for n, x in enumerate(self.X):
            # Reuse results from previous computations
            cur = norm (x - self.MU[self.R[n]], ord=2)**2
            for k, m in enumerate(self.MU):
                val = norm (x - m, ord=2)**2
                if val < cur:
                    changes = True
                    #print ("cur[%d]= %f" % (n,cur))
                    #print ("val[%d]= %f" % (n,val))
                    self.R[n] = k
        return changes
        
    def minimize_prototypes(self):
        """Minimize MU_k for fixed R_nk"""
        for k, m in enumerate (self.MU):
            num, den = np.zeros (self.d), 0.0
            for n, x in enumerate (self.X):
                if self.R[n] == k:
                    num += x
                    den += 1
            self.MU[k] = num / den
        
    def run(self):
        J = []
        for step in xrange(20):
            #print "step= %d, j= %f" % (step, self.j)
            changes = self.minimize_assignments()
            self.update_distortion()
            J.append (self.j)
            
            self.minimize_prototypes()
            self.update_distortion()
            J.append (self.j)
            
            if not changes: break
        else:
            print "Max. iterations (20) reached!"
        print "Iterations = %d, Distortion = %f" %(step, self.j)
        
        return J


# Usage (in TeXmacs, you'll have to change plotting a bit otherwise)
"""
km = KMeans(2, data)
km.restart()
J = km.run()
ps_out (get_plot (data, km.MU, km.R, cmap='jet'))
pl.clf()
pl.plot(np.log(J), marker='o', color='r')
ps_out(pl)

km.restart()
J = km.run()
ps_out (get_plot (data, km.MU, km.R))
pl.clf()
pl.plot(np.log(J), marker='o', color='r')
ps_out(pl)
"""

from math import pi

# How does one define a static variable in a function?
mnormal_c = 1.0 / np.sqrt (2*pi)

def mnormal (X, M, S, Sdri=None, SI=None):
    """Evaluate density of multivariate normal.
    X=point, M=mean, S=covariance matrix
    Sdri=inverse of square root of determinant of S
    SI= inverse of S
    """
    if Sdri is None: Sdri = 1.0 / np.sqrt (np.linalg.det(S))
    if SI is None: SI = S.getI()
    c = mnormal_c * Sdri
    v = X - M
    ex = -0.5 * np.einsum('ai,ij,bj', v, SI, v)
    return float(c * np.exp(ex))

def mnormal1 (x, m, s):
    x = np.matrix ([x])
    m = np.matrix ([m])
    s = np.matrix (np.diag([s]))
    return mnormal (x, m, s)

import time

class EMGauss:
    """Sloppy implementation of EM for Gaussian mixtures.

    This is sloooooooooow... And I don't care!
    FIXME: Will throw divide by zero if $\mu_k = x_n$ for some $k, n$!
    """
    def __init__(self, X, k=2, maxiter=10):
        self.k = k               # Number of Gaussians
        self.X = X               # Data (normalized: $E (\ensuremath{\boldsymbol{x}}) = 0, V (\ensuremath{\boldsymbol{x}}) = 1$)
        self.n, self.d = X.shape # Number and dimension of data points
        self.maxiter = maxiter
        self.restart()

    def restart(self):
        # Means of the Gaussians
        # Remove hardcoded variables or normalize here
        self.M = np.matrix (ra.random ((self.k, self.d))*4 - 2)
        
        # Covariance matrices of the Gaussians (init to spherical cov.)
        # We store $S^{- 1}, \det (S)^{- 1 / 2}$ for faster evaluation of the density
        # of the multivariate normal.
        self.S    = np.empty (self.k, dtype = np.matrix)
        self.SI   = np.empty (self.k, dtype = np.matrix)
        self.Sdri = np.empty (self.k, dtype = float)

        # How do I init at declaration?
        for k in xrange (self.k):
            self.S[k] = np.matrix (np.zeros ((self.d, self.d)))
            while np.linalg.det(self.S[k]) == 0:
                self.S[k] = np.matrix (np.diag (ra.random (self.d)))
            self.SI[k] = self.S[k].getI()
            self.Sdri[k] = 1.0 / np.sqrt (np.linalg.det (self.S[k]))

        # Mixing coefficients
        self.P = np.matrix (ra.random ((self.k, 1)))
        self.P /= np.sum (self.P)

        # Responsibilities
        self.G = np.matrix (np.zeros ((self.n, self.k)))
        self.R = np.matrix (np.zeros ((self.k, 1)))

        self.update_responsibilities()
        self.update_loglikelihood()

    def update_responsibilities (self):
        #print "Updating responsibilities"
        for n, x in enumerate (self.X):
            for k in xrange (self.k):
                self.G[n,k] = self.P[k,0] * mnormal (x,
                                                     self.M[k],
                                                     self.S[k],
                                                     Sdri=self.Sdri[k],
                                                     SI=self.SI[k])
            self.G[n] /= np.sum (self.G[n])
        self.R = np.sum (self.G, axis=0).T

    def update_means (self):
        #print "Updating means"
        for k in xrange (self.k):
            self.M[k] = np.zeros (self.d)
            for n, x in enumerate (self.X):
                self.M[k] += self.G[n,k] * x
        self.M /= self.R
    
    def update_covariances (self):
        #print "Updating covariances"
        for k in xrange (self.k):
            self.S[k] = np.matrix (np.zeros ((self.d, self.d)))
            for n, x in enumerate (self.X):
                v = np.matrix (x - self.M[k])
                self.S[k] += self.G[n, k] * (v.T * v)
            self.S[k] /= self.R[k]
            self.SI[k] = self.S[k].getI()
            self.Sdri[k] = 1.0 / np.sqrt (np.linalg.det (self.S[k]))

    def update_mixture (self):
        #print "Updating mixture"
        self.P = self.R / self.n

    def update_loglikelihood (self):
        """ Compute
\[ \log p (\ensuremath{\boldsymbol{x}}|\ensuremath{\boldsymbol{\pi}},
   \ensuremath{\boldsymbol{\mu}}, \ensuremath{\boldsymbol{S}}) = \sum_{n =
   1}^N \log \sum_{k = 1}^K \pi_k \mathcal{N} (x_n | \mu_k, S_k) . \]
        
        """
        #print "Updating log likelihood"
        # NOTE: that we must repeat this computation because we have
        # new parameter values (cf. update_responsibilities())
        self.ll = 0.0
        for n, x in enumerate (self.X):
            v = 0.0
            for k in xrange (self.k):
                v += self.P[k,0] * mnormal (x,
                                            self.M[k], 
                                            self.S[k],
                                            Sdri=self.Sdri[k],
                                            SI=self.SI[k])
            self.ll += np.log (v)

    def run(self):
        LL = []
        # Useless pseudo-benchmarking:
        times = {'responsibilities': [], 'means' :[],
                 'covariances': [], 'mixture': [], 'loglikelihood': []}
        for step in xrange(1, self.maxiter+1):
            t = time.clock()
            self.update_responsibilities()
            times['responsibilities'].append(time.clock()-t)
            t = time.clock()
            self.update_means()
            times['means'].append(time.clock()-t)
            t = time.clock()
            self.update_covariances()
            times['covariances'].append(time.clock()-t)
            t = time.clock()
            self.update_mixture()
            times['mixture'].append(time.clock()-t)
            t = time.clock()
            self.update_loglikelihood()
            times['loglikelihood'].append(time.clock()-t)
            LL.append (self.ll)
            #print "step= %d, ll= %f" % (step, self.ll)
            if step > 1 and abs(LL[-1] - LL[-2]) < 1e-4: break
        else:
            print "Max. iterations (%d) reached!" % self.maxiter
        print ("Iterations = %d, log likelihood = %f" % 
                    (step, self.ll))
        return (LL, times)

    def get_plot (self, cmap='jet'):
        """Plots an $N \times 2$ matrix of $N$ points in $\mathbbm{R}^2$.
        ... 
        """
        cNorm     = mp.colors.Normalize (vmin = 0, vmax = self.k-1)
        scalarMap = mp.cm.ScalarMappable (norm = cNorm,
                                          cmap = pl.get_cmap (cmap))
        colors    = np.zeros ((self.n, 4))
        for n, p in enumerate(self.G):
            for i in xrange(self.k):
                rgba = scalarMap.to_rgba(i)
                for c in xrange(4):
                    colors[n,c] += rgba[c] * p[0,i]
                    colors[n,c] = min (1.0, colors[n,c])
        pl.clf()
        pl.scatter (list (self.X[:,0]), list (self.X[:,1]), 
                    marker='o', c=colors, edgecolors='none')
        pl.scatter (list (self.M[:,0]), list (self.M[:,1]),
                    marker = 'x', color = 'r', s = 100)
        return pl.gcf()



def gen_data(n=300, k=3, d=2, normed=True):
    data  = np.zeros ((n,d))
    means = ra.random ((k,d))*10-5    # Hack hack hack...
    covs  = np.empty (k, dtype=np.matrix)
    for i in xrange(k):
        covs[i] = np.matrix(np.zeros((d,d)))
        while np.linalg.det(covs[i]) == 0:
            S = np.matrix (ra.random ((d, d))*2 - 1)
            covs[i] = S * S.T / 2

    rs = ra.RandomState()
    for i in xrange(n):
        j = int (ra.random()*k)
        data[i] = rs.multivariate_normal (means[j], covs[j])
    if normed:
        return [normalize(means), covs, normalize(data)]
    else:
        return [means, covs, data]


# Using the synthetic benchmarks
"""
n=400
k=4
# Generate and plot data
means, covs, syndata = gen_data (n, k)
ps_out (get_plot (syndata, means, cmap='hot'))
# Run EMG and plot result
emg = EMGauss (syndata, k, maxiter=20)
LL,TT = emg.run()
pl.clf()
ps_out (emg.get_plot (cmap='jet'))
# Plot $\log p (\ensuremath{\boldsymbol{x}}|\ensuremath{\boldsymbol{\pi}},
\ensuremath{\boldsymbol{\mu}}, \ensuremath{\boldsymbol{S}})$
pl.clf()
pl.plot (LL, marker='o', color='r')
ps_out (pl)



emg = EMGauss (data, k=2, maxiter=20)
#emg.restart()
LL, TT = emg.run()
ps_out (emg.get_plot ())
pl.clf()
pl.plot (LL, marker='o', color='r')
ps_out (pl)

# Useless pseudo-benchmarking
pl.clf()
map(lambda x: pl.plot(xrange(1,21),TT[x], label=x), TT)
pl.legend()
ps_out(pl)
"""
