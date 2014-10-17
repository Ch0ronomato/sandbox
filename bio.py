from Bio import SeqIO
import os, re

handle = open('fasta_files/seq_pm1_1.fasta', 'rU')

for rec in SeqIO.parse(handle, 'fasta'):
    print rec.id
handle.close()


handle = open('fasta_files/seq_pm1_1.fasta', 'rU')

records = list(SeqIO.parse(handle, 'fasta'))
handle.close()



