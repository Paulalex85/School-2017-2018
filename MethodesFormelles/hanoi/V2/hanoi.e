class HANOI
	--
	-- Le jeu des tours de Hanoi
	--
--
	
creation {ANY}
	make

feature {}
	nb: INTEGER
			-- Taille des tours

	tower1, tower2, tower3: TOWER
	      -- Les 3 tours du jeu

feature {ANY}
	make is
			-- Creation du jeu et boucle principale
		do
			io.put_string("Hauteur des tours : ")
			io.flush
			io.read_integer
			nb := io.last_integer

			create tower1.full(nb)
			create tower2.empty(nb)
			create tower3.empty(nb)
			io.put_string("Situation au depart :%N")
			print_game
			tour_jeu
			io.put_string("Situation a la fin :%N")
			print_game
		end

	tour_jeu is
		local
			input1 : INTEGER
			input2 : INTEGER

			tour1 : TOWER
			tour2 : TOWER

			valeur_top : INTEGER
		do
			io.put_string("Situation au depart :%N")
			print_game
			io.put_string("Prendre piece dans la tour 1,2 ou 3 : ")
			io.flush
			io.read_integer
			input1 := io.last_integer
			if input1 = 1 or input1 = 2 or input1 = 3 then 
				io.put_string("Mettre piece dans la tour 1,2 ou 3 : ")
				io.flush
				io.read_integer
				input2 := io.last_integer
				if input2 = 1 or input2 = 2 or input2 = 3 then 
					if input1 = input2 then
						io.put_string("Selectionner une tour differente")
					else
						inspect input1
							when 1 then tour1 := tower1
							when 2 then tour1 := tower2
							when 3 then tour1 := tower3
						end
						inspect input2
							when 1 then tour2 := tower1
							when 2 then tour2 := tower2
							when 3 then tour2 := tower3
						end
						valeur_top := tour1.valeur_top_tower
						if tour2.peut_ajouter(valeur_top) and valeur_top > 0 then
							valeur_top := tour1.retirer_disque()
							tour2.ajouter_disque(valeur_top)
						else
							io.put_string("Deplacement impossible")
						end
					end
				else 
					io.put_string("Mauvaise entree")
				end
			else 
				io.put_string("Mauvaise entree")
			end
		tour_jeu
	end

	resolve (how_many: INTEGER; source, intermediate, destination : TOWER) is
			-- Algorithme recursif de resolution du jeu qui transfère how_many jetons de la tour source à la tour destination en passant par la tour intermediate
		local
			disque: INTEGER
		do
			if how_many > 0 then 
				resolve(how_many-1, source,destination ,intermediate)
				disque := source.retirer_disque()
				destination.ajouter_disque(disque)
				resolve(how_many-1, intermediate, source, destination)
			end
			
		end


	print_game is
			-- Affichage de l'etat courant de la partie
		local
			i: INTEGER
		do
		from
			i := nb
		until
			i = 0
		loop
			io.put_character(' ')
			tower1.afficher_etage(i)
			io.put_character(' ')
			tower2.afficher_etage(i)
			io.put_character(' ')
			tower3.afficher_etage(i)
			io.put_string("%N")
			i := i-1
		end
	
		from
			i:= (2 * (nb + 1) + 1) * 3 - 2
		until
			i = 0
		loop
			io.put_character('-')
			i := i - 1
		end
	   io.put_string("%N")

	end
	

end -- class HANOI
