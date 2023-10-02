/*
USAGE :
Penser à remplir les champs Numéro carte, nom, prénom, date.

Utiliser ce fichier pour répondre aux différentes questions. 
Pour chaque requete vous avez le résultat que vous devez obtenir avec les données de la base BIBLIOTHEQUE.

Les requêtes sont affichées

Si vous ne voulez pas afficher à chaque fois vos requêtes vous pouvez les mettre en commentaire. 
Attention sous ORACLE pour les marques des commentaires (le slash et l'étoile) doivent être seuls sur une ligne.

*/


/*
Numéro de carte étudiant : 
Nom : 
Prénom : 
Date : 
*/

/*
Mise en page - Ne pas toucher
*/

CLEAR SCREEN
SET PAGESIZE 30
COLUMN COLUMN_NAME FORMAT A30
SET LINESIZE 300


prompt --- Q1 : Quels sont les noms et prénoms des abonnés domiciliés à Montpellier ?

/*
Select nom,prenom from ABONNE 
where ville='MONTPELLIER';
*/

/*
NOM		PRENOM
--------------- --------------------
LEVEQUE 	PIERRE
DUPONT		MARIE
RENARD		ALBERT
DUPONT		ANTOINE
DUPONT		SYLVIE
DUPONT		JEAN
MEUNIER 	LUC
LUCAS		PAUL
REVEST		ANNIE
ANTON		JEANNE

10 lignes selectionnees.
*/

prompt ---- Q2 : Donner toutes les informations sur les exemplaires dont le code de prêt est : « EMPRUNTABLE ».

/*
select * from EXEMPLAIRE
where CODE_PRET = 'EMPRUNTABLE';
*/

/*
    NUMERO DATE_ACHAT	    PRIX CODE_PRET	      ETAT	      ISBN
---------- ---------- ---------- -------------------- --------------- ---------------
      1010 10-04-2015	      55 EMPRUNTABLE	      BON	      0_18_47892_2
      1011 10-04-2015	      55 EMPRUNTABLE	      BON	      0_18_47892_2
      1012 20-05-2015	     112 EMPRUNTABLE	      BON	      3_505_13700_5
      2909 30-03-2017	      35 EMPRUNTABLE	      BON	      3_505_13700_5
      2673 15-03-2018	      42 EMPRUNTABLE	      ABIME	      3_505_13700_5
      2711 20-06-2014	      27 EMPRUNTABLE	      BON	      0_8_7707_2
      3016 15-09-2017	      42 EMPRUNTABLE	      BON	      0_201_14439_5
      3702 20-02-2019	      21 EMPRUNTABLE	      BON	      1_22_1721_3
      4111 03-01-2021	      48 EMPRUNTABLE	      BON	      1_22_1721_3
      4203 29-11-2019	      35 EMPRUNTABLE	      BON	      1_104_1050_2
      4204 29-11-2019	      35 EMPRUNTABLE	      ABIME	      1_104_1050_2
      5003 10-06-2020	      39 EMPRUNTABLE	      BON	      1_104_1050_2
      5004 10-06-2020	      41 EMPRUNTABLE	      BON	      0_15_270500_3
      5005 10-06-2020	      41 EMPRUNTABLE	      BON	      0_15_270500_3
      5104 20-12-2017	      47 EMPRUNTABLE	      BON	      0_12_27550_2
      6006 15-02-2021	      33 EMPRUNTABLE	      BON	      0_85_4107_3
      6007 15-02-2021	      33 EMPRUNTABLE	      BON	      0_85_4107_3
      5202 18-10-2020	      40 EMPRUNTABLE	      BON	      0_18_47892_2
      7001 01-09-2016	      42 EMPRUNTABLE	      BON	      2_7296_0040
      1109 30-05-2016	      17 EMPRUNTABLE	      BON	      9_782070_36

20 lignes selectionnees.
*/


prompt ---- Q3 : Donner la liste des ouvrages (ISBN, TITRE, CATEGORIE), dont le titre inclut le mot ‘ROSE’, triée par ordre décroissant de numéro.

/*
select ISBN,titre,categorie from livre
where titre like '%ROSE%';
*/

/*
ISBN		TITRE						   CATEGORIE
--------------- -------------------------------------------------- ----------------
1_22_1721_3	LE NOM DE LA ROSE				   ROMAN
0_18_47892_2	UNE ROSE POUR MORRISSON 			   ROMAN
0_15_270500_3	LE MIRACLE DE LA ROSE				   ROMAN
*/

prompt ---- Q4 : Donner la liste des livres (leur titre et catégorie) de toutes les catégories sauf Médecine, Sciences et Loisirs. Cette liste sera donnée triée par ordre alphabétique selon la catégorie.

/*
select titre, categorie from livre
where categorie not IN('MEDECINE','SCIENCES','LOISIRS')
order by categorie ;
*/

/*
TITRE						   CATEGORIE
-------------------------------------------------- ----------------
GODEL ESCHER BACH : LES BRINS D UNE GUIRLANDE	   HISTOIRE
LE MUR						   NOUVELLE
POESIES COMPLETES				   POEME
UNE ROSE POUR MORRISSON 			   ROMAN
LA PERLE					   ROMAN
LE GRAND VESTIAIRE				   ROMAN
L ENFANT					   ROMAN
LE MIRACLE DE LA ROSE				   ROMAN
LE NOM DE LA ROSE				   ROMAN

9 lignes selectionnees.
*/


prompt ---- Q5 : Donner toutes les informations sur les emprunts pour lesquels la date de retour effective (attribut D_RET_REEL) n'est pas renseignée dans la base de données.

/*
VOTRE REPONSE ICI
*/


/*
    NUM_AB     NUM_EX D_EMPRUNT  D_RETOUR   D_RET_REEL NB_RELANCE
---------- ---------- ---------- ---------- ---------- ----------
    911007	 4204 19-01-2021 10-02-2021			1
    902075	 2673 15-02-2021 28-02-2021
    902075	 1010 05-01-2021 25-01-2021			1
    921102	 6006 20-12-2020 10-01-2021			2

*/


prompt ---- Q6 : Donner, pour l'abonné JEAN DUPONT, la liste des exemplaires empruntés (leur numéro et la date d'emprunt), par ordre croissant de date d'emprunt.

/*

select NUM_EX,D_EMPRUNT from EMPRUNT join ABONNE on EMPRUNT.NUM_AB = ABONNE.NUM_AB where ABONNE.nom='DUPONT' and ABONNE.prenom='JEAN' order by D_EMPRUNT,NUM_EX;
*/

/*
    NUM_EX D_EMPRUNT
---------- ----------
      5003 10-03-2020
      5005 30-03-2020
      1012 30-03-2020
      5103 17-06-2020
      1109 15-09-2020
      6007 22-12-2020

6 lignes selectionnees.
*/


prompt ------ Q7 : Donner la liste des exemplaires empruntés (leur numéro, code prêt et état) du livre de titre « LE MUR».

/*
select numero,code_pret, etat from exemplaire join livre on exemplaire.isbn=livre.isbn where titre='LE MUR' order by etat desc;

*/

/*
    NUMERO CODE_PRET		ETAT
---------- -------------------- ---------------
      5003 EMPRUNTABLE		BON
      4203 EMPRUNTABLE		BON
      4204 EMPRUNTABLE		ABIME
*/

prompt  ---- Q8 : Quels sont les exemplaires (numéro) reproduisant le même livre que l'exemplaire de numéro 4112 et dont l'état est : « BON » ?


/*
select numero from exemplaire  where ISBN=(select ISBN from exemplaire where numero=4112) and etat='BON' and numero<>4112;

*/

/*
    NUMERO
----------
      3702
      3703
      4111
*/


prompt ---- Q9 : Existe-t-il une catégorie pour laquelle aucun livre n'a été emprunté ?

/*
VOTRE REPONSE ICI
*/
         
/*
CATEGORIE
----------
POEME
*/

prompt ---- Q9 : Existe-t-il une catégorie pour laquelle aucun livre n'a été emprunté ? (seconde version)

/*
select categorie from livre
where categorie not in(select categorie from livre join exemplaire on exemplaire.isbn=livre.isbn) 
;

*/

/*
CATEGORIE
----------
POEME
*/


prompt ---- Q10 : Quel est le nombre d'emprunt en cours de l'abonné Renard Albert ? 

/*
select count(*) from emprunt join abonne on abonne.NUM_AB=emprunt.NUM_AB where abonne.nom='RENARD' and abonne.prenom='ALBERT' and D_RET_REEL IS NULL;

*/

/*
EMPRUNTS D ALBERT RENARD
------------------------
		       2
*/


prompt ---- Q11 : Quelle est la catégorie de livres pour laquelle l'exemplaire le plus cher a été acheté ? 

/*
select categorie from livre 
join exemplaire on exemplaire.ISBN=livre.ISBN 
where prix<=ALL(select prix from exemplaire);

*/

/*
CATEGORIE
----------------
ROMAN
*/

prompt ---- Q12 : Existe-t-il des exemplaires dans l'état « Abimé » et qui sont actuellement empruntés ? Si oui, donner leur numéro.

/*
select numero from exemplaire 
join emprunt on emprunt.num_ex=exemplaire.numero
where etat='ABIME' and D_RET_REEL is NULL;

*/

/*
    NUMERO
----------
      2673
      4204
*/

prompt -- Q13 : Existe-t-il des mots clefs ne caractérisant aucun livre ?

/*
select mot from mot_clef
where mot not in (select mot from caracterise)
group by mot;

*/

/*
MOT
--------------------
MEDECINE
NOUVELLE
*/

prompt --- Q14 : Donner le nombre d'emprunts effectués par chacun des abonnés (numéro, nom) pour chacune des catégories de livres proposées.

/*
select categorie, count(*) nb_emprunt, abonne.num_ab, nom from abonne
join emprunt on abonne.num_ab = emprunt.num_ab
join exemplaire on num_ex = numero
join livre on exemplaire.isbn = livre.isbn
group by categorie, abonne.num_ab, nom;

*/


/*
    NUM_AB NOM		   CATEGORIE	      COUNT(*)
---------- --------------- ---------------- ----------
    911023 DUPONT	   NOUVELLE		     1
    921102 LUCAS	   NOUVELLE		     2
    902043 DUPONT	   HISTOIRE		     2
    902075 RENARD	   NOUVELLE		     1
    922016 MEUNIER	   NOUVELLE		     1
    932010 ANTON	   NOUVELLE		     1
    901001 LEVEQUE	   NOUVELLE		     2
    911007 MARTIN	   ROMAN		     3
    911023 DUPONT	   SCIENCES		     1
    921102 LUCAS	   ROMAN		     2
    922143 REVEST	   NOUVELLE		     1
    901001 LEVEQUE	   HISTOIRE		     2
    911007 MARTIN	   NOUVELLE		     3
    911021 DUPONT	   ROMAN		     1
    911021 DUPONT	   NOUVELLE		     1
    911023 DUPONT	   ROMAN		     4
    902043 DUPONT	   NOUVELLE		     1
    901001 LEVEQUE	   ROMAN		     1
    902043 DUPONT	   SCIENCES		     2
    902075 RENARD	   ROMAN		     2
    911022 DUPONT	   NOUVELLE		     1

21 lignes selectionnees.
*/


prompt --- Q15 : Donner, pour chaque livre (numéro ISBN) ayant plus de deux exemplaires, le prix moyen d'achat des exemplaires.

/*
select livre.isbn,AVG(prix) from livre 
join exemplaire on exemplaire.isbn=livre.isbn
group by livre.isbn
having count(*)>2;

*/

/*
ISBN		TITRE						   PRIX MOYEN
--------------- -------------------------------------------------- ----------
0_18_47892_2	UNE ROSE POUR MORRISSON 				   50
9_782070_36	LA PERLE					   60,6666667
3_505_13700_5	LE GRAND VESTIAIRE					   63
1_104_1050_2	LE MUR						   36,3333333
1_22_1721_3	LE NOM DE LA ROSE					 34,5
2_7296_0040	GODEL ESCHER BACH : LES BRINS D UNE GUIRLANDE		   42

6 lignes selectionnees.
*/


prompt --- Q16 : Quel est l’abonné ayant effectué le plus d’emprunts ?

/*
select abonne.num_ab,nom from abonne
join emprunt on emprunt.num_ab=abonne.num_ab
group by abonne.num_ab,nom
having count(*)>= all(select count(*) from emprunt group by num_ab);

*/

/*
    NUM_AB NOM
---------- ---------------
    911023 DUPONT
    911007 MARTIN
*/

prompt --- Q17 : Donnez, pour chaque livre (numéro ISBN et titre) emprunté au moins deux fois, son nombre d’exemplaires en catégorie "Exclu". 

/* todo : a refaire */
/* 
Select livre.isbn, titre
from Livre
Join Exemplaire ON livre.ISBN = exemplaire.ISBN
Join Emprunt ON Numero = Num_ex
Group by livre.ISBN, titre
having count(*) >= 2

Select count(*) NbExclu from exemplaire where code_pret = 'EXCLU'
group by isbn
*/

/*
ISBN		TITRE						   Nombre exemplaires
--------------- -------------------------------------------------- ------------------
2_7296_0040	GODEL ESCHER BACH : LES BRINS D UNE GUIRLANDE			    1

*/

prompt -- Q18 : Existe t'il des homonymes (NUM_AB, NOM) parmi les abonnés ? Attention dans le résultat il ne faut ne pas dupliquer l'information. Par exemple si deux abonnés s'appellent DUPOND le résultat à obtenir est : 
prompt -- 1 DUPOND
prompt -- 2 DUPOND


/*
Select num_ab, nom from Abonne
Where nom IN(Select nom from Abonne group by nom having count(*) > 1)
*/


/*
    NUM_AB NOM
---------- ---------------
    911021 DUPONT
    911022 DUPONT
    911023 DUPONT
    902043 DUPONT
*/

prompt --- Q19 : Existe-t'il des catégories de livres empruntées par tous les abonnés ?

prompt --- Q19 Premiere possibilité
/*
VOTRE REPONSE ICI
*/

/*
CATEGORIE
----------------
NOUVELLE
*/

prompt --- Q19 Deuxième possibilité

/*
VOTRE REPONSE ICI
*/

/*
CATEGORIE
----------------
NOUVELLE
*/


prompt -- Q20 : Quels sont les livres (numéro ISBN et titre) dont tous les exemplaires valent plus de 30 euros ?


prompt -- Q20 - Première possibilité : 
/*
VOTRE REPONSE ICI
*/

/*
ISBN		TITRE
--------------- --------------------------------------------------
0_12_27550_2	NEW APPLICATIONS OF DATABASES
0_15_270500_3	LE MIRACLE DE LA ROSE
0_18_47892_2	UNE ROSE POUR MORRISSON
0_201_14439_5	AN INTRODUCTION TO DATABASE SYSTEMS
0_85_4107_3	L ENFANT
1_104_1050_2	LE MUR
2_7296_0040	GODEL ESCHER BACH : LES BRINS D UNE GUIRLANDE
3_505_13700_5	LE GRAND VESTIAIRE

8 lignes selectionnees.
*/


prompt -- Q20 - Deuxième possibilité : 

/*
VOTRE REPONSE ICI
*/

/*
ISBN		TITRE
--------------- --------------------------------------------------
0_12_27550_2	NEW APPLICATIONS OF DATABASES
0_15_270500_3	LE MIRACLE DE LA ROSE
0_18_47892_2	UNE ROSE POUR MORRISSON
0_201_14439_5	AN INTRODUCTION TO DATABASE SYSTEMS
0_85_4107_3	L ENFANT
1_104_1050_2	LE MUR
2_7296_0040	GODEL ESCHER BACH : LES BRINS D UNE GUIRLANDE
3_505_13700_5	LE GRAND VESTIAIRE

8 lignes selectionnees.
*/


prompt -- Q21 : Quels sont les livres (numéro ISBN et titre) dont tous les exemplaires valant plus de 30 euros ont été au moins trois fois empruntés ?


/*
VOTRE REPONSE ICI
*/

/*
ISBN		TITRE
--------------- --------------------------------------------------
0_112_3785_5	POESIES COMPLETES
0_8_7707_2	BASES DE DONNEES RELATIONNELLES
0_26_28079_6	FUNDAMENTALS OF DATABASE SYSTEMS
*/

prompt --- Q22 Faire 5 requêtes différentes affichant les mots clés des ouvrages pour les numéros ISBN 0_15_270500_3, 0_201_14439_5, 0_12_27550_2, 0_26_28079_6 et 0_8_7707_2.

prompt --- Q22 - requête pour 0_15_270500_3


/*
VOTRE REPONSE ICI
*/

/*
MOT
--------------------
LITTERATURE
ROMAN
ESSAI
*/

prompt --- Q22 - requête pour 0_201_14439_5

/*
VOTRE REPONSE ICI
*/

/*
MOT
--------------------
SCIENCES
INFORMATIQUE
BASES DE DONNEES
*/

prompt --- Q22 - requête pour 0_12_27550_2

/*
VOTRE REPONSE ICI
*/

/*
MOT
--------------------
SCIENCES
SQL
BASES DE DONNEES
*/

prompt --- Q22 - requête pour 0_26_28079_6

/*
VOTRE REPONSE ICI
*/

/*
MOT
--------------------
SCIENCES
INFORMATIQUE
BASES DE DONNEES
SQL
*/

prompt --- Q22 - requête pour 0_8_7707_2


/*
VOTRE REPONSE ICI
*/

/*
MOT
--------------------
SCIENCES
SQL
BASES DE DONNEES
*/

prompt --- Q23 : Quels sont les livres caractérisés par exactement les mêmes mots clefs que l'ouvrage de numéro ISBN 0-8-7707-2 ? Penser à vérifier le résultat par rapport à la requête précédente.


/*
VOTRE REPONSE ICI
*/

/*
ISBN
---------------
0_12_27550_2
*/


prompt -- Q24 - Donner en une seule requête le nombre d'abonnés, de livres et d'exemplaires. 


/*
VOTRE REPONSE ICI
*/

/*
      NBAB   NBLIVRES NBEXEMPLAIRES
---------- ---------- -------------
	11	   13		 29
*/



         




