def clause(s):
	L = s.split()
	return [int(v) for v in L[:-1]]

def parseur(nom):
	with open(nom) as f:
		F = []
		n = 0
		for ligne in f:
			if ligne[0] == 'c': continue
			if ligne[0] == 'p':
				L = ligne.split()
				n = int(L[-2])
			else: 
				F.append(clause(ligne))
	return F, n

def affiche(F):
	s=''
	for j in range(0,len(F)):
		C=F[j]
		s=s+'('
		for i in range(0,len(C)):
			if C[i]<0:
				s=s+'¬'
			s=s+'x'+str(abs(C[i]))
			if i==len(C)-1:
				s=s+')'
			else:    
				s=s+' ∨ '
		if j!=len(F)-1:
			s=s+' ∧ '
	return s

################################################################

def valide(F, A):
	for clause in F :
		ok = False
		for var in clause :
			if(var * A[abs(var) - 1] > 0): ok = True
		if(not ok): return False
	return True

################################################################

def aff_suivante(A):
	i = len(A) - 1
	while i >= 0 and A[i] == 1 :
		A[i] = -1
		i -= 1
		if(i == -1) : return None
	A[i] = 1
	return A

def test_aff_suivante(n):
	A = [-1] * n
	print(A)
	for i in range(2 ** n):
		print(aff_suivante(A))
		
#########################################################################

def sat_exhau(F, n):
	A = [-1] * n
	for i in range(2 ** n):
		if(valide(F, A)) :
			return A
		A = aff_suivante(A)
	return None

def elimination(F, n, b):
#    "Formule psi = F(x_1, …, x_{n-1}, b)"
	psi=[]
	for clause in F:
		sat = False
		c = []
		for var in clause:
			if(abs(var) == n and var * b > 0):
				sat = True
			elif abs(var) != n:
				c.append(var)
		if not sat :
			psi.append(c)
	return psi

def sat_backtrack(F, n):
	if not F: 
		return [1] * n
	if not all(F) : return "Insatisfiable"
	for b in [-1,1]:
		psi = elimination(F, n, b)
		A = sat_backtrack(psi, n - 1)
		if A != "Insatisfiable" :
			return A + [b]
	return "Insatisfiable"

###############################################################################

print("-------------------------------------------------------")
Fichier="./cnf/random-21-unsat.cnf"
print("Formule du fichier: "+Fichier)
F,n=parseur(Fichier)
print("Récupérée sous forme de tableau: ",F)
print("Nombre de variables: ",n)
print("Formule SAT: ",affiche(F))
#print("-------------------------------------------------------")
#print(valide(F, [1,1,-1]))
#print(valide(F, [-1,-1,1]))
#print("-------------------------------------------------------")
#test_aff_suivante(4)
print("-------------------------------------------------------")
print(sat_exhau(F, n))
print(sat_backtrack(F, n))

# Ecoute ça fait pas longtemps quon se connait, sa fait deux semaines;
# Je trouve qu'on a un bon feeling ensemble
# Et parfois j'avoue ça me perturbe un peu cette connection qui a entre nous
# que même que si j'ai une copine, mais je voulais savoir si cest dans ma tete
# ou que si toi aussi tu penses qu'il y a potentiellement un truc ? 