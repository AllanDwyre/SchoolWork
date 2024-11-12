from random import *
from matplotlib import pyplot as plt

def aleatoireModulo(N): 
    x = getrandbits(N.bit_length())
    return x % N

def aleatoireRejet(N):
    x = getrandbits(N.bit_length())
    if(x >= N):
        x = aleatoireRejet(N)
    return x

L1 = [aleatoireModulo(100) for i in range(10000)]
L2 = [aleatoireRejet(100) for i in range(10000)]

plt.hist(L1)
plt.show()
plt.hist(L2)
plt.show()

# La 2eme methode est uniforme 
# alors que la premiere a plus de chance d'avoir des nombres < 40