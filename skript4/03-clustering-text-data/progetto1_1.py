#
# This program should cluster .txt ascii files (in english)
# This is Version 1.1
# It uses built in structures of Python

from __future__ import division
from sets import Set
import math
import os
import string

# WORKINGDIR = '/Users/lab/AlgSD/progetto/docs'
# STOPWORDS = '/Users/lab/AlgSD/progetto/stopwords/english.stop'
WORKINGDIR = '/Users/lab/Dropbox/Informatica/ml/progetto/documents'
STOPWORDS = '/Users/lab/Dropbox/Informatica/ml/progetto/stopwords/english.stop'
THRESHOLD = 1.57071
# 1.57076 already provides good clustering
# 1.57071 best clustering
# 1.57066 too much
# It looks like \pi/2 and it is NOT a coincidence.


# The following function processes files one by one, returning the local 
# dictionary associated to the file

def process_file(file_name): 
    text = open(file_name , 'r').read()
    # Text manipulation
    table = string.maketrans("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , "abcdefghijklmnopqrstuvwxyz")
    text = text.translate(table , '.,!;:?^()-+*§<>[]£$%"°=#0123456789')
    text = text.replace("'s" , "")
    text = text.replace("'ll" , "")
    # End of manipulation
    wordlist = text.split()
    # Stopwords removal
    stopwords = open(STOPWORDS , 'r').read().split()
    wordlist = [word for word in wordlist if word not in stopwords]
    # Now should be tidied up
    wordlist2 = list(Set(wordlist))
    wordtimes = [wordlist.count(p) for p in wordlist2]
    local_dict = dict(zip(wordlist2,wordtimes))
    return local_dict

# The following function returns for every document the corresponding vector

def vectorize(local_dict,global_dict,doc_num):
    word_num = 0
    for p in local_dict.keys():
        word_num += local_dict[p]
    for p in local_dict.keys():
        tf = local_dict[p] / word_num
        idf = math.log(doc_num / global_dict[p])
        local_dict[p] = tf*idf
    return local_dict

# The following function computes reciprocal distances given all the documents

def vector_dist(vectors):
    length = len(vectors)
    dist = [[0 for i in range(length)] for j in range(length)]
    for i in range(length):
        for j in range(i,-1,-1): # Symmetric matrix
            for p in vectors[i]:
                if vectors[j].has_key(p): # All words orthogonal
                    dist[i][j] += vectors[i][p]*vectors[j][p]
            if j is not i:
                if dist[i][i] == 0 or dist[j][j] == 0:
                    dist[i][j] = 50 #some big default value
                else:
                    dist[i][j] = math.acos(dist[i][j] / (math.sqrt(dist[i][i]) * math.sqrt(dist[j][j])))
                    dist[j][i] = dist[i][j]
            else:
                dist[i][i] = 10 # some other default value, no significance
    return dist

# Computes minimal distance between clusters
# Simple link

def minimal_dist(matr_dist):
    minimum = 100 # Bigger than any possible value
    for i in range(len(matr_dist)):
        if min(matr_dist[i]) < minimum:
            minimum = min(matr_dist[i])
            column = i
            row = matr_dist[i].index(minimum)
    return[minimum , row , column]

# Clusters' update

def clusterize(clust , dist , row , column):
    if row < column:
        t = row
        row = column
        column = t
    temp_clust = clust.pop(row)
    clust[column] = clust[column] + temp_clust
    temp_dist = dist.pop(row)
    for i in range(len(dist[column])):
        dist[column][i] = max(dist[column][i] , temp_dist[i])
    for i in range(len(dist)):
        del dist[i][row]
        dist[i][column] = dist[column][i]
    return [clust , dist]

# Print results

def print_result(clust , nomi_file):
    with open('../results.txt', 'w') as f:
        f.write('Resulting clusters\n\n')
        for i in range(len(clust)):
            title = 'Cluster' + repr(i+1)
            print title
            f.write(title + '\n')
            for j in clust[i]:
                print nomi_file[j]
                f.write(nomi_file[j] + '\n')
            print '\n'
            f.write('\n')
    return 

#main

os.chdir(WORKINGDIR)
try:
    os.remove('.DS_Store')
except:
    pass
files = os.listdir(WORKINGDIR)
dictionary = dict()
documents = list()

for file_name in files: 
    documents.append(process_file(file_name))
    for p in documents[len(documents)-1].keys():
        if dictionary.has_key(p):
            dictionary[p] += 1
        else:
            dictionary[p] = 1

cluster = list()
for i in range(len(documents)):
    documents[i] = vectorize(documents[i] , dictionary , len(documents))
    cluster.append([i])

dist = vector_dist(documents)
value = minimal_dist(dist)

while value[0] <= THRESHOLD and len(cluster)>1:
    [cluster , dist] = clusterize(cluster , dist , value[1] , value[2])
    value = minimal_dist(dist)

# print
print len(dictionary)
print_result(cluster , files)
