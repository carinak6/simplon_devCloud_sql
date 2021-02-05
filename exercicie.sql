#EXERCICE SQL
/*1.	Obtenir la liste des 10 villes les plus peuplées en 2012 */
SELECT ville_nom, ville_population_2012 
FROM villes_france_free 
ORDER BY ville_population_2012 DESC 
LIMIT 10

/*2.	Obtenir la liste des 50 villes ayant la plus faible superficie */
SELECT ville_nom, ville_surface 
FROM villes_france_free 
ORDER BY ville_surface ASC limit 50

/*3.	Obtenir la liste des départements d’outres-mer, c’est-à-dire ceux dont le numéro de département commencent par “97”*/
SELECT departement_nom , departement_code
FROM departement 
WHERE departement_code LIKE '97%'

/*4.	Obtenir le nom des 10 villes les plus peuplées en 2012, ainsi que le nom du département associé */
SELECT ville_nom, v.ville_population_2012 
FROM villes_france_free as v, departement as d  
WHERE d.departement_code = v.ville_departement 
ORDER BY v.ville_population_2012 DESC 
LIMIT 10

/*5.	Obtenir la liste du nom de chaque département, associé à son code et du nombre de commune au sein de ces département, en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes
*/
SELECT d.departement_nom, v.ville_departement, COUNT(v.ville_departement) as villes_dpto
FROM villes_france_free v, departement d 
WHERE d.departement_code = v.ville_departement 
GROUP BY v.ville_departement, d.departement_nom
ORDER BY COUNT(v.ville_departement) DESC;

/*6.	Obtenir la liste des 10 plus grands départements, en terme de superficie */

SELECT d.departement_nom, SUM(v.ville_surface) as "superfice"
FROM departement d 
INNER JOIN villes_france_free v ON v.ville_departement = d.departement_code  
GROUP BY d.departement_code, d.departement_nom 
ORDER BY SUM(v.ville_surface) DESC 
LIMIT 10;


/*7.	Compter le nombre de villes dont le nom commence par “Saint” */

SELECT COUNT(*) 
FROM villes_france_free v 
WHERE v.ville_nom LIKE "Saint%";


/*8.	Obtenir la liste des villes qui ont un nom existants plusieurs fois, et trier afin d’obtenir en premier celles dont le nom est le plus souvent utilisé par plusieurs communes */

SELECT ville_nom 
FROM villes_france_free
WHERE ville_nom IN (SELECT ville_nom from villes_france_free)
---
SELECT ville_nom, COUNT(*) 
FROM villes_france_free 
GROUP BY ville_nom 
HAVING COUNT(*) > 1 
ORDER BY COUNT(*) DESC
LIMIT 10 ;


/*9.	Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieur à la superficie moyenne */

/* pour avoir la moyene des surfaces
SELECT AVG(ville_surface)
FROM villes_france_free*/
 /*
+--------------------+
| AVG(ville_surface) |
+--------------------+
|  17.25737493077501 |
+--------------------+
1 row in set (0.02 sec)*/

SELECT ville_nom, ville_surface 
FROM villes_france_free 
WHERE ville_surface > (SELECT AVG(ville_surface) FROM villes_france_free) 
ORDER BY ville_surface DESC 
LIMIT 10

/*10.	Obtenir la liste des départements qui possèdent plus de 2 millions d’habitants */

SELECT departement_nom, ville_departement, SUM(ville_population_2012) 
FROM villes_france_free  
INNER JOIN departement ON departement_code = ville_departement 
GROUP BY ville_departement, departement_nom  
HAVING SUM(ville_population_2012) > 2000000;

/*11.	Remplacez les tirets par un espace vide, pour toutes les villes commençant par “SAINT-” (dans la colonne qui contient les noms en majuscule)*/

SELECT REPLACE(ville_nom, "-"," ")
FROM villes_france_free
WHERE ville_nom LIKE "SAINT-%"

/*\G  pour afficher les resultat ordonnée, plus jolie*/