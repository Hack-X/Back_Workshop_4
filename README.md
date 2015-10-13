Workshop X - Cours extra (in progress)
=======

Objectifs de l'atelier :

* On ajoute la possibilité de géolocaliser les shows pour afficher ceux près de soi.

Prérequis :

* Atelier 3 réalisé.

# Workshop

### Etape 1 : on ajoute les champs latitude et longitude

Nous allons commencer par ajouter les champs latitude et longitude au modèle Show

		$ rails g migration AddLatitudeAndLongitudeToShow lat:float lng:float
		$ rake db:migrate
		
On va ensuite modifier le fichier `db/seeds.rb` pour y ajouter les locations de nos 2 salles de concert sous forme de lat et longitude.

```
  Show.create(
    name: "Mon premier Show",
    venue: "Salle Pleyel",
    description: "Concert blabla",
    capacity: 500,
    price: 30,
    image: "http://www.sallepleyel.fr/img/visuel/diaporama/salle_concert_scene.jpg",
    date: "2015-10-30",
    lat: 48.8771744,
    lng: 2.3013612
  )

  Show.create(
    name: "Sébastien Tellier",
    venue: "Nouveau Casino",
    description: "L'Aventura",
    capacity: 500,
    price: 36,
    image: "http://www.gqmagazine.fr/uploads/images/201421/cc/l_aventura_de_s__bastien_tellier_7651.jpeg",
    date: "2015-10-19",
    lat: 48.8658748,
    lng: 2.3757088
  )
 ```


Pour faciliter ce Workshop, plutôt que de mettre à jour les données on va détruire les données des Shows pour les recharger plutôt que de les faire évoluer, en droppant la base, puis on va la recréer, la migrer et la reremplir.

```
$ rake db:drop db:crate db:migrate db:seed

```
		
### Etape 2 : Ajout de la gem et premiers tests

#### Gem 

Nous allons ajouter maintenant au `Gemfile` la gem qui va nous permettre de faire des requêtes géolocalisées. On ajoute donc la ligne `gem 'geokit-rails'` puis on l'installe :

```
$ bundle install

```
#### Model 

Il faut ensuite ajouter la gem au model, on va donc modifier le fichier `show.rb` avec les lignes :

```
    acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng
```

#### TODO : Rails console

### Etape 3 : Ajout du controller, de la vue et des routes

#### Vue

On va ajouter dans le dossier `app/views/shows` un fichier `nearby.json.jbuilder` avec uniquement ceci à l'intérieur :

```
json.array!(@shows) do |show|
  json.extract! show, :id, :name, :venue, :description, :capacity, :price, :image, :date
  json.url show_url(show, format: :json)
end
```

C'est ce qui sera rendu si tout se passe bien après l'appel, et on pourra y ajouter plus tard la distance avec le point.

#### Routes

Nous allons ajouter une route qu'on appellera sur l'url `/shows/nearby`. Pour ça, on va ajouter une méthode à l'intérieur de la ressource show. On a donc remplacer dans le fichier `config/routes.rb` la ligne `resources :shows` par 

```
  resources :shows do
    collection do
      get 'nearby'
    end
  end

```

#### Controller

On a ajouter une nouvelle méthode au controller `app/controller/shows_controller.rb` :

```
  def nearby
    distance = params[:distance] || 1
    @shows = Show.within(distance, :units => :kms, :origin => [params[:lat], params[:lng]])
  end

```

 
### Etape 4 : On teste !

Nous allons maintenant effectuer dans notre navigateur la requête `http://localhost:3000/shows/nearby.json?lat=48.8658748&lng=2.3757088&distance=1` : on veut afficher les shows proche du nouveau Casino. On verra a début un seul show dans ce cas.

On va maintenant augmenter la distance en effectuant cette requête `http://localhost:3000/shows/nearby.json?lat=48.8658748&lng=2.3757088&distance=10` : on a élargi le rayon et maintenant on voit les 2 shows !
