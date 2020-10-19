bi = open('bin.ram', 'w')
gr = open('gray.ram', 'w')

for i in range(16):
    bi.write(bin(i)[2:] + ' ')
    g = i ^ (i >> 1)
    gr.write(bin(g)[2:] + ' ')

bi.close()
gr.close()
