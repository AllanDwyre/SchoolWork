from random import *
from matplotlib import pyplot as plt

def pointsDisque(n):
    disque_points = []
    while len(disque_points) < n:
        x = (random() - .5) * 2
        y = (random() - .5) * 2
        if(x*x + y*y <= 1):
            disque_points.append((x,y))
    return disque_points


def pointsDisque2(n):
    disque_points = []
    x = (random() - .5) * 2
    while len(disque_points) < n:
        y = (random() - .5) * 2
        if(x*x + y*y <= 1):
            disque_points.append((x,y))
            x = (random() - .5) * 2
    return disque_points


from math import *

def pointsDisque3(n):
    disque_points = []
    for i in range(n):
        theta = uniform(0, 2 * pi)
        r = uniform(0, 1)
        disque_points.append((r * cos(theta), r * sin(theta)))
    return disque_points


def affichagePoints(L):
    x = [x for x,y in L]
    y = [y for x,y in L]
    plt.scatter(x, y, s = 1)
    plt.axis("square")
    plt.show()


affichagePoints(pointsDisque(10000))
affichagePoints(pointsDisque2(10000))
affichagePoints(pointsDisque3(10000))

# * Non, la 2eme et 3eme methode ne sont pas uniformes : 
#*   - 2eme : est plus dense sur les extremes de l'axe x
#*   - 3eme : est plus dense vers le centre
#* seul la 1ere est uniforme
#* --------------------------------
#* la premiere; x et y sont 100% aleatoire
#* la deuxieme; x est généré qu'une fois y est obligé de se concentrer dans une zone plus petite
#* la troisieme; bien que theta et r sont 100% aléatoire, le fait que le point de départ est toujours
#*               le meme (0,0) la concentration des points ce fait autour de lui



