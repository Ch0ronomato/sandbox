import re

raw_dat = open(re.sub(' ', '', raw_input('Please drag your nexus file here\n')), 'r').readlines()

def partitions_aln(seq_list, partitions):

    def partition_seq(seq, partitions):
        seq_parts = [] 
        for i in partitions:
            seq_parts.append(seq[i[0]:i[1]])
        return ''.join(seq_parts)

    data_parts = []
    for i in seq_list:
        data_parts.append(partition_seq(i, partitions))
    return data_parts

# To test the functions above use:
#test_data = ['1234567891011', '1234567891011', '1234567891011', 'aaaaaaaaaaa']
#partitions_test = [[0,3], [4, 6], [7, 10]]
#part_1 = partitions_aln(test_data, partitions_test)

### 

#raw_dat = open('cpgenomes12.nex', 'r').readlines()

start_matrix = [i for i in range(len(raw_dat)) if 'matrix' in raw_dat[i]][0] + 1
end_matrix = [i for i in range(len(raw_dat)) if 'begin sets' in raw_dat[i]][0] - 4

seq_names = [re.sub(r'\t', '', re.findall(r'\t.+\t', i)[0]) for i in raw_dat[start_matrix:end_matrix]]
seq_data = [re.sub(r'\t.+\t|\n', '', i) for i in raw_dat[start_matrix:end_matrix]] 

raw_partitions = [re.sub('charset|;|\n', '', raw_dat[i]) for i in range(len(raw_dat)) if 'charset' in raw_dat[i]]
partition_names = [re.sub(' ', '', re.split('=', i)[0])+'.fasta' for i in raw_partitions]
partition_data = [re.split(',', i) for i in raw_partitions]

def clean_partition_data(part_data):
    clean_partitions = []
    for i in part_data:
        step1 = re.sub('.+=| ', '', i)
        clean_partitions.append([int(i) for i in re.split('-', step1)])
    return clean_partitions

partition_data_clean = [clean_partition_data(i) for i in partition_data]

for i in range(len(partition_data_clean)):
    part_seqs = partitions_aln(seq_data, partition_data_clean[i])
    out_lines = []
    for out_index in range(len(seq_data)):
        out_lines.append('>'+seq_names[out_index]+'\n')
        out_lines.append(part_seqs[out_index]+'\n')
    open(partition_names[i], 'w').writelines(out_lines)
    print 'partitioning data. Saving to  %s. The sequences are %s long.' %(partition_names[i], len(part_seqs[0]))
