from random import *
from matplotlib import pyplot as plt

def eltMajDet(T):
    threshold = len(T) / 2
    maj = None
    for i in T:
        count = 0
        for j in T:
            if i == j :
                count += 1
        if count > threshold:
            maj = i
    return maj


print(eltMajDet([3, 3, 4, 2, 4, 4, 2, 4, 4]))

