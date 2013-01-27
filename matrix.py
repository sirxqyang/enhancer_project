#! /usr/bin/env python

# Change the raw matrix into binary matrix
# Usage: python matrix.py

import os

f = open('matrix.txt', 'r')
lines = f.readlines()
f.close()

f = open('matrix_final.txt', 'w')

header = lines.pop(0)

f.write(header)


for i in lines:

	parts = i.rstrip('\n').split('\t')

	chro  = parts.pop(0)
	Start = parts.pop(0)
	End = parts.pop(0)

	for i in range(0,len(parts)):
		#print parts[i]
		
		if int(parts[i]) > 1:
			#print parts[i]
			parts[i] = '1'
			#print parts[i]


	string = '\t'.join(parts)
	string = chro + '\t' + Start + '\t' + End + '\t' + string + '\n'
	f.write(string)