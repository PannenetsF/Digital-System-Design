ADDBIT = 16

import random 

add1 = open('add1.in', 'w')
add2 = open('add2.in', 'w')
ans = open('ans.out', 'w')
cin = open('cin.in', 'w')

max_in = ( 1 << ADDBIT ) - 1


def int2str(num, length):
    int_s = bin(num)[2:]
    int_s = '0' * (length - len(int_s)) + int_s
    return int_s 

for i in range(100):
    num1 = random.randint(0, max_in) 
    num2 = random.randint(0, max_in)
    numin = random.randint(0, 1)
    numans = num1 + num2 + numin
    num1 = int2str(num1, ADDBIT)+ '\n'
    num2 = int2str(num2, ADDBIT)+ '\n'
    numin = int2str(numin, 1)+ '\n'
    numans = int2str(numans, ADDBIT+1) + '\n'
    add1.write(num1)
    add2.write(num2)
    cin.write(numin) 
    ans.write(numans)

add1.close()
add2.close()
ans.close()
cin.close()
