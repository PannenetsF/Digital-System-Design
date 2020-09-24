import random

tin = open('byteInv.in', 'w')
tout = open('byteInv.out', 'w') 

for i in range(100):
    num_buf = []
    for j in range(4):
        num_buf.append(random.randint(0, 256))
    s = ''
    for j in num_buf:
        s += '%02x'%j 
    tin.write(s + '\n')
    num_buf.reverse()
    s = ''
    for j in num_buf:
        s += '%02x'%j 
    tout.write(s + '\n')

tin.close()
tout.close()

