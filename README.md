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

	name # le nom du concert
	venue # le nom de la salle
	description # la description
	capacity # la capacité du show	
	price # le prix
	image # l'url de l'image
	date # la dte tu concert


* On va ensuite générer un scaffold, qui est un raccourci de Rails générant à la fois les vues, le controller, le modèle et les routes

		$ rails g scaffold Show name:string venue:string description:string capacity:integer price:integer image:string date:date
	
* A ce moment là, Rails a créé un fichier de migration, qui correspond aux modifications qui vont être appliquées à la base de données. Ces modifications sont  dans un fichier présent dans le dossier `db/migrate/` : allez voir son contenu pour comprendre ce qu'il réalise. On va ensuite l'appliquer avec la commande 

	$ rake db:migrate
	== 20141005134740 CreateShows: migrating ======================================
	-- create_table(:shows)
   		-> 0.0334s
	== 20141005134740 CreateShows: migrated (0.0336s) =============================
	
* Ensuite, vous pouvez relancer votre serveur avec la commande `rails s` et ensuite ouvrez cette adresse avec votre navigateur préféré (Chrome) : [http://localhost:3000/shows](http://localhost:3000/shows)

Avec ce **scaffold**, vous avez généré automatiquement le code permettant de créer, administrer, modifier des shows. Je vous invite fortement à aller regarder précisément ces différents fichiers/dossiers :

* Le dossier `app/controllers` qui contient le controller shows qui va gérer tout ça
*  Le dossier `app/views/shows` qui contient les vues (le HTML) ainsi que le formulaire par exemple.
*  Le dossier `app/models`  qui contient les modèles et en l'occurence le modèle `show` en l'occurence.
*  Le fichier `config/routes.rb` qui contient les routes faisant le lien entre l'URL et le controller.


Maintenant que vous avez un embryon de backoffice, commencez par créez 2-3 shows en remplissant chacun des champs, et le champs image par une url comme celle là pour le moment : http://www.woueb.net/wp-content/uploads/2010/12/salle-de-concert-360.jpg



	
### Etape 3 : Mettons un peu de style

Dans cette partie, nous allons mettre un peu de style dans tout ça en utilisant [Twitter Bootstrap](getbootstrap.com)

* Nous allons commencer par ajouter la gem bootstrap pour intégrer Bootstrap plus facilement. On ajoute la ligne `gem "twitter-bootstrap-rails"` au fichier Gemfile, et on va ensuite dans son shell exécuter la commande `bundle install` pour installer cette Gem.

		$ bundle install


* Comme nous l'indique la documentation de cette gem [https://github.com/seyhunak/twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails) on va lancer cette commande pour installer les feuilles css 

		$ rails g bootstrap:layout application
		$ rails generate bootstrap:install static
		$ rails g bootstrap:themed Shows
		
		
BONUS : Pour mettre tout ça un peu à nos couleurs, nous avons effectué quelques modifications dans au niveau du style 

* Champs date : pour rendre le champs "Date" plus utilisable, nous avons remplacé dans le fichier `views/shows/_form.html.erb` la commande `f.date_select :date` par `f.text_field :date`.

* Nous avons aussi un peu modifié le fichier `layouts/application.html.erb` qui comprend le cadre global en terme de style de l'application.

* Nous avons aussi modifié le fichier `views/shows/_form.html.erb`

Voilà le résultat que nous avons obtenu :

<img src="images/show.png" alt="Show" style="width:400px">

<img src="images/index.png" alt="Index" style="width:400px">

### Etape 4 : les débuts de l'API JSON

Au préalable, il est important d'avoir un certain nombre de **shows** dans sa base de données (3-4 ou plus).

L'avantage de Rails, c'est qu'il vous a déjà ajouté une API en JSON au moment du scaffold sans vous le dire. Nous allons maintenant la découvrir pour comprendre comment ça fonctionne. Nous vous recommandons le navigateur Chrome dans cette partie du workshop avec une extension pour faciliter la vision de JSON avec l'extension JSONView [https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc)

* Vous allez commencer par vous rendre sur l'url [http://localhost:3000/shows](http://localhost:3000/shows) : cette URL correspond à l'INDEX, c'est à dire la liste des shows. 
* Vous allez maintenant ajouter un .json à la fin de l'url pour forcer Rails à vous répondre en JSON, comme il le fera avec l'application mobile : [http://localhost:3000/shows.json](http://localhost:3000/shows.json). Vous devez otenir quelque chose comme ça.

<img src="images/index-json.png" alt="Index JSON" style="width:400px">

* Nous allons ensuite choisir le premier Show et l'afficher en solo. Il a l'id 1 dans notre cas, pour l'afficher nous devons donc aller à l'URL [http://localhost:3000/shows/1](http://localhost:3000/shows/1) pour voir la version du backoffice, puis utiliser la même manière pour afficher la version JSON. Vous devez obtenir quelque chose comme ça :

<img src="images/show-json.png" alt="Index JSON" style="width:400px">

C'est de cette manière (en appelant cette API JSON) que nous communiquerons entre l'application mobile et l'API.

### Next STeps

* Pour pré






		

		










 
 

 





