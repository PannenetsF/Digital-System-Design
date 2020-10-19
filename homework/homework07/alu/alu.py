import random 


a_f = open('a.ram', 'w')
b_f = open('b.ram', 'w')
op_f = open('op.ram', 'w')
ans_f = open('ans.ram', 'w')

for i in range(100):
    a = (random.randint(0, 15))
    b = (random.randint(0, 15))
    op = (random.randint(0, 3))
    if op == 0:
        ans = 0xf - a
    elif op == 1:
        ans = 0xf - b 
    elif op == 2:
        ans = a & b 
    elif op == 3:
        ans = a | b 
    else:
        raise ValueError('You op is bullshit')
    a_f.write(hex(a)[2:])
    b_f.write(hex(b)[2:])
    op_f.write(hex(op)[2:])
    ans_f.write(hex(ans)[2:])

for i in [a_f, b_f, op_f, ans_f]:
    i.close()
