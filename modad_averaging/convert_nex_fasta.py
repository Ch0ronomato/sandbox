from Bio import SeqIO

dat = SeqIO.to_dict(SeqIO.parse(open('Moureau_aa.nexus', 'r'), 'nexus'))
