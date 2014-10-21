Workshop X - Cours #3
=======

Objectifs de l'atelier :

* Finaliser l'API en ajoutant une notion de réservation (Booking)
* Déployer l'application sur Heroku

Prérequis :

* Atelier 2 réalisé. Nous allons continuer sur la même base, quelque soit la base de données utilisée (mysql ou sqlite)

# Préambule

Contrairement au cours précédent où nous avons utilisé un scaffold, nous allons cette fois générer un modèle, puis les méthodes et les routes dont nous avons besoin à la main.

<img src="images/schema.png" alt="Schema" style="width:600px">

Comme vous pouvez le voir sur ce schéma, nous allons créer un modèle Booking correspondant à la réservation que l'on veut réaliser. Quand l'utilisateur voudra réserver, il mettra son nom et le nombre de places qu'il veut et réservera.
Concrètement dans le code, ça veut dire plusieurs choses :

* On va avoir une relation entre nos Shows et Booking du type 1 - n : cela veut dire qu'un Show aura plusieurs Bookings, et qu'un Booking ``belongs_to``un Show.
* On va créer sur un show une action book du type ``POST`` sur une url du type ``monapi.com/shows/:id_de_mon_show/book`` où on enverra les données du post (nombre de personnes et nom de la personne qui réserve)


# Workshop


### Etape 1 : Ajout du modèle booking

Nous allons commencer par générer notre modèle uniquement en précisant, puis effectuer une migration de la base de données pour qu'elle se mette à jour.

		$ rails g model Booking user_name:string number:integer show:references
		$ rake db:migrate
		
### Etape 2 : Ajout de la méthode book dans le controller

Nous allons maintenant aller dans le fichier ``app/controllers/shows_controller.rb`` pour ajouter une nouvelle méthode ``book``qui correspondra à notre action de réservation.

Il faut ajouter cette ligne au début du fichier, après le ``before_action``

		class ShowsController < ApplicationController
  			before_action :set_show, only: [:show, :edit, :update, :destroy, :book]

  			# On saute une etape de securite si on appel BOOK en JSON
  			skip_before_action :verify_authenticity_token, only: [:book]
  			
  			[...]
  			
  			# POST /shows/1/book.json
  			def book
    			@booking = Booking.new(booking_params)

    			respond_to do |format|
      				if @booking.save
        				format.json
      				else
        				format.json { render json: @booking.errors, status: :unprocessable_entity }
      				end
    			end
  			end

		 private
		   # Use callbacks to share common setup or constraints between actions.
		   def set_show
		     @show = Show.find(params[:id])
		   end
		
		   # Never trust parameters from the scary internet, only allow the white list through.
		   def show_params
		    	params.require(:show).permit(:name, :location, :description, :capacity, :price, :image, :date)
		   end
		
		   def booking_params
		     params.require(:booking).permit(:user_name, :seats)
		   end
		end
		
	
		


		
 
 

 





