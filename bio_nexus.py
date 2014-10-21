from Bio import SeqIO
handle = open('cpgenomes_nopart.nex', 'rU')
recs = list(SeqIO.parse(handle, 'nexus'))
handle.close()
