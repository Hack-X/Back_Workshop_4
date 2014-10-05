Workshop X - Cours #2
=======

Objectifs de l'atelier :

* Réaliser une API et un backoffice pour l'application **Shows Tonight**

Prérequis :

* Atelier 1 réalisé. Nous allons continuer sur la même base. 

# Ressources

#### MySQL

Pour ce cours, nous utiliserons pour commencer la base de données **MySQL** qu'il vous faudra installer. 

Le plus simple est d'aller la chercher à cet endroit : [http://dev.mysql.com/downloads/mysql/5.5.html](http://dev.mysql.com/downloads/mysql/5.5.html).

A la fin de l'installation, vous devez avoir ceci en lançant la commande `mysql --version`
   
	$ mysql --version
    mysql  Ver 14.14 Distrib 5.6.20, for osx10.10 (x86_64) 
   
#### Interface d'administration

Vous pouvez télécharger ensuite un logiciel permettant de voir visuellement votre base de donnée. Nous vous recommandons ces logiciels :

* [http://www.sequelpro.com/](http://www.sequelpro.com/) sur Mac

##### Concepts

Dans cette partie, nous allons commencer à travailler sur notre API et notre backoffice (arrière-guichet pour ceux qui préfèrent). Nous allons pour cela générer un ensemble d'élément suivant le pattern MVC dont nous allons rapidement rappeler le principe ici :

* ** Un modèle ** : dans ce modèle, nous allons définir les champs, et c'est ensuite ce modèle qui effectuera les liens avec la base de données (sauvergarde, mise à jour etc...)
* ** Un Controller ** : Gestion des événements, synchronisation etc...
* ** Des vues ** : ces vues serviront à présenter l'interface utilisateur du backoffice
* ** Des routes ** : les routes permettent de faire le lien entre l'url et la méthode du controller.

Ressources utiles : 

* [http://fr.wikipedia.org/wiki/Mod%C3%A8le-vue-contr%C3%B4leur#Contr.C3.B4leur](http://fr.wikipedia.org/wiki/Mod%C3%A8le-vue-contr%C3%B4leur#Contr.C3.B4leur)
* [http://french.railstutorial.org/chapters/beginning#sec:mvc](http://french.railstutorial.org/chapters/beginning#sec:mvc)



# Workshop

### Etape 1 : Création de la base de données

* Nous allons commencer par ajouter la ligne `gem 'mysql' ` au ficher `Gemfile` : ce fichier contient tous les modules dont se sert notre application Rails, et cette gem va gérer la relation avec MySQL. Une fois la ligne ajoutée, il faut ensuite lancer la commande `bundle install` dans son Terminal / Console pour lancer l'installation de tous les modules recensés dans le Gemfile.

		$ bundle install

* Ensuite, nous allons modifier le fichier `config/database.yml`qui contient la configuration de notre base de données. Nous allons modifier la partie `development`(qui correspond à notre environnement de développement en local). Nous allons remplacer la partie `development` par ça :

		development:
 	 	  adapter: mysql
  		  host: localhost
  		  database: shows_tonight_dev # Nom_de_votre_app_dev
  		  username: root # Peut dépendre de votre install, comme le password
  		  password:
  		  pool: 5
  		  timeout: 5000
  		  
 * Enfin, nous allons maintenant créer cette base de donnée avec la commande 
 
 		$ rake db:create
 
 
Votre base de données est maintenant créée.
 
 
### Etape 2 : Génération du scaffold "shows"

L'idée est de réaliser une API gérant les concerts. Nous allons donc avec des Shows, contenant ces informations :

	name
	location
	description
	capacity
	price
	image


* On va ensuite générer un scaffold, qui est un raccourci de Rails générant à la fois les vues, le controller, le modèle et les routes

		$ rails g scaffold Show name:string location:string description:string capacity:integer price:integer image:string
	
* A ce moment là, Rails a créé un fichier de migration, qui correspond aux modifications qui vont être appliquées à la base de données. Ces modifications sont  dans un fichier présent dans le dossier `db/migrate/` : allez voir son contenu pour comprendre ce qu'il réalise. On va ensuite l'appliquer avec la commande 

	$ rake db:migrate
	== 20141005134740 CreateShows: migrating ======================================
	-- create_table(:shows)
   		-> 0.0334s
	== 20141005134740 CreateShows: migrated (0.0336s) =============================
	
* Ensuite, vous pouvez relancer votre serveur avec la commande `rails s` et ensuite ouvrez cette adresse avec votre navigateur préféré (Chrome) : [http://localhost:3000/shows](http://localhost:3000/shows)

	
### Etape 2
	







 
 

 





