from random import *
from matplotlib import pyplot as plt

def flottantsAleatoires(n):
    randomList = []
    for i in range(n):
        randomList.append(random())
    return randomList


def flottantsAleatoires2(n,a,b):
    randomList = []
    for i in range(n):
        randomList.append(uniform(a,b))
    return randomList


a = -3
b = 10
L1 = flottantsAleatoires(1000)
L2 = flottantsAleatoires2(1000,a, b)

plt.plot(L1)
plt.show()
