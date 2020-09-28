tin_1 = open('p1.in', 'w')
tin_2 = open('p2.in', 'w')
tout = open('p.out', 'w')

import random 

def int2str(num, length):
    int_s = bin(num)[2:]
    int_s = '0' * (length - len(int_s)) + int_s
    return int_s 

def int2bit(num, length):
    int_s = int2str(num, length)
    num_bit = []
    for i in int_s:
        if i == '0':
            num_bit.append(0)
        else:
            num_bit.append(1)
    return num_bit


for i in range(100):
    p1 = random.randint(0, 2**6-1)
    p2 = random.randint(0, 2**4-1)
    p1_s = int2str(p1, 6)
    p2_s = int2str(p2, 4)
    p1 = int2bit(p1, 6)
    p2 = int2bit(p2, 4)
    p1y = (p1[0] & p1[1] & p1[2]) | (p1[3] & p1[4] & p1[5])
    p2y = (p2[0] & p2[1]) | (p2[2] & p2[3])
    py_ans = str(p2y) +  str(p1y)
    tin_1.write(p1_s + '\n')
    tin_2.write(p2_s + '\n')
    tout.write(py_ans + '\n')

tin_1.close()
tin_2.close()
tout.close()