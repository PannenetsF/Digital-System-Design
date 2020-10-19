import random 


en_f = open('en.ram', 'w')
s_f = open('s.ram', 'w')
d_f = open('d.ram', 'w')
y_f = open('y.ram', 'w')

for i in range(100):
    en = (random.randint(0, 1))
    s = (random.randint(0, 3))
    d = (random.randint(0, 15))
    if en == 0:
        y = '0'
    else:
        y = (4-len(bin(d)[2:])) * '0' + bin(d)[2:]
        y = y[3-s]
    
    en_f.write(str(en)+' ')
    s_f.write(bin(s)[2:]+' ')
    d_f.write(bin(d)[2:]+' ')
    y_f.write(y+' ')

for i in [en_f, s_f, d_f, y_f]:
    i.close()
