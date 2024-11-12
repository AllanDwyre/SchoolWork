from random import *
from matplotlib import pyplot as plt

def entiersAleatoires(n,a,b):
    randomList = []
    for i in range(n):
        randomList.append(randint(a,b))
    return randomList


def entiersAleatoires2(n,a,b):
    randomList = []
    for i in range(n):
        randomList.append(randrange(a,b))
    return randomList

L1 = entiersAleatoires(1000,1,10)
L2 = entiersAleatoires2(1000,1,10)

plt.hist(L1, bins=100)
plt.show()

# plt.hist(L2, bins=100)
# plt.show()


# * q 1.3 :    Les distributions semblent-elles uniformes ?
# *                 Quelle est la différence entre randint et randrange ?

#* Les distributions sont uniformes. le max randint est inclusive et randrange est exclusive


